import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.getElementById('RecommendButton').addEventListener('click', function() {
    this.outerHTML = `
      <div class="flex justify-center" aria-label="Loading">
        <div class="animate-ping h-2 w-2 bg-blue-500 rounded-full"></div>
        <div class="animate-ping h-2 w-2 bg-purple-500 rounded-full mx-4"></div>
        <div class="animate-ping h-2 w-2 bg-rose-500 rounded-full"></div>
      </div>
    `;
  });