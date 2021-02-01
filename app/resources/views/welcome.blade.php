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
        <a href="{{ route('reportetres.consultar') }}"><p>Top Ganadores Le Mans (R3)</p></a>
        <a href="{{ route('reportecuatro.consultar') }}"><p>Resultados por número de equipo (R4)</p></a>
        <a href="{{ route('reportecinco.consultar') }}"><p>Losgros por piloto (R5)</p></a>
        <a href="{{ route('reporteseis.consultar') }}"><p>Paticipaciones por marca y modelo de auto (R6)</p></a>
        <a href="{{ route('reportesiete.consultar') }}"><p>Piloto mas joven del año (R7)</p></a>
        <a href="{{ route('reporteocho.consultar') }}"><p>Piloto mas veterano del año (R8)</p></a>
        <a href="{{ route('reportenueve.consultar') }}"><p>Mayor número de participaciones (R9)</p></a>
        <a href="{{ route('reportediez.consultar') }}"><p>Ganador en su primera participación (R10)</p></a>
        <a href="{{ route('reporteonce.consultar') }}"><p>Velcidades medias mas altas de la historia (R11)</p></a>
        <a href="{{ route('reportedoce.consultar') }}"><p>Distancia mas largas recorridas (R12)</p></a>
        <a href="{{ route('reportetrece.consultar') }}"><p>En el pódium, pero nunca ganador (R13)</p></a>
        <a href="{{ route('reportecatorce.consultar') }}"><p>Pilotos que nunca pisaron la meta de 24H (R14)</p></a>
        <a href="{{ route('reportequince.consultar') }}"><p>Victorias por marca (R15)</p></a>
        <a href="{{ route('reportedieciseis.consultar') }}"><p>Mujeres piloto (R16)</p></a>
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