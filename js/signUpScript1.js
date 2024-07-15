$(document).ready(function(){
    // Definir las ciudades por departamento
    const ciudadesPorDepartamento = {
        'Artigas': ['Artigas', 'Bella Unión', 'Tomás Gomensoro', 'Las Piedras'],
        'Canelones': ['Canelones', 'Santa Lucía', 'Las Piedras', 'Pando', 'La Paz', 'Toledo'],
        'Cerro Largo': ['Melo', 'Río Branco', 'Aceguá', 'Fraile Muerto', 'Arachania'],
        'Colonia': ['Colonia del Sacramento', 'Carmelo', 'Juan Lacaze', 'Nueva Helvecia', 'Tarariras'],
        'Durazno': ['Durazno', 'Sarandí del Yí', 'Carmen', 'Blanquillo', 'Sarandí Grande'],
        'Flores': ['Trinidad', 'Tranqueras', 'Andresito', 'Sarandí Grande'],
        'Florida': ['Florida', 'Cardal', '25 de Mayo', 'Independencia', 'Sarandí Grande'],
        'Lavalleja': ['Minas', 'José Pedro Varela', 'José Batlle y Ordóñez', 'Mariscala', 'Solís de Mataojo'],
        'Maldonado': ['Maldonado', 'Punta del Este', 'San Carlos', 'Piriápolis', 'Pan de Azúcar'],
        'Montevideo': ['Montevideo','Santiago Vazquez'],
        'Paysandú': ['Paysandú', 'Guichón', 'Quebracho', 'Tambores', 'Chacras de Paysandú'],
        'Río Negro': ['Fray Bentos', 'Young', 'Nuevo Berlín', 'San Javier', 'Las Cañas'],
        'Rivera': ['Rivera', 'Tranqueras', 'Vichadero', 'Lavalleja', 'Minas de Corrales'],
        'Rocha': ['Rocha', 'Castillos', 'Chuy', 'La Paloma', 'Valizas'],
        'Salto': ['Salto', 'Constitución', 'Mataojo', 'Rincón de Valentín', 'La Loma'],
        'San José': ['San José de Mayo', 'Libertad', 'Rodríguez', 'Ecilda Paullier', 'Rafael Perazza'],
        'Soriano': ['Mercedes', 'Dolores', 'Cardona', 'José Enrique Rodó', 'Santa Catalina'],
        'Tacuarembó': ['Tacuarembó', 'Paso de los Toros', 'San Gregorio de Polanco', 'Ansina', 'Curtina'],
        'Treinta y Tres': ['Treinta y Tres', 'Santa Clara de Olimar', 'Vergara', 'Valentines', 'General Enrique Martínez']
    };
    
    // Función para actualizar las opciones de ciudad
    function actualizarCiudades() {
        const selectedDepartamento = $('#departamento').val();
        const ciudades = ciudadesPorDepartamento[selectedDepartamento];
        const ciudadSelect = $('#ciudad');
        ciudadSelect.empty();
        $.each(ciudades, function(index, value) {
            ciudadSelect.append($('<option>').text(value));
        });
        ciudadSelect.prop('disabled', false);
    }
    
    // Escuchar cambios en el select de departamento
    $('#departamento').change(function() {
        actualizarCiudades();
    });
});