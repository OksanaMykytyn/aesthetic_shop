import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["track", "dot"];

  connect() {
    this.index = 0;
    this.total = this.dotTargets.length;
    this.update();
  }

  next() {
    this.index = (this.index + 1) % this.total;
    this.update();
  }

  prev() {
    this.index = (this.index - 1 + this.total) % this.total;
    this.update();
  }

  go(event) {
    this.index = Number(event.currentTarget.dataset.index);
    this.update();
  }

  update() {
    this.trackTarget.style.transform = `translateX(-${this.index * 100}%)`;

    this.dotTargets.forEach((dot, i) => {
      dot.classList.toggle("active", i === this.index);
    });
  }
}
