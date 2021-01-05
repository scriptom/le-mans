<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Scripts -->
    <script src="{{ asset('js/app.js') }}" defer></script>

    <!-- Fonts -->


    <!-- Styles -->
    <link href="{{ asset('css/app.css') }}" rel="stylesheet">
    <link href="{{ asset('assets/css/master.css') }}" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


    <!-- swiper -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

    <!-- datatables -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.23/datatables.min.css"/>

    <!--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  
      <link rel="stylesheet" href="{{ asset('css/heroic-features.css') }}" type="text/css" href="">
      <link rel="stylesheet" type="text/css" href="{{ asset('DataTables/datatables.min.css') }}"/> -->
       


</head>
<body>
    <div id="app">
        <nav class="navbar navbar-expand-md navbar-light bg-white shadow-sm">
            <div class="container">
                <a class="navbar-brand" href="{{ url('/') }}">
                    {{ config('app.name', 'Laravel') }}
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="{{ __('Toggle navigation') }}">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <!-- Left Side Of Navbar -->
                    <ul class="navbar-nav mr-auto">

                    </ul>

                    <!-- Right Side Of Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R1</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R2</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R3</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R4</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R5</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R6</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R7</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R8</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R9</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R10</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R11</a></li>
                        <li><a class="nav-link" href="http://localhost/armatufiesta/public/tip">R12</a></li>

                    </ul>
                </div>
            </div>
        </nav>

        <main class="">
            @yield('content')
        </main>
    </div>


  <!-- <script src="vendor/jquery/jquery.min.js"></script> -->
  <!-- <script src="https://code.jquery.com/jquery-3.5.1.js" type="text/javascript"></script> -->
  <!-- <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js" type="text/javascript"></script> -->

  <!-- <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script> -->
  <!-- <script type="text/javascript" src="{{ asset('DataTables/datatables.min.js') }}"></script> -->

  <!-- <script type="text/javascript">
    $(document).ready(function() {
      $('#example').DataTable();
    } );
  </script> -->

  
    <!-- <script src="https://unpkg.com/@popperjs/core@2"></script>
    <script src="https://unpkg.com/tippy.js@6"></script> -->

        <!-- <script type="text/javascript">
      // With the above scripts loaded, you can call `tippy()` with a CSS
      // selector and a `content` prop:
      tippy('#myButton', {
        content: 'My tooltip!',
      });
    </script> -->






  <!-- <script src="vendor/jquery/jquery.min.js"></script> -->
  <!-- <script src="https://code.jquery.com/jquery-3.5.1.js" type="text/javascript"></script> -->
  <!-- <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js" type="text/javascript"></script> -->

  <!-- <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script> -->
  <!-- <script type="text/javascript" src="{{ asset('DataTables/datatables.min.js') }}"></script> -->

  <!-- <script type="text/javascript">
    $(document).ready(function() {
      $('#example').DataTable();
    } );
  </script> -->

  <!-- <script type="text/javascript">
    $(document).ready(function() {
      $('#example2').DataTable();
    } );
  </script> -->




<!-- bootstrap -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- swiper -->
<script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- datatables -->
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.23/datatables.min.js"></script>

@yield('scripts')


</body>
</html>