const payjp = () => {
  Payjp.setPublicKey("公開鍵の値"); 
  const form = document.getElementById("入力フォームのid"); 
  form.addEventListener("submit", function(e)  {
    e.preventDefault();
    const card = { 
      number: フォームに入力されたカード番号の値,
      name: フォームに入力されたカード名義人の値
      cvc: フォームに入力されたセキュリティコードの値,
      exp_month: フォームに入力された月の値,
      exp_year: `20${フォームに入力された年の値}`,
    };
    Payjp.createToken(card, function(status, response) {
      if (status === 200) {
        const token = response.id;
        const tokenObj = `<input value=${token} name='token_id' type="hidden">`; 
        const cardForm = document.getElementById("入力フォームのid");
        cardForm.insertAdjacentHTML("beforeend", tokenObj);
        document.getElementById("カード番号の入力フォームのid").removeAttribute("name");
        document.getElementById("カード名義人の入力フォームのid").removeAttribute("name");
        document.getElementById("セキュリティコードの入力フォームのid").removeAttribute("name");
        document.getElementById("月の入力フォームのid").removeAttribute("name");
        document.getElementById("年の入力フォームのid").removeAttribute("name");
        document.getElementById("入力フォームのid").submit();
      } else {
        alert("カード情報が正しくありません")
      } 
    });
  });
};
window.addEventListener("load", payjp);