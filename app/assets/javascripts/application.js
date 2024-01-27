```javascript
var likeButton = document.getElementById('like-button');
var count = 0;

likeButton.addEventListener('click', function() {
  count++;
  document.getElementById('like-count').textContent = count;
});
```