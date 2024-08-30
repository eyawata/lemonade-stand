import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bottom-navbar"
export default class extends Controller {
  static targets = ['links', 'active' ]
  connect() {
    console.log("connected!");
    // this.changeColor(this.activeTarget);
  }

  changeColor(event) {
    this.linksTargets.forEach(link => {
      link.style.color = 'black';
    });
    event.target.style.color = "#FFD700";
  }
}
