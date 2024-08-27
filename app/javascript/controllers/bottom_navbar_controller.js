import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bottom-navbar"
export default class extends Controller {
  static targets = ['links', 'active' ]
  connect() {
    console.log("connected!");
    this.changeColor(this.activeTarget);
  }

  changeColor(event) {
    this.linksTargets.forEach(link => {
      link.style.color = 'black';
    });

    const element = event.currentTarget;
    element.style.color = '$primary-yellow';
    // this.linksTargets.forEach(link => {
    //   link.style.color = 'black';
    //   link.addEventListener('click', colorChange);
    // });

    // this.move(this.activeTarget);

    // const value = link.getAttribute('data-bottom-navbar-value');
    // this.linksTargets.forEach(link => {
    //   link.style.opacity = 1;
    // });

    // this.circleTarget.style.left = `${((circleWidth) + ((circleWidth * value) - 73)) / screenWidth * 100}%`;
    // this.circleTarget.innerHTML = link.innerHTML;
    // link.style.opacity = 0;
  }
}
