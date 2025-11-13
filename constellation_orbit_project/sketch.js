// Constellation orbit sketch with UI, keyboard shortcuts, and recording.

let constellation = [];
let n;
let d;

// Orbit parameters
let theta = 0;
let baseR;
let cx, cy;
let dynamicR;
let orbitX;
let orbitY;

// GUI elements
let speedSlider;
let speedRandSlider;
let radiusVarSlider;
let controlsDiv;
let statusDiv;
let controlsVisible = true;

// Pause / playback
let isPaused = false;

// Recording
let pgCanvas;
let isRecording = false;
let mediaRecorder = null;
let recordedChunks = [];
let recordingSupported = true;
let recordingStatusMessage = "";

function setup() {
  pgCanvas = createCanvas(500, 500);
  pgCanvas.parent("canvas-container");

  pixelDensity(1);
  n = 200;

  constellation = [];
  for (let i = 0; i <= n; i++) {
    constellation.push(new Star());
  }

  strokeWeight(0.75);
  stroke("#FFFFFF");

  baseR = width / 4;
  cx = width / 2;
  cy = height / 2;

  dynamicR = baseR;
  orbitX = cx + baseR;
  orbitY = cy;

  setupControls();
  setupRecordingCapability();
}

function setupControls() {
  controlsDiv = select("#controls");
  statusDiv = select("#status");

  const speedRow = createDiv().addClass("control-row").parent(controlsDiv);
  createSpan("Orbit speed").parent(speedRow);
  speedSlider = createSlider(0, 0.05, 0.01, 0.001).parent(speedRow);

  const jitterRow = createDiv().addClass("control-row").parent(controlsDiv);
  createSpan("Orbit jitter").parent(jitterRow);
  speedRandSlider = createSlider(0, 0.02, 0.005, 0.001).parent(jitterRow);

  const radiusRow = createDiv().addClass("control-row").parent(controlsDiv);
  createSpan("Radius variability").parent(radiusRow);
  radiusVarSlider = createSlider(0, 100, 20, 1).parent(radiusRow);

  updateStatusMessage();
}

function setupRecordingCapability() {
  if (typeof MediaRecorder === "undefined") {
    recordingSupported = false;
    recordingStatusMessage = "Recording not supported in this browser.";
  } else {
    recordingStatusMessage = "Press S to start recording, E to stop.";
  }
  updateStatusMessage();
}

function draw() {
  background("#000000");

  const baseSpeed = speedSlider.value();
  const speedJitter = speedRandSlider.value();
  const radiusVar = radiusVarSlider.value();

  if (!isPaused) {
    dynamicR = baseR + random(-radiusVar, radiusVar);
    orbitX = cx + dynamicR * cos(theta);
    orbitY = cy + dynamicR * sin(theta);
    theta += baseSpeed + random(-speedJitter, speedJitter);

    for (let s of constellation) s.update(orbitX, orbitY);
  }

  drawOrbitVisualization(baseR, dynamicR, orbitX, orbitY);
  drawConstellationLines();
  drawRecordingIndicator();
}

function drawOrbitVisualization(br, cr, ox, oy) {
  push();
  noFill();
  stroke(255, 255, 255, 30);
  ellipse(cx, cy, br * 2, br * 2);

  stroke(255, 255, 255, 60);
  ellipse(cx, cy, cr * 2, cr * 2);

  fill(255);
  noStroke();
  ellipse(ox, oy, 6, 6);
  pop();

  noStroke();
  fill(200);
  textSize(10);
  text(`current radius: ${cr.toFixed(1)}`, 10, height - 10);
}

function drawConstellationLines() {
  for (let i = 0; i < constellation.length; i++) {
    for (let j = 0; j < i; j++) {
      d = constellation[i].loc.dist(constellation[j].loc);
      if (d <= width / 10) {
        line(constellation[i].loc.x, constellation[i].loc.y, constellation[j].loc.x, constellation[j].loc.y);
      }
    }
  }
}

function drawRecordingIndicator() {
  if (!isRecording) return;
  push();
  noStroke();
  fill(255, 0, 0);
  ellipse(width - 20, 20, 10, 10);
  fill(255);
  textSize(10);
  textAlign(RIGHT, CENTER);
  text("REC", width - 30, 20);
  pop();
}

class Star {
  constructor() {
    this.a = random(5 * TAU);
    this.r = random(width * 0.2, width * 0.25);
    this.loc = createVector(
      width / 2 + sin(this.a) * this.r,
      height / 2 + cos(this.a) * this.r
    );
    this.speed = p5.Vector.random2D();
    this.bam = createVector();
  }

  update(ox, oy) {
    this.bam = p5.Vector.random2D().mult(0.45);
    this.speed.add(this.bam);

    const m = constrain(
      map(dist(this.loc.x, this.loc.y, ox, oy), 0, width, 8, 0.05),
      0.05,
      8
    );
    this.speed.normalize().mult(m);

    if (dist(this.loc.x, this.loc.y, width / 2, height / 2) > width * 0.49) {
      this.loc.x = width - this.loc.x + random(-4, 4);
      this.loc.y = height - this.loc.y + random(-4, 4);
    }

    this.loc.add(this.speed);
  }
}

function keyPressed() {
  if (key === " ") { isPaused = !isPaused; return false; }
  if (key === "R" || key === "r") { resetSystem(); return false; }
  if (key === "S" || key === "s") { startRecording(); return false; }
  if (key === "E" || key === "e") { stopRecording(); return false; }
  return true;
}

function resetSystem() {
  theta = 0;
  constellation = [];
  for (let i = 0; i <= n; i++) constellation.push(new Star());
}

function startRecording() {
  if (!recordingSupported || isRecording) return;

  const stream = pgCanvas.elt.captureStream(60);
  mediaRecorder = new MediaRecorder(stream);
  recordedChunks = [];

  mediaRecorder.ondataavailable = (e) => recordedChunks.push(e.data);
  mediaRecorder.onstop = exportRecording;

  mediaRecorder.start();
  isRecording = true;
}

function stopRecording() {
  if (!isRecording) return;
  mediaRecorder.stop();
  isRecording = false;
}

function exportRecording() {
  const blob = new Blob(recordedChunks, { type: "video/webm" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = "constellation-recording.webm";
  a.click();
  URL.revokeObjectURL(url);
}

function updateStatusMessage() {
  select("#status").html(
    "Space=pause · R=reset · S/E=start/stop recording<br/>" + recordingStatusMessage
  );
}
