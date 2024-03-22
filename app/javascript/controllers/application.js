import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

//リストにアーティストを追加するための検索サジェストのドロップダウン機能
// 検索サジェスト用の、turbo:loadが発生したとき（ページが読み込まれたとき）に実行する関数として設定
document.addEventListener('turbo:load', function() {
  var inputElement = document.getElementById('artist-name-input');
  if (inputElement) {
    inputElement.addEventListener('input', function(e) {
      var name = e.target.value;
      var listId = document.body.dataset.listId;
      if (name.length < 5) { // この文字数未満の場合は検索しない
        return;
      }

      fetch('/lists/' + listId + '/artists/search?name=' + encodeURIComponent(name))
        .then(function(response) {
          // レスポンスがエラーの場合は例外を出す
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(function(artists) {
          var dropdownList = document.getElementById('artist-dropdown-list');
          dropdownList.innerHTML = ''; // ドロップダウンリストをクリアする
          artists.forEach(function(artist) {
            var div = document.createElement('div');
            div.textContent = artist.name;
            div.classList.add('p-2', 'hover:bg-gray-200', 'cursor-pointer');
            div.addEventListener('click', function() {
              inputElement.value = artist.name;
              dropdownList.classList.add('hidden');
            });
            dropdownList.appendChild(div);
          });
          if (artists.length > 0) {
            dropdownList.classList.remove('hidden');
          } else {
            dropdownList.classList.add('hidden');
          }
        })
        // リクエストがエラーになった場合のエラーメッセが以下
        .catch(function(error) {
          console.error('There has been a problem with your fetch operation:', error);
        });
    });
    // ドロップダウンリスト以外の場所をクリックしたときにリストを非表示にする
    document.addEventListener('click', function(e) {
      var dropdownList = document.getElementById('artist-dropdown-list');
      if (dropdownList && !e.target.closest('#artist-dropdown')) {
        dropdownList.classList.add('hidden');
      }
    });
  }
});

//レコメンドボタンをクリックしたときのローディングアニメーション
let recommendButton = document.getElementById('RecommendButton');
if (recommendButton) {
  recommendButton.addEventListener('click', function() {
    this.outerHTML = `
      <div class="flex justify-center" aria-label="Loading">
        <div class="animate-ping h-2 w-2 bg-blue-500 rounded-full"></div>
        <div class="animate-ping h-2 w-2 bg-purple-500 rounded-full mx-4"></div>
        <div class="animate-ping h-2 w-2 bg-rose-500 rounded-full"></div>
      </div>
    `;
  });
}
