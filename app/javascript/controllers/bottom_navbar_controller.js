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
    const screenWidth = window.innerWidth;
    const circleWidth = screenWidth / 5;

    console.log(screenWidth);
    console.log(circleWidth);

    this.circleTarget.style.left = `${((circleWidth) + ((circleWidth * value) - 73)) / screenWidth * 100}%`;
    this.circleTarget.innerHTML = link.innerHTML;
    link.style.opacity = 0;
  }

}
