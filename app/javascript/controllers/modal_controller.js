import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['modal', "background", "imagePreview", "foodName", "foodCalorie", "foodPrice", "foodTags"];

  showPreview(params) {
    if(params.source) {
      this.imagePreviewTarget.src = params.source;
    } else {
      this.imagePreviewTarget.src = "/assets/no_image.jpg"
    }
    this.foodNameTarget.textContent = params.name;
    this.foodCalorieTarget.textContent = params.calorie + "kcal"
    this.foodPriceTarget.textContent = params.price + "円"
    const foodTagsTarget = this.foodTagsTarget;
    foodTagsTarget.innerHTML = '';
    if (params.tags) {
      const tags = JSON.parse(params.tags);
      tags.forEach((tag) => {
        const span = document.createElement("span");
        span.textContent = tag;
        this.foodTagsTarget.appendChild(span);
      });
    }
  }

  handleOpen(event) {
    event.preventDefault();
    this.modalTarget.classList.remove("hidden");
    this.backgroundTarget.classList.remove("opacity-0");
    this.backgroundTarget.classList.add("opacity-100");
    this.showPreview(event.params);
    console.log(event.params)
  }

  handleClose(event) {
    event.preventDefault();
    this.modalTarget.classList.add("hidden");
    this.backgroundTarget.classList.remove("opacity-100");
    this.backgroundTarget.classList.add("opacity-0");
    this.foodTagsTarget.innerHTML = '';
  }
}