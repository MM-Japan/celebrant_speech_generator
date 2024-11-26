// Correct import
import { Controller } from "@hotwired/stimulus"
import { Carousel } from "bootstrap"

export default class extends Controller {
  connect() {
    new Carousel(this.element)
  }
}
