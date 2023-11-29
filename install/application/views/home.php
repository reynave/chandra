<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>POS Installer ver 1.0.5</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-12 mb-3">
                <h4 class="text-center">INSTALL POS</h4>
            </div>
            <div class="col-12">
                <div class="card mb-3">
                    <div class="card-header">
                        <h5 class="card-title"> Step 1 : Database
                            <?= (int) $checkDb; ?>
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <?php if ((int) $checkDb == 0) { ?>
                                    <p>Database belum tersedia, klik tombol dibawah untuk mebuat database</p>
                                    <a href="./setup/mydb" class="btn btn-primary">CRATED DATABASE</a>
                                <?php } else { ?>
                                    <p>Database sudah terinstall</p>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                </div>

                <?php if ((int) $checkDb == 1) { ?>
                    <div class="card mb-3">
                        <div class="card-header">
                            <h5 class="card-title"> Step 2 : Tables</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">

                                    <p>Setup table / setup ulang Table POS</p>
                                    <a href="./setup/tables" class="btn btn-primary">SETUP TABLES</a>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card mb-3">
                        <div class="card-header">
                            <h5 class="card-title"> Step 3 : Create dotENV (Environment) POS</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>create .env file lokasi di folder <strong>api/.env</strong> </p>
                                    <?php
                                    $host = $_SERVER['HTTP_HOST'];
                                    //   $uri = $_SERVER['REQUEST_URI'];
                                    $url = "http://$host";
                                    echo "URL: $url";
                                    ?>

                                    <form action="./setup/env" method="post">
                                        <table class="table">
                                            <tbody>
                                                <tr>
                                                    <td width="25%">API</td>
                                                    <td>
                                                        <input type="text" class="form-control" value="<?= $url ?>/chandra/api/public/"
                                                            id="api" name="api">
                                                        <div>
                                                            <small>contoh : http://localhost/[FOLDER-SAYA]/api/public/</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <a href="javascript:;" id="testApi">Test Link</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>SERVER API Location</td>
                                                    <td>
                                                        <input type="text" class="form-control" value="http://192.168.0.0/cso-api/"    id="apiServer" name="apiServer">
                                                    </td>
                                                    <td>
                                                        <a href="javascript:;" id="testApiServer">Test Link</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>SOCKET (cloud / localhost)</td>
                                                    <td>
                                                        <input type="text" class="form-control" value="<?= $url ?>:3000"  id="socket" name="socket">
                                                    </td>
                                                    <td>
                                                        <a href="javascript:;" id="testSocket">Test Link</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>SYNC FOLDER</td>
                                                    <td>
                                                        <input type="text" class="form-control"  value="C:/xampp/htdocs/chandra/sync/">
                                                    </td>
                                                    <td>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td>
                                                        <button type="submit" class="btn btn-primary" value="Submit">CREATE
                                                            ENV FILE</button>
                                                        <!-- <a href="./setup/env" class="btn btn-primary">CREATE ENV FILE</a> -->
                                                    </td>
                                                    <td></td>

                                                </tr>
                                            </tbody>
                                        </table>
                                    </form>


                                </div>
                            </div>
                        </div>
                    </div>

                <?php } ?>

            </div>

            <div class="col-12">
                <p class="text-end">
                    <small>Page rendered in <strong>{elapsed_time}</strong> seconds.
                        <?php echo (ENVIRONMENT === 'development') ? 'CodeIgniter Version <strong>' . CI_VERSION . '</strong>' : '' ?>
                    </small>
                </p>

            </div>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

    <script>
        $(document).ready(function(){
            $("#testApi").click(function(){ 
                window.open($("#api").val(),"_blank");
            }); 
             $("#testApiServer").click(function(){ 
                window.open($("#apiServer").val(),"_blank");
            });
            $("#testSocket").click(function(){ 
                window.open($("#socket").val(),"_blank");
            });
        });
    </script>

    <script>
        document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] +
            ':35729/livereload.js?snipver=1"></' + 'script>')
    </script>
</body>

</html>