import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="discount"
export default class extends Controller {
static targets = ["discount", "total", "subtotal", "payment", "cashCheckout","paypayCheckout"];

  connect() {
    this.observeDOMChanges();

  }

  updateTotal() {
    let subtotal = parseInt(this.subtotalTarget.textContent.replace(/[¥,]/g, ''));
    let discountedAmount = Math.round(subtotal * (this.discountTarget.value / 100));
    let newTotal = subtotal - discountedAmount;

    const yenFormatter = new Intl.NumberFormat("ja-JP", {
      style: "currency",
      currency: "JPY"
    });

    const formattedYen = yenFormatter.format(newTotal);
    this.totalTarget.textContent = `${formattedYen}`;
  }

  selectPayment() {
    const paymentOptionElement = this.paymentTarget;
    console.log(paymentOptionElement.value)
    if (paymentOptionElement.value == "paypay") {
      this.paypayCheckoutTarget.classList.remove("d-none");
      this.cashCheckoutTarget.classList.add("d-none");
    } else if (paymentOptionElement.value == "cash") {
      this.paypayCheckoutTarget.classList.add("d-none");
      this.cashCheckoutTarget.classList.remove("d-none");
    }
  }


  observeDOMChanges() {
    const observer = new MutationObserver(() => {
      if (this.hasSubtotalTarget) {
        this.updateSubtotal();
        observer.disconnect();
      }
    });

    observer.observe(this.element, { childList: true, subtree: true });
  }

  updateSubtotal() {
    const subtotalElement = this.subtotalTarget;
    const subtotalStr = subtotalElement.textContent.replace(/[¥,]/g, '');
    const originalSubtotal = parseFloat(subtotalStr);

    subtotalElement.dataset.originalSubtotal = originalSubtotal;
  }
}
