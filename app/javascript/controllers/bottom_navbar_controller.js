import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bottom-navbar"
export default class extends Controller {
  static targets = ['links', 'circle', 'active' ]
  static values = { value: Number }

  connect() {
    console.log("connected!");
    this.move(this.activeTarget);
    this.linksTargets.forEach(link => {
      link.addEventListener('click', this.moveCircle.bind(this));
    });
  }

  moveCircle(event) {
    const link = event.currentTarget;

    move(link)
  }

  move(link) {
    const value = link.getAttribute('data-bottom-navbar-value');
    this.linksTargets.forEach(link => {
      link.style.opacity = 1;
    });

    this.circleTarget.style.left = `${21 * value}vw`;
    this.circleTarget.innerHTML = link.innerHTML;
    link.style.opacity = 0;
  }

}
