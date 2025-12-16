import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "error"];

  clear(event) {
    const input = event.target;

    input.classList.remove("input-error");

    const error = input.closest("[data-field]").querySelector("[data-error]");

    if (error) {
      error.remove();
    }
  }
}
