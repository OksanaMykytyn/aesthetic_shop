import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  open() {
    this.menuTarget.classList.remove("-translate-x-full");
  }

  close() {
    this.menuTarget.classList.add("-translate-x-full");
  }
}
