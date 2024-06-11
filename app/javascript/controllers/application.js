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
      if (name.length < 4) { // この文字数未満の場合は検索しない
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

  // レコメンドボタンの要素を取得
  let recommendButton = document.getElementById('RecommendButton');
  // レコメンドボタンが存在する場合のみ以下の処理を実行
  if (recommendButton) {
    // クリックイベントのリスナーを設定
    recommendButton.addEventListener('click', function() {
      // hiddenになっているローディング画面を表示
      document.getElementById('loading-screen').classList.remove('hidden');
    });
  }

// Intersection Observer的なのを設定する
const options = {
  root: null,
  rootMargin: '0px',
  threshold: 0.1
};

// Intersection Observerのコールバック
const callback = (entries, observer) => {
  entries.forEach(entry => {
    // アニメーションクラスを取得
    const animationClass = entry.target.dataset.animationClass;

    if (entry.isIntersecting) {
      // 要素がビューポートに入ったとき、アニメーションクラスを追加
      entry.target.classList.add(animationClass);
    } else {
      // 要素がビューポートから出たとき、アニメーションクラスを削除（コメントアウト中）
      //entry.target.classList.remove(animationClass);
    }
  });
};

// Intersection Observerの作成
const observer = new IntersectionObserver(callback, options);

// 監視対象の要素
const target = document.getElementById('observed');

// 要素の監視を開始
observer.observe(target);

//end
});
