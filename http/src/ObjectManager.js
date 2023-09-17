export default class ObjectManager {
  constructor() {
    this.objects = new Map();
  }

  // Add an object with a name
  addObject(name, object) {
    this.objects.set(name, object);
  }

  // Remove an object by name
  removeObject(name) {
    if (this.objects.has(name)) {
      this.objects.delete(name);
    } else {
      console.log(`Object with name '${name}' not found.`);
    }
  }

  // Get an object by name
  getObject(name) {
    if (this.objects.has(name)) {
      return this.objects.get(name);
    } else {
      console.log(`Object with name '${name}' not found.`);
      return null;
    }
  }

  // Get all object names
  getObjectNames() {
    return Array.from(this.objects.keys());
  }
}
