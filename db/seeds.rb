#branches
lima     = Branch.find_or_create_by(name: "Lima", code:"LIM20161")
mexico   = Branch.find_or_create_by(name: "México", code: "MEX20161")
santiago = Branch.find_or_create_by(name: "Chile", code: "CHI20161")
arequipa = Branch.find_or_create_by(name: "Arequipa", code: "AQP20161")

#groups
Group.find_or_create_by(name: "LIM20141", description: "Promoción LIM20141", branch: lima)
Group.find_or_create_by(name: "LIM20151", description: "Promoción LIM20151", branch: lima)
Group.find_or_create_by(name: "LIM20152", description: "Promoción LIM20152", branch: lima)
Group.find_or_create_by(name: "LIM20161", description: "Promoción LIM20161", branch: lima)
Group.find_or_create_by(name: "LIM20162", description: "Promoción LIM20162", branch: lima)
Group.find_or_create_by(name: "SCL20151", description: "Promoción SCL20151", branch: santiago)
Group.find_or_create_by(name: "SCL20161", description: "Promoción SCL20161", branch: santiago)
Group.find_or_create_by(name: "SCL20162", description: "Promoción SCL20162", branch: santiago)
Group.find_or_create_by(name: "MEX20151", description: "Promoción MEX20151", branch: mexico)
Group.find_or_create_by(name: "MEX20161", description: "Promoción MEX20161", branch: mexico)
Group.find_or_create_by(name: "MEX20162", description: "Promoción MEX20162", branch: mexico)
Group.find_or_create_by(name: "AQP20151", description: "Promoción AQP20151", branch: arequipa)
Group.find_or_create_by(name: "AQP20161", description: "Promoción AQP20161", branch: arequipa)
Group.find_or_create_by(name: "AQP20162", description: "Promoción AQP20162", branch: arequipa)

#districts
District.find_or_create_by(name: "Ancón", branch:lima)
District.find_or_create_by(name: "Ate", branch:lima)
District.find_or_create_by(name: "Barranco", branch:lima)
District.find_or_create_by(name: "Bellavista", branch:lima)
District.find_or_create_by(name: "Breña", branch:lima)
District.find_or_create_by(name: "Callao", branch:lima)
District.find_or_create_by(name: "Carabayllo", branch:lima)
District.find_or_create_by(name: "Carmen de la Legua - Reynoso", branch:lima)
District.find_or_create_by(name: "Chaclacayo", branch:lima)
District.find_or_create_by(name: "Chorrillos", branch:lima)
District.find_or_create_by(name: "Chosica", branch:lima)
District.find_or_create_by(name: "Cieneguilla", branch:lima)
District.find_or_create_by(name: "Comas", branch:lima)
District.find_or_create_by(name: "El Agustino", branch:lima)
District.find_or_create_by(name: "Independencia", branch:lima)
District.find_or_create_by(name: "Jesús María", branch:lima)
District.find_or_create_by(name: "La Molina", branch:lima)
District.find_or_create_by(name: "La Perla", branch:lima)
District.find_or_create_by(name: "La Punta", branch:lima)
District.find_or_create_by(name: "La Victoria", branch:lima)
District.find_or_create_by(name: "Lima", branch:lima)
District.find_or_create_by(name: "Lince", branch:lima)
District.find_or_create_by(name: "Los Olivos", branch:lima)
District.find_or_create_by(name: "Lurín", branch:lima)
District.find_or_create_by(name: "Magdalena del Mar", branch:lima)
District.find_or_create_by(name: "Miraflores", branch:lima)
District.find_or_create_by(name: "Pachacamac", branch:lima)
District.find_or_create_by(name: "Pucusana", branch:lima)
District.find_or_create_by(name: "Pueblo Libre", branch:lima)
District.find_or_create_by(name: "Puente Piedra", branch:lima)
District.find_or_create_by(name: "Punta Hermosa", branch:lima)
District.find_or_create_by(name: "Punta Negra", branch:lima)
District.find_or_create_by(name: "Rimac", branch:lima)
District.find_or_create_by(name: "San Bartolo", branch:lima)
District.find_or_create_by(name: "San Borja", branch:lima)
District.find_or_create_by(name: "San Isidro", branch:lima)
District.find_or_create_by(name: "San Juan de Lurigancho", branch:lima)
District.find_or_create_by(name: "San Juan de Miraflores", branch:lima)
District.find_or_create_by(name: "San Luis", branch:lima)
District.find_or_create_by(name: "San Martín de Porres", branch:lima)
District.find_or_create_by(name: "San Miguel", branch:lima)
District.find_or_create_by(name: "Santa Anita", branch:lima)
District.find_or_create_by(name: "Santa María del Mar", branch:lima)
District.find_or_create_by(name: "Santa Rosa", branch:lima)
District.find_or_create_by(name: "Santiago de Surco", branch:lima)
District.find_or_create_by(name: "Surquillo", branch:lima)
District.find_or_create_by(name: "Ventanilla", branch:lima)
District.find_or_create_by(name: "Villa el Salvador", branch:lima)
District.find_or_create_by(name: "Villa María del Triunfo", branch:lima)
District.find_or_create_by(name: "Otro distrito / ciudad", branch: lima)

District.find_or_create_by(name: "Acambay", branch:mexico)
District.find_or_create_by(name: "Acolman", branch:mexico)
District.find_or_create_by(name: "Aculco", branch:mexico)
District.find_or_create_by(name: "Almoloya de Alquisiras", branch:mexico)
District.find_or_create_by(name: "Almoloya de Juárez", branch:mexico)
District.find_or_create_by(name: "Almoloya del Río", branch:mexico)
District.find_or_create_by(name: "Alvaro Obregón", branch:mexico)
District.find_or_create_by(name: "Amanalco", branch:mexico)
District.find_or_create_by(name: "Amatepec", branch:mexico)
District.find_or_create_by(name: "Amecameca", branch:mexico)
District.find_or_create_by(name: "Apaxco", branch:mexico)
District.find_or_create_by(name: "Atenco", branch:mexico)
District.find_or_create_by(name: "Atizapán", branch:mexico)
District.find_or_create_by(name: "Atizapán de Zaragoza", branch:mexico)
District.find_or_create_by(name: "Atlacomulco", branch:mexico)
District.find_or_create_by(name: "Atlautla", branch:mexico)
District.find_or_create_by(name: "Axapusco", branch:mexico)
District.find_or_create_by(name: "Ayapango", branch:mexico)
District.find_or_create_by(name: "Azcapotzalco", branch:mexico)
District.find_or_create_by(name: "Benito Juárez", branch:mexico)
District.find_or_create_by(name: "Calimaya", branch:mexico)
District.find_or_create_by(name: "Capulhuac", branch:mexico)
District.find_or_create_by(name: "Chalco", branch:mexico)
District.find_or_create_by(name: "Chapa de Mota", branch:mexico)
District.find_or_create_by(name: "Otra delegación / ciudad", branch: mexico)

District.find_or_create_by(name: "Cerrillos", branch:santiago)
District.find_or_create_by(name: "Cerro Navia", branch:santiago)
District.find_or_create_by(name: "Conchalí", branch:santiago)
District.find_or_create_by(name: "El Bosque", branch:santiago)
District.find_or_create_by(name: "Estación Central", branch:santiago)
District.find_or_create_by(name: "Huechuraba", branch:santiago)
District.find_or_create_by(name: "Independencia", branch:santiago)
District.find_or_create_by(name: "La Cisterna", branch:santiago)
District.find_or_create_by(name: "La Florida", branch:santiago)
District.find_or_create_by(name: "La Granja", branch:santiago)
District.find_or_create_by(name: "La Pintana", branch:santiago)
District.find_or_create_by(name: "La Reina", branch:santiago)
District.find_or_create_by(name: "Las Condes", branch:santiago)
District.find_or_create_by(name: "Lo Barnechea", branch:santiago)
District.find_or_create_by(name: "Lo Espejo", branch:santiago)
District.find_or_create_by(name: "Lo Prado", branch:santiago)
District.find_or_create_by(name: "Macul", branch:santiago)
District.find_or_create_by(name: "Maipú", branch:santiago)
District.find_or_create_by(name: "Ñuñoa", branch:santiago)
District.find_or_create_by(name: "Padre Hurtado", branch:santiago)
District.find_or_create_by(name: "Pedro Aguirre Cerda", branch:santiago)
District.find_or_create_by(name: "Peñalolén", branch:santiago)
District.find_or_create_by(name: "Pirque", branch:santiago)
District.find_or_create_by(name: "Providencia", branch:santiago)
District.find_or_create_by(name: "Pudahuel", branch:santiago)
District.find_or_create_by(name: "Puente Alto", branch:santiago)
District.find_or_create_by(name: "Quilicura", branch:santiago)
District.find_or_create_by(name: "Quinta Normal", branch:santiago)
District.find_or_create_by(name: "Recoleta", branch:santiago)
District.find_or_create_by(name: "Renca", branch:santiago)
District.find_or_create_by(name: "San Bernardo", branch:santiago)
District.find_or_create_by(name: "San Joaquín", branch:santiago)
District.find_or_create_by(name: "San josé de Maipo", branch:santiago)
District.find_or_create_by(name: "San Miguel", branch:santiago)
District.find_or_create_by(name: "San Ramón", branch:santiago)
District.find_or_create_by(name: "Santiago", branch:santiago)
District.find_or_create_by(name: "Vitacura", branch:santiago)
District.find_or_create_by(name: "Otra comuna / cuidad", branch:santiago)

District.find_or_create_by(name: "Socabaya", branch:arequipa)
District.find_or_create_by(name: "Yanahuara", branch:arequipa)
District.find_or_create_by(name: "JLBYR", branch:arequipa)
District.find_or_create_by(name: "Pocsi", branch:arequipa)
District.find_or_create_by(name: "Arequipa", branch:arequipa)
District.find_or_create_by(name: "Cerro Colorado", branch:arequipa)
District.find_or_create_by(name: "Alto Selva Alegre", branch:arequipa)
District.find_or_create_by(name: "Cayma", branch:arequipa)
District.find_or_create_by(name: "Miraflores", branch:arequipa)
District.find_or_create_by(name: "Paucarpata", branch:arequipa)
District.find_or_create_by(name: "Characato", branch:arequipa)
District.find_or_create_by(name: "Hunter", branch:arequipa)
District.find_or_create_by(name: "La Joya", branch:arequipa)
District.find_or_create_by(name: "Mariano Melgar", branch:arequipa)
District.find_or_create_by(name: "Mollebaya", branch:arequipa)
District.find_or_create_by(name: "Polobaya", branch:arequipa)
District.find_or_create_by(name: "Quequeña", branch:arequipa)
District.find_or_create_by(name: "Sabandía", branch:arequipa)
District.find_or_create_by(name: "Sachaca", branch:arequipa)
District.find_or_create_by(name: "San Juan de Tarucani", branch:arequipa)
District.find_or_create_by(name: "Santa Isabel de Sihuas", branch:arequipa)
District.find_or_create_by(name: "Santa Rita de Sihuas", branch:arequipa)
District.find_or_create_by(name: "San Juan de Sihuas", branch:arequipa)
District.find_or_create_by(name: "Uchumayo", branch:arequipa)
District.find_or_create_by(name: "Tiabaya", branch:arequipa)
District.find_or_create_by(name: "Vitor", branch:arequipa)
District.find_or_create_by(name: "Yura", branch:arequipa)
District.find_or_create_by(name: "Tacna", branch:arequipa)
District.find_or_create_by(name: "Otra distrito / cuidad", branch:arequipa)

#Education types
Education.find_or_create_by(name: "Primaria incompleta", branch:lima)
Education.find_or_create_by(name: "Primaria completa", branch:lima)
Education.find_or_create_by(name: "Secundaria incompleta", branch:lima)
Education.find_or_create_by(name: "Secundaria completa", branch:lima)
Education.find_or_create_by(name: "Superior técnica incompleta", branch:lima)
Education.find_or_create_by(name: "Superior técnica completa", branch:lima)
Education.find_or_create_by(name: "Superior universitaria incompleta", branch:lima)
Education.find_or_create_by(name: "Superior universitaria completa", branch:lima)

Education.find_or_create_by(name: "Primaria incompleta", branch:mexico)
Education.find_or_create_by(name: "Primaria completa", branch:mexico)
Education.find_or_create_by(name: "Secundaria incompleta", branch:mexico)
Education.find_or_create_by(name: "Secundario completa", branch:mexico)
Education.find_or_create_by(name: "Prepa incompleta", branch:mexico)
Education.find_or_create_by(name: "Prepa completa", branch:mexico)
Education.find_or_create_by(name: "Superior técnica incompleta", branch:mexico)
Education.find_or_create_by(name: "Superior técnica completa", branch:mexico)
Education.find_or_create_by(name: "Superior universitaria incompleta", branch:mexico)
Education.find_or_create_by(name: "Superior universitaria completa", branch:mexico)

Education.find_or_create_by(name: "Básica incompleta", branch:santiago)
Education.find_or_create_by(name: "Básica completa", branch:santiago)
Education.find_or_create_by(name: "Media incompleta", branch:santiago)
Education.find_or_create_by(name: "Media completa", branch:santiago)
Education.find_or_create_by(name: "Superior técnica incompleta", branch:santiago)
Education.find_or_create_by(name: "Superior técnica completa", branch:santiago)
Education.find_or_create_by(name: "Superior universitaria incompleta", branch:santiago)
Education.find_or_create_by(name: "Superior universitaria completa", branch:santiago)

Education.find_or_create_by(name: "Primaria incompleta", branch:arequipa)
Education.find_or_create_by(name: "Primaria completa", branch:arequipa)
Education.find_or_create_by(name: "Secundaria incompleta", branch:arequipa)
Education.find_or_create_by(name: "Secundaria completa", branch:arequipa)
Education.find_or_create_by(name: "Superior técnica incompleta", branch:arequipa)
Education.find_or_create_by(name: "Superior técnica completa", branch:arequipa)
Education.find_or_create_by(name: "Superior universitaria incompleta", branch:arequipa)
Education.find_or_create_by(name: "Superior universitaria completa", branch:arequipa)

#Job Salaries
JobSalary.find_or_create_by(name: "Menos de 200 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 200 a 400 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 401 a 600 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 601 a 800 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 801 a 1000 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 1001 a 1200 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 1201 a 1400 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 1401 a 1600 soles", branch:lima)
JobSalary.find_or_create_by(name: "Más de 1600 soles", branch:lima)

JobSalary.find_or_create_by(name: "Menos de $1000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $1,001 a $2,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $2,001 a $3,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $3,001 a $4,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $4,001 a $5,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $5,001 a $6,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $6,001 a $7,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $7,001 a $8,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $8,001 a $9,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $9,001 a $10,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "Más de $10,000 pesos", branch:mexico)

JobSalary.find_or_create_by(name: "Menos de $50.000 pesos", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $50.001 y $100.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $100.001 y $200.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $200.001 y $300.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $300.001 y $400.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $400.001 y $500.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $500.001 y $600.000", branch:santiago)
JobSalary.find_or_create_by(name: "Más de $600.000", branch:santiago)

JobSalary.find_or_create_by(name: "Menos de 200 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 200 a 400 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 401 a 600 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 601 a 800 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 801 a 1000 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 1001 a 1200 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 1201 a 1400 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 1401 a 1600 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "Más de 1600 soles", branch:arequipa)

#Family incomes
JobSalary.find_or_create_by(name: "Menos de 800 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 800 a 1500 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 1501 a 2000 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 2001 a 2500 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 2501 a 3000 soles", branch:lima)
JobSalary.find_or_create_by(name: "De 3001 a 3500 soles", branch:lima)
JobSalary.find_or_create_by(name: "Más de 3500 soles", branch:lima)

JobSalary.find_or_create_by(name: "Menos de $1000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $1,001 a $2,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $2,001 a $3,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $3,001 a $4,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $4,001 a $5,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $5,001 a $6,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $6,001 a $7,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $7,001 a $8,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $8,001 a $9,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $9,001 a $10,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $10,001 a $15,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $15,001 a $20,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $20,001 a $25,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "De $25,001 a $30,000 pesos", branch:mexico)
JobSalary.find_or_create_by(name: "Más de $30,000 pesos", branch:mexico)

JobSalary.find_or_create_by(name: "Menos de $100.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $100.001 y $250.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $250.001 y $400.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $400.001 y $550.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $500.001 y $700.000", branch:santiago)
JobSalary.find_or_create_by(name: "Entre $700.001 y $900.000", branch:santiago)
JobSalary.find_or_create_by(name: "Más de $900.001", branch:santiago)

JobSalary.find_or_create_by(name: "Menos de 800 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 800 a 1500 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 1501 a 2000 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 2001 a 2500 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 2501 a 3000 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "De 3001 a 3500 soles", branch:arequipa)
JobSalary.find_or_create_by(name: "Más de 3500 soles", branch:arequipa)

SemestersLeft.find_or_create_by(name: "1 ciclo", branch:lima)
SemestersLeft.find_or_create_by(name: "2 ciclos", branch:lima)
SemestersLeft.find_or_create_by(name: "3 ciclos", branch:lima)
SemestersLeft.find_or_create_by(name: "4 ciclos", branch:lima)
SemestersLeft.find_or_create_by(name: "5 ciclos", branch:lima)
SemestersLeft.find_or_create_by(name: "6 ciclos", branch:lima)
SemestersLeft.find_or_create_by(name: "7 ciclos ", branch:lima)
SemestersLeft.find_or_create_by(name: "8 ciclos", branch:lima)
SemestersLeft.find_or_create_by(name: "9 ciclos o más", branch:lima)
SemestersLeft.find_or_create_by(name: "Tesis", branch:lima)

SemestersLeft.find_or_create_by(name: "Primer semestre", branch:mexico)
SemestersLeft.find_or_create_by(name: "Segundo semestre", branch:mexico)
SemestersLeft.find_or_create_by(name: "Tercer semestre", branch:mexico)
SemestersLeft.find_or_create_by(name: "Cuarto semestre", branch:mexico)
SemestersLeft.find_or_create_by(name: "Quinto semestre", branch:mexico)
SemestersLeft.find_or_create_by(name: "Sexto semestre", branch:mexico)
SemestersLeft.find_or_create_by(name: "Séptimo semestre", branch:mexico)
SemestersLeft.find_or_create_by(name: "Octavo semestre", branch:mexico)
SemestersLeft.find_or_create_by(name: "Noveno semestre o más", branch:mexico)
SemestersLeft.find_or_create_by(name: "Tesis/Idioma/Servicio social", branch:mexico)

SemestersLeft.find_or_create_by(name: "1 Semestre", branch:santiago)
SemestersLeft.find_or_create_by(name: "2 Semestres", branch:santiago)
SemestersLeft.find_or_create_by(name: "3 Semestres", branch:santiago)
SemestersLeft.find_or_create_by(name: "4 Semestres", branch:santiago)
SemestersLeft.find_or_create_by(name: "5 Semestres", branch:santiago)
SemestersLeft.find_or_create_by(name: "6 Semestres", branch:santiago)
SemestersLeft.find_or_create_by(name: "7 Semestres", branch:santiago)
SemestersLeft.find_or_create_by(name: "8 Semestres", branch:santiago)
SemestersLeft.find_or_create_by(name: "9 Semestres", branch:santiago)
SemestersLeft.find_or_create_by(name: "Tesis / Examen de grado", branch:santiago)

SemestersLeft.find_or_create_by(name: "1 ciclo", branch:arequipa)
SemestersLeft.find_or_create_by(name: "2 ciclos", branch:arequipa)
SemestersLeft.find_or_create_by(name: "3 ciclos", branch:arequipa)
SemestersLeft.find_or_create_by(name: "4 ciclos", branch:arequipa)
SemestersLeft.find_or_create_by(name: "5 ciclos", branch:arequipa)
SemestersLeft.find_or_create_by(name: "6 ciclos", branch:arequipa)
SemestersLeft.find_or_create_by(name: "7 ciclos ", branch:arequipa)
SemestersLeft.find_or_create_by(name: "8 ciclos", branch:arequipa)
SemestersLeft.find_or_create_by(name: "9 ciclos o más", branch:arequipa)
SemestersLeft.find_or_create_by(name: "Tesis", branch:arequipa)

Spot.find_or_create_by(name: "Martes 22 de noviembre - 6:00 a 9:00 pm", branch:lima)
Spot.find_or_create_by(name: "Miércoles 23 de noviembre - 6:00 a 9:00 pm", branch:lima)
Spot.find_or_create_by(name: "Jueves 24 de noviembre - 6:00 a 9:00 pm", branch:lima)
Spot.find_or_create_by(name: "Sábado 26 de noviembre - 10:00 a 1:00 pm", branch:lima)
Spot.find_or_create_by(name: "Sábado 26 de noviembre - 2:00 a 5:00 pm", branch:lima)
Spot.find_or_create_by(name: "Domingo 27 de noviembre - 10:00 a 1:00 pm", branch:lima)
Spot.find_or_create_by(name: "Domingo 27 de noviembre - 2:00 a 5:00 pm", branch:lima)
Spot.find_or_create_by(name: "Martes 29 de noviembre - 6:00 a 9:00 pm", branch:lima)
Spot.find_or_create_by(name: "Miércoles 30 de noviembre - 6:00 a 9:00 pm", branch:lima)
Spot.find_or_create_by(name: "Jueves 01 de diciembre - 6:00 a 9:00 pm", branch:lima)
