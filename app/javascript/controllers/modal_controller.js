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
    params.tags.forEach((tag) => {
      const tagDiv = document.createElement('div');
      tagDiv.textContent = tag;
      tagDiv.className = 'inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2';
      foodTagsTarget.appendChild(tagDiv);
    });
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