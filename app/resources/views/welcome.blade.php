@extends("layouts.app")
@section('content')

<div class="swiper-container swiper-home">
    <div class="swiper-wrapper">

      <div class="swiper-slide">
        <div class="contenedor-imagen-swiper">
            <img class="img-completa-swiper" src="{{ asset('assets/img/home/uno.jpg') }}" alt="">
        </div>
      </div>

      <div class="swiper-slide">
        <div class="contenedor-imagen-swiper">
            <img class="img-completa-swiper" src="{{ asset('assets/img/home/dos.jpg') }}" alt="">
        </div>
      </div>

      <div class="swiper-slide">
        <div class="contenedor-imagen-swiper">
            <img class="img-completa-swiper" src="{{ asset('assets/img/home/tres.jpg') }}" alt="">
        </div>
      </div>



      <div class="swiper-slide">
        <div class="contenedor-imagen-swiper">
            <img class="img-completa-swiper" src="{{ asset('assets/img/home/cuatro.jpg') }}" alt="">
        </div>
      </div>


      <div class="swiper-slide">
        <div class="contenedor-imagen-swiper">
            <img class="img-completa-swiper" src="{{ asset('assets/img/home/cinco.jpg') }}" alt="">
        </div>
      </div>      
    </div>

    <div class="home-contenido">
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="#"><p>Top Ganadores Le Mans (R3)</p></a>
    </div>

    <!-- Add Arrows -->
    <!-- <div class="swiper-button-next"></div> -->
    <!-- <div class="swiper-button-prev"></div> -->
</div>
@endsection

@section('scripts')
<script>
    var swiper = new Swiper('.swiper-home', {
        loop: true,
        effect: 'fade',
        autoplay: {
        delay: 5000,
        disableOnInteraction: false,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
</script>
@endsection