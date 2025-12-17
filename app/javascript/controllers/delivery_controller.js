import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["type", "courier", "branch", "postomat"];

  change() {
    this.hideAll();

    switch (this.typeTarget.value) {
      case "courier":
        this.courierTarget.classList.remove("hidden");
        break;
      case "branch":
        this.branchTarget.classList.remove("hidden");
        break;
      case "postomat":
        this.postomatTarget.classList.remove("hidden");
        break;
    }
  }

  hideAll() {
    this.courierTarget.classList.add("hidden");
    this.branchTarget.classList.add("hidden");
    this.postomatTarget.classList.add("hidden");
  }
}
