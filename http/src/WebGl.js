import * as THREE from "three";
import ObjectManager from "./ObjectManager.js";

export default class WebGL {
  /**
   *
   * @param {ObjectManager} objectManager
   */
  constructor(objectManager) {
    this.objectManager = objectManager;
    this.scene = new THREE.Scene();
    this.renderer = new THREE.WebGLRenderer();
    this.renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(this.renderer.domElement);

    this.addCamera();
    this.addBlock(0, 0, 0);
    this.render();
  }

  render() {
    this.renderer.render(this.scene, this.camera);
  }

  /**
   *
   * @param {number} x
   * @param {number} y
   * @param {number} z
   */
  addBlock(x, y, z) {
    const trainGeometry = new THREE.BoxGeometry(4, 2, 2);
    const trainMaterial = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
    const train = new THREE.Mesh(trainGeometry, trainMaterial);
    train.position.set(x, y, z); // Position the train slightly above the track
    this.scene.add(train);

    this.render();
  }

  addCamera() {
    this.camera = new THREE.PerspectiveCamera(
      75,
      window.innerWidth / window.innerHeight,
      0.1,
      1000
    );

    this.camera.position.set(0, 0, 5);
  }
}
