/*============
  目次
    トップページスライダー画像
    ハンバーガーメニュー
    トップへスクロールボタン
    タブ切替
    ヘッダーメニュー固定
=============*/

$(document).on('turbolinks:load', function() {

  // トップページスライダー画像用
    $('.slider-main').slick({
      responsive: [
        {
          breakpoint: 3000,
          settings: {
            accessibility: true,
            autoplay: true,
            autoplaySpeed: 5000,
            speed: 2000,
            slidesToShow: 1,
            centerMode: true,
            centerPadding: '100px',
            focusOnSelect: true,
            prevArrow: '<div class="prev"></div>',
            nextArrow: '<div class="next"></div>'
          }
        },
        {
          breakpoint: 600,
          settings: {
            accessibility: true,
            autoplay: true,
            autoplaySpeed: 3000,
            speed: 3000,
            slidesToShow: 1,
            focusOnSelect: true,
            prevArrow: '<div class="prev"></div>',
            nextArrow: '<div class="next"></div>'
          }
        },
      ]
    });
  // ------------------------

  // ハンバーガーメニュー用
    var $nav   = $('#navArea');
    var $btn   = $('.toggle_btn');
    var $mask  = $('#mask');
    var open   = 'open'; // class
    // menu open close
    $btn.on( 'click', function() {
      if ( ! $nav.hasClass( open ) ) {
        $nav.addClass( open );
      } else {
        $nav.removeClass( open );
      }
    });
    // mask close
    $mask.on('click', function() {
      $nav.removeClass( open );
    });
  // ------------------

  // トップへスクロールボタン用
    //スクロールした際の動きを関数でまとめる
    function PageTopAnime() {

      var scroll = $(window).scrollTop(); //スクロール値を取得
      if (scroll >= 200){//200pxスクロールしたら
        $('#page-top').removeClass('DownMove');		// DownMoveというクラス名を除去して
        $('#page-top').addClass('UpMove');			// UpMoveというクラス名を追加して出現
      }else{//それ以外は
        if($('#page-top').hasClass('UpMove')){//UpMoveというクラス名が既に付与されていたら
          $('#page-top').removeClass('UpMove');	//  UpMoveというクラス名を除去し
          $('#page-top').addClass('DownMove');	// DownMoveというクラス名を追加して非表示
        }
      }
      var wH = window.innerHeight; //画面の高さを取得
      var footerPos =  $('#footer').offset().top; //footerの位置を取得
      if(scroll+wH >= (footerPos+10)) {
        var pos = (scroll+wH) - footerPos+10 //スクロールの値＋画面の高さからfooterの位置＋10pxを引いた場所を取得し
        $('#page-top').css('bottom',pos);
        $('#phone-reservation-btn,#phone-reservation-show-btn').css('bottom',pos);
      }else{//それ以外は
        if($('#page-top').hasClass('UpMove')){//UpMoveというクラス名がついていたら
          $('#page-top').css('bottom','10px');// 下から10pxの位置にページリンクを指定
        }
        $('#phone-reservation-btn,#phone-reservation-show-btn').css('bottom','10px');
      }
    }

    // 画面をスクロールをしたら動かしたい場合の記述
    $(window).scroll(function () {
    PageTopAnime();/* スクロールした際の動きの関数を呼ぶ*/
    });

    // ページが読み込まれたらすぐに動かしたい場合の記述
    $(window).on('load', function () {
    PageTopAnime();/* スクロールした際の動きの関数を呼ぶ*/
    });

    // #page-topをクリックした際の設定
    $('#page-top').click(function () {
      $('body,html').animate({
          scrollTop: 0//ページトップまでスクロール
      }, 500);//ページトップスクロールの速さ。数字が大きいほど遅くなる
      return false;//リンク自体の無効化
    });
  // --------------------

  // タブ切替
    //任意のタブにURLからリンクするための設定
    function GethashID (hashIDName){
      if(hashIDName){
        //タブ設定
        $('.tab li').find('a').each(function() { //タブ内のaタグ全てを取得
          var idName = $(this).attr('href'); //タブ内のaタグのリンク名（例）#lunchの値を取得 
          if(idName == hashIDName){ //リンク元の指定されたURLのハッシュタグ（例）http://example.com/#lunch←この#の値とタブ内のリンク名（例）#lunchが同じかをチェック
            var parentElm = $(this).parent(); //タブ内のaタグの親要素（li）を取得
            $('.tab li').removeClass("active"); //タブ内のliについているactiveクラスを取り除き
            $(parentElm).addClass("active"); //リンク元の指定されたURLのハッシュタグとタブ内のリンク名が同じであれば、liにactiveクラスを追加
            //表示させるエリア設定
            $(".area").removeClass("is-active"); //もともとついているis-activeクラスを取り除き
            $(hashIDName).addClass("is-active"); //表示させたいエリアのタブリンク名をクリックしたら、表示エリアにis-activeクラスを追加 
          }
        });
      }
    }

    //タブをクリックしたら
    $('.tab a').on('click', function() {
      var idName = $(this).attr('href'); //タブ内のリンク名を取得  
      GethashID (idName);//設定したタブの読み込みと
      return false;//aタグを無効にする
    });


    // 上記の動きをページが読み込まれたらすぐに動かす
    $(window).on('load', function () {
        $('.tab li:first-of-type').addClass("active"); //最初のliにactiveクラスを追加
        $('.area:first-of-type').addClass("is-active"); //最初の.areaにis-activeクラスを追加
      var hashName = location.hash; //リンク元の指定されたURLのハッシュタグを取得
      GethashID (hashName);//設定したタブの読み込み
    });
  // -----

  // ヘッダーメニュー固定用
    let start_position = 0,     //初期位置0
    window_position,
    $window = $(window),
    $header = $('.header-menu');

    // スクロールイベントを設定
    $window.on( 'scroll' , function(){
        // スクロール量の取得
        window_position = $(this).scrollTop();
        this_position = $(this).scrollTop();
        
        // スクロール量が初期位置より小さければ，
        // 上にスクロールしているのでヘッダーフッターを出現させる
        var scroll = $(window).scrollTop(); //スクロール値を取得
        var headerPos =  $header.offset().top; //headerの位置を取得
        var windowWidth = window.innerWidth;
        if(windowWidth >= 600){
          if(scroll >= 70) {
            if (window_position <= start_position) {
              $header.css('top','0');
              $header.css('position','fixed');
            } else {
              $header.css('top','-70px');
            }
          } else {
            $header.css('top','70px');
            $header.css('position','static');
          }
        }
        // 現在の位置を更新する
        start_position = window_position;
        
    });
    // 中途半端なところでロードされても良いようにスクロールイベントを発生させる
    $window.trigger('scroll');
  // -----
});
