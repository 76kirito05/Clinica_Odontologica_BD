--
-- PostgreSQL database dump
--

\restrict vtOvZxITQVdLnjRtwEfEnS03OzSToDe5myl1e4CluPcLl0vpJglcj1Y1lH3KNKJ

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-11-12 21:03:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16546)
-- Name: cita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cita (
    id_cita integer NOT NULL,
    id_paciente integer,
    id_odontologo integer,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    motivo character varying(100),
    estado character varying(20) DEFAULT 'Programada'::character varying,
    id_usuario integer,
    CONSTRAINT cita_estado_check CHECK (((estado)::text = ANY ((ARRAY['Programada'::character varying, 'Atendida'::character varying, 'Cancelada'::character varying])::text[])))
);


ALTER TABLE public.cita OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16545)
-- Name: cita_id_cita_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cita_id_cita_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cita_id_cita_seq OWNER TO postgres;

--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 223
-- Name: cita_id_cita_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cita_id_cita_seq OWNED BY public.cita.id_cita;


--
-- TOC entry 232 (class 1259 OID 16616)
-- Name: especialidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.especialidad (
    id_especialidad integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.especialidad OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16615)
-- Name: especialidad_id_especialidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.especialidad_id_especialidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.especialidad_id_especialidad_seq OWNER TO postgres;

--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 231
-- Name: especialidad_id_especialidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.especialidad_id_especialidad_seq OWNED BY public.especialidad.id_especialidad;


--
-- TOC entry 226 (class 1259 OID 16565)
-- Name: historia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historia (
    id_historial integer NOT NULL,
    id_paciente integer,
    id_tratamiento integer,
    fecha date,
    observaciones text
);


ALTER TABLE public.historia OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16564)
-- Name: historia_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historia_id_historial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historia_id_historial_seq OWNER TO postgres;

--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 225
-- Name: historia_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historia_id_historial_seq OWNED BY public.historia.id_historial;


--
-- TOC entry 220 (class 1259 OID 16530)
-- Name: odontologo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.odontologo (
    id_odontologo integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    especialidad character varying(50),
    telefono character varying(9),
    id_especialidad integer
);


ALTER TABLE public.odontologo OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16529)
-- Name: odontologo_id_odontologo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.odontologo_id_odontologo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.odontologo_id_odontologo_seq OWNER TO postgres;

--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 219
-- Name: odontologo_id_odontologo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.odontologo_id_odontologo_seq OWNED BY public.odontologo.id_odontologo;


--
-- TOC entry 218 (class 1259 OID 16521)
-- Name: paciente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paciente (
    id_paciente integer NOT NULL,
    dni character varying(10) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    telefono character varying(50),
    direccion character varying(100),
    fecha_nacimiento date
);


ALTER TABLE public.paciente OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16520)
-- Name: paciente_id_paciente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paciente_id_paciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paciente_id_paciente_seq OWNER TO postgres;

--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 217
-- Name: paciente_id_paciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paciente_id_paciente_seq OWNED BY public.paciente.id_paciente;


--
-- TOC entry 228 (class 1259 OID 16584)
-- Name: pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pago (
    id_pago integer NOT NULL,
    id_paciente integer,
    fecha_pago date,
    monto numeric(8,2),
    forma_pago character varying(20) DEFAULT 'Efectivo'::character varying,
    id_usuario integer,
    CONSTRAINT pago_forma_pago_check CHECK (((forma_pago)::text = ANY ((ARRAY['Efectivo'::character varying, 'Tarjeta'::character varying, 'Transferenci'::character varying])::text[])))
);


ALTER TABLE public.pago OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16583)
-- Name: pago_id_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pago_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pago_id_pago_seq OWNER TO postgres;

--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 227
-- Name: pago_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pago_id_pago_seq OWNED BY public.pago.id_pago;


--
-- TOC entry 222 (class 1259 OID 16537)
-- Name: tratamiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tratamiento (
    id_tratamiento integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text,
    costo numeric(8,2)
);


ALTER TABLE public.tratamiento OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16536)
-- Name: tratamiento_id_tratamiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tratamiento_id_tratamiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tratamiento_id_tratamiento_seq OWNER TO postgres;

--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 221
-- Name: tratamiento_id_tratamiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tratamiento_id_tratamiento_seq OWNED BY public.tratamiento.id_tratamiento;


--
-- TOC entry 230 (class 1259 OID 16603)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    cargo character varying(30),
    correo character varying(100),
    telefono character varying(15),
    usuario_login character varying(30) NOT NULL,
    contrasena character varying(100) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado boolean DEFAULT true
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16602)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 229
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 4679 (class 2604 OID 16549)
-- Name: cita id_cita; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita ALTER COLUMN id_cita SET DEFAULT nextval('public.cita_id_cita_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 16619)
-- Name: especialidad id_especialidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidad ALTER COLUMN id_especialidad SET DEFAULT nextval('public.especialidad_id_especialidad_seq'::regclass);


--
-- TOC entry 4681 (class 2604 OID 16568)
-- Name: historia id_historial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia ALTER COLUMN id_historial SET DEFAULT nextval('public.historia_id_historial_seq'::regclass);


--
-- TOC entry 4677 (class 2604 OID 16533)
-- Name: odontologo id_odontologo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odontologo ALTER COLUMN id_odontologo SET DEFAULT nextval('public.odontologo_id_odontologo_seq'::regclass);


--
-- TOC entry 4676 (class 2604 OID 16524)
-- Name: paciente id_paciente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente ALTER COLUMN id_paciente SET DEFAULT nextval('public.paciente_id_paciente_seq'::regclass);


--
-- TOC entry 4682 (class 2604 OID 16587)
-- Name: pago id_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago ALTER COLUMN id_pago SET DEFAULT nextval('public.pago_id_pago_seq'::regclass);


--
-- TOC entry 4678 (class 2604 OID 16540)
-- Name: tratamiento id_tratamiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamiento ALTER COLUMN id_tratamiento SET DEFAULT nextval('public.tratamiento_id_tratamiento_seq'::regclass);


--
-- TOC entry 4684 (class 2604 OID 16606)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 4874 (class 0 OID 16546)
-- Dependencies: 224
-- Data for Name: cita; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cita VALUES (1, 1, 1, '2025-11-15', '09:00:00', 'Control ortodoncia', 'Programada', NULL);
INSERT INTO public.cita VALUES (2, 2, 2, '2025-11-16', '10:30:00', 'Dolor de muela', 'Programada', NULL);
INSERT INTO public.cita VALUES (3, 3, 3, '2025-11-17', '11:00:00', 'Revisión dental', 'Atendida', NULL);
INSERT INTO public.cita VALUES (4, 4, 4, '2025-11-18', '09:30:00', 'Evaluación cirugía', 'Programada', NULL);
INSERT INTO public.cita VALUES (5, 5, 5, '2025-11-19', '14:00:00', 'Revisión de prótesis', 'Cancelada', NULL);
INSERT INTO public.cita VALUES (6, 6, 6, '2025-11-20', '10:00:00', 'Colocación de implante', 'Programada', NULL);
INSERT INTO public.cita VALUES (7, 7, 7, '2025-11-21', '11:15:00', 'Tratamiento para niño', 'Atendida', NULL);
INSERT INTO public.cita VALUES (8, 8, 8, '2025-11-22', '09:30:00', 'Control de brackets', 'Programada', NULL);
INSERT INTO public.cita VALUES (9, 9, 9, '2025-11-23', '14:45:00', 'Dolor en encía', 'Atendida', NULL);
INSERT INTO public.cita VALUES (10, 10, 10, '2025-11-24', '16:00:00', 'Revisión general', 'Programada', NULL);
INSERT INTO public.cita VALUES (11, 11, 11, '2025-11-25', '09:00:00', 'Limpieza profunda', 'Atendida', NULL);
INSERT INTO public.cita VALUES (12, 12, 12, '2025-11-26', '10:30:00', 'Dolor dental persistente', 'Programada', NULL);
INSERT INTO public.cita VALUES (13, 13, 13, '2025-11-27', '11:45:00', 'Tratamiento de encías', 'Programada', NULL);
INSERT INTO public.cita VALUES (14, 14, 14, '2025-11-28', '15:00:00', 'Evaluación cirugía maxilofacial', 'Programada', NULL);
INSERT INTO public.cita VALUES (15, 15, 15, '2025-11-29', '16:15:00', 'Chequeo general', 'Atendida', NULL);
INSERT INTO public.cita VALUES (16, 16, 16, '2025-12-01', '09:30:00', 'Evaluación ortodoncia', 'Programada', NULL);
INSERT INTO public.cita VALUES (17, 17, 17, '2025-12-02', '11:00:00', 'Dolor en molar derecho', 'Atendida', NULL);
INSERT INTO public.cita VALUES (18, 18, 18, '2025-12-03', '13:15:00', 'Tratamiento conducto', 'Programada', NULL);
INSERT INTO public.cita VALUES (19, 19, 19, '2025-12-04', '15:45:00', 'Control post operatorio', 'Atendida', NULL);
INSERT INTO public.cita VALUES (20, 20, 20, '2025-12-05', '16:30:00', 'Extracción dental', 'Programada', NULL);


--
-- TOC entry 4882 (class 0 OID 16616)
-- Dependencies: 232
-- Data for Name: especialidad; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4876 (class 0 OID 16565)
-- Dependencies: 226
-- Data for Name: historia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.historia VALUES (1, 1, 3, '2025-11-15', 'Control mensual de ortodoncia. Se ajustaron brackets.');
INSERT INTO public.historia VALUES (2, 2, 2, '2025-11-16', 'Extracción sin complicaciones. Analgésicos recetados.');
INSERT INTO public.historia VALUES (3, 3, 5, '2025-11-17', 'Tratamiento de conducto finalizado exitosamente.');
INSERT INTO public.historia VALUES (4, 4, 4, '2025-11-18', 'Evaluación previa a cirugía. Apta para intervención.');
INSERT INTO public.historia VALUES (5, 5, 1, '2025-11-19', 'Limpieza general. Recomendado uso de hilo dental.');
INSERT INTO public.historia VALUES (6, 6, 6, '2025-11-20', 'Implante colocado correctamente. Próximo control en 15 días.');
INSERT INTO public.historia VALUES (7, 7, 8, '2025-11-21', 'Aplicación de flúor en paciente pediátrico.');
INSERT INTO public.historia VALUES (8, 8, 3, '2025-11-22', 'Control de brackets sin novedades.');
INSERT INTO public.historia VALUES (9, 9, 10, '2025-11-23', 'Reconstrucción parcial realizada con éxito.');
INSERT INTO public.historia VALUES (10, 10, 1, '2025-11-24', 'Limpieza dental rutinaria. Sin anomalías detectadas.');
INSERT INTO public.historia VALUES (11, 11, 11, '2025-11-25', 'Limpieza profunda completada sin molestias.');
INSERT INTO public.historia VALUES (12, 12, 15, '2025-11-26', 'Obturación dental realizada con anestesia local.');
INSERT INTO public.historia VALUES (13, 13, 13, '2025-11-27', 'Encías inflamadas tratadas con antibióticos.');
INSERT INTO public.historia VALUES (14, 14, 14, '2025-11-28', 'Radiografía muestra fractura menor en mandíbula.');
INSERT INTO public.historia VALUES (15, 15, 12, '2025-11-29', 'Evaluación general sin hallazgos significativos.');
INSERT INTO public.historia VALUES (16, 16, 16, '2025-12-01', 'Paciente inicia tratamiento de ortodoncia.');
INSERT INTO public.historia VALUES (17, 17, 17, '2025-12-02', 'Dolor controlado, sin infección aparente.');
INSERT INTO public.historia VALUES (18, 18, 18, '2025-12-03', 'Canal tratado con éxito, cita de control programada.');
INSERT INTO public.historia VALUES (19, 19, 19, '2025-12-04', 'Revisión exitosa tras rehabilitación oral.');
INSERT INTO public.historia VALUES (20, 20, 20, '2025-12-05', 'Extracción sin complicaciones, paciente estable.');


--
-- TOC entry 4870 (class 0 OID 16530)
-- Dependencies: 220
-- Data for Name: odontologo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.odontologo VALUES (1, 'Javier', 'Pérez', 'Ortodoncia', '987654321', NULL);
INSERT INTO public.odontologo VALUES (2, 'Claudia', 'Morales', 'Endodoncia', '954321987', NULL);
INSERT INTO public.odontologo VALUES (3, 'Ricardo', 'Santos', 'Odontopediatría', '965478321', NULL);
INSERT INTO public.odontologo VALUES (4, 'Patricia', 'León', 'Cirugía Oral', '978654312', NULL);
INSERT INTO public.odontologo VALUES (5, 'Andrés', 'Vega', 'Rehabilitación Oral', '912345678', NULL);
INSERT INTO public.odontologo VALUES (6, 'Sofía', 'Palacios', 'Estética Dental', '987321654', NULL);
INSERT INTO public.odontologo VALUES (7, 'Rodrigo', 'Mora', 'Implantología', '954789123', NULL);
INSERT INTO public.odontologo VALUES (8, 'Daniela', 'Huamán', 'Odontopediatría', '931246578', NULL);
INSERT INTO public.odontologo VALUES (9, 'Eduardo', 'Campos', 'Ortodoncia', '978123654', NULL);
INSERT INTO public.odontologo VALUES (10, 'Verónica', 'Salazar', 'Endodoncia', '965874123', NULL);
INSERT INTO public.odontologo VALUES (11, 'Marcos', 'Sánchez', 'Prostodoncia', '999123456', NULL);
INSERT INTO public.odontologo VALUES (12, 'Gabriela', 'Lozano', 'Endodoncia', '987951357', NULL);
INSERT INTO public.odontologo VALUES (13, 'Diego', 'Pérez', 'Periodoncia', '954789654', NULL);
INSERT INTO public.odontologo VALUES (14, 'Elena', 'Mora', 'Cirugía Maxilofacial', '912457896', NULL);
INSERT INTO public.odontologo VALUES (15, 'Adriana', 'Huerta', 'Odontología General', '965478951', NULL);
INSERT INTO public.odontologo VALUES (16, 'Rosa', 'Gamarra', 'Ortodoncia', '987651234', NULL);
INSERT INTO public.odontologo VALUES (17, 'Hugo', 'Núñez', 'Odontopediatría', '912789654', NULL);
INSERT INTO public.odontologo VALUES (18, 'María', 'Delgado', 'Endodoncia', '945213789', NULL);
INSERT INTO public.odontologo VALUES (19, 'Fernando', 'Ibáñez', 'Rehabilitación Oral', '956478123', NULL);
INSERT INTO public.odontologo VALUES (20, 'Lucía', 'Contreras', 'Cirugía Bucal', '932145879', NULL);


--
-- TOC entry 4868 (class 0 OID 16521)
-- Dependencies: 218
-- Data for Name: paciente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paciente VALUES (1, '75463281', 'Carlos', 'Ramírez', '987654321', 'Av. Perú 123', '1990-04-12');
INSERT INTO public.paciente VALUES (2, '72839465', 'María', 'Torres', '954321876', 'Jr. Lima 456', '1985-11-23');
INSERT INTO public.paciente VALUES (3, '71623849', 'Luis', 'Fernández', '998745632', 'Calle Sol 32', '1993-09-15');
INSERT INTO public.paciente VALUES (4, '70345812', 'Ana', 'Gómez', '912345678', 'Av. Grau 812', '1999-05-20');
INSERT INTO public.paciente VALUES (5, '70981234', 'Rosa', 'Cruz', '945671234', 'Calle Norte 55', '1987-07-02');
INSERT INTO public.paciente VALUES (6, '73546981', 'Pedro', 'Salas', '965432198', 'Av. Los Pinos 890', '1992-02-19');
INSERT INTO public.paciente VALUES (7, '72568124', 'Lucía', 'Campos', '931245678', 'Jr. Unión 102', '1994-10-09');
INSERT INTO public.paciente VALUES (8, '70892156', 'Julio', 'Lopez', '987126345', 'Av. Primavera 111', '1986-12-12');
INSERT INTO public.paciente VALUES (9, '70123456', 'Martha', 'Gonzales', '954876321', 'Jr. San Martín 45', '1998-03-30');
INSERT INTO public.paciente VALUES (10, '74562134', 'Hugo', 'Mendoza', '989653421', 'Calle Luna 20', '1991-01-18');
INSERT INTO public.paciente VALUES (11, '73245698', 'Patricia', 'Alarcón', '944563728', 'Av. Las Flores 65', '1988-06-11');
INSERT INTO public.paciente VALUES (12, '71123874', 'Raúl', 'Díaz', '975643218', 'Calle Central 5', '1990-09-05');
INSERT INTO public.paciente VALUES (13, '70198456', 'Sofía', 'León', '987563421', 'Av. Los Olivos 87', '1996-12-25');
INSERT INTO public.paciente VALUES (14, '70345612', 'Carmen', 'Vásquez', '912678543', 'Jr. Cielo 74', '1993-08-08');
INSERT INTO public.paciente VALUES (15, '71928374', 'Jorge', 'Rivas', '954321876', 'Calle del Mar 13', '1985-02-17');
INSERT INTO public.paciente VALUES (16, '73451236', 'Ricardo', 'Calle', '987456321', 'Av. Primavera 102', '1991-03-11');
INSERT INTO public.paciente VALUES (17, '72897452', 'Daniela', 'Campos', '954789123', 'Calle Norte 45', '1994-05-28');
INSERT INTO public.paciente VALUES (18, '73569874', 'Leonardo', 'Reyes', '912345678', 'Jr. Amanecer 80', '1987-10-14');
INSERT INTO public.paciente VALUES (19, '72145987', 'Carla', 'Torres', '945876321', 'Av. Grau 50', '1992-12-02');
INSERT INTO public.paciente VALUES (20, '73321548', 'Felipe', 'Montoya', '998741256', 'Calle Esperanza 9', '1989-07-19');


--
-- TOC entry 4878 (class 0 OID 16584)
-- Dependencies: 228
-- Data for Name: pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pago VALUES (4, 1, '2025-11-15', 80.00, 'Efectivo', NULL);
INSERT INTO public.pago VALUES (5, 2, '2025-11-16', 150.00, 'Tarjeta', NULL);
INSERT INTO public.pago VALUES (6, 3, '2025-11-17', 500.00, 'Transferenci', NULL);
INSERT INTO public.pago VALUES (7, 4, '2025-11-18', 1200.00, 'Tarjeta', NULL);
INSERT INTO public.pago VALUES (8, 5, '2025-11-19', 300.00, 'Efectivo', NULL);
INSERT INTO public.pago VALUES (9, 6, '2025-11-20', 2000.00, 'Tarjeta', NULL);
INSERT INTO public.pago VALUES (10, 7, '2025-11-21', 60.00, 'Efectivo', NULL);
INSERT INTO public.pago VALUES (11, 8, '2025-11-22', 1200.00, 'Transferenci', NULL);
INSERT INTO public.pago VALUES (12, 9, '2025-11-23', 500.00, 'Tarjeta', NULL);
INSERT INTO public.pago VALUES (13, 10, '2025-11-24', 80.00, 'Efectivo', NULL);
INSERT INTO public.pago VALUES (14, 11, '2025-11-25', 120.00, 'Efectivo', NULL);
INSERT INTO public.pago VALUES (15, 12, '2025-11-26', 500.00, 'Transferenci', NULL);
INSERT INTO public.pago VALUES (16, 13, '2025-11-27', 180.00, 'Efectivo', NULL);
INSERT INTO public.pago VALUES (17, 14, '2025-11-28', 700.00, 'Tarjeta', NULL);
INSERT INTO public.pago VALUES (18, 15, '2025-11-29', 50.00, 'Efectivo', NULL);
INSERT INTO public.pago VALUES (19, 16, '2025-12-01', 200.00, 'Tarjeta', NULL);
INSERT INTO public.pago VALUES (20, 17, '2025-12-02', 90.00, 'Efectivo', NULL);
INSERT INTO public.pago VALUES (21, 18, '2025-12-03', 1500.00, 'Transferenci', NULL);
INSERT INTO public.pago VALUES (22, 19, '2025-12-04', 60.00, 'Efectivo', NULL);
INSERT INTO public.pago VALUES (23, 20, '2025-12-05', 250.00, 'Tarjeta', NULL);


--
-- TOC entry 4872 (class 0 OID 16537)
-- Dependencies: 222
-- Data for Name: tratamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tratamiento VALUES (1, 'Limpieza dental', 'Eliminación de placa y sarro dental', 80.00);
INSERT INTO public.tratamiento VALUES (2, 'Extracción de muela', 'Remoción de pieza dental dañada', 150.00);
INSERT INTO public.tratamiento VALUES (3, 'Ortodoncia', 'Colocación de brackets metálicos', 1200.00);
INSERT INTO public.tratamiento VALUES (4, 'Blanqueamiento dental', 'Procedimiento estético para aclarar los dientes', 300.00);
INSERT INTO public.tratamiento VALUES (5, 'Endodoncia', 'Tratamiento de conducto radicular', 500.00);
INSERT INTO public.tratamiento VALUES (6, 'Implante dental', 'Colocación de implante de titanio', 2000.00);
INSERT INTO public.tratamiento VALUES (7, 'Carilla dental', 'Colocación de carillas estéticas de porcelana', 800.00);
INSERT INTO public.tratamiento VALUES (8, 'Fluorización', 'Aplicación de flúor para prevenir caries', 60.00);
INSERT INTO public.tratamiento VALUES (9, 'Sellado de fosas', 'Protección preventiva para dientes molares', 100.00);
INSERT INTO public.tratamiento VALUES (10, 'Reconstrucción dental', 'Reparación de diente fracturado', 250.00);
INSERT INTO public.tratamiento VALUES (11, 'Profilaxis', 'Limpieza dental profunda con ultrasonido', 120.00);
INSERT INTO public.tratamiento VALUES (12, 'Puente dental', 'Reemplazo de dientes faltantes con puente fijo', 900.00);
INSERT INTO public.tratamiento VALUES (13, 'Coronas', 'Colocación de corona de porcelana', 700.00);
INSERT INTO public.tratamiento VALUES (14, 'Radiografía dental', 'Toma de radiografía panorámica', 50.00);
INSERT INTO public.tratamiento VALUES (15, 'Obturación dental', 'Sellado de cavidades por caries', 180.00);
INSERT INTO public.tratamiento VALUES (16, 'Carillas dentales', 'Colocación de carillas estéticas de porcelana', 850.00);
INSERT INTO public.tratamiento VALUES (17, 'Limpieza básica', 'Limpieza dental sin ultrasonido', 90.00);
INSERT INTO public.tratamiento VALUES (18, 'Implante dental', 'Sustitución de diente perdido con implante', 1500.00);
INSERT INTO public.tratamiento VALUES (19, 'Fluorización', 'Aplicación de flúor para protección dental', 60.00);
INSERT INTO public.tratamiento VALUES (20, 'Extracción de muela', 'Extracción quirúrgica de muela dañada', 250.00);


--
-- TOC entry 4880 (class 0 OID 16603)
-- Dependencies: 230
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 223
-- Name: cita_id_cita_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cita_id_cita_seq', 20, true);


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 231
-- Name: especialidad_id_especialidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.especialidad_id_especialidad_seq', 1, false);


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 225
-- Name: historia_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historia_id_historial_seq', 20, true);


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 219
-- Name: odontologo_id_odontologo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.odontologo_id_odontologo_seq', 20, true);


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 217
-- Name: paciente_id_paciente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paciente_id_paciente_seq', 20, true);


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 227
-- Name: pago_id_pago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pago_id_pago_seq', 23, true);


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 221
-- Name: tratamiento_id_tratamiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tratamiento_id_tratamiento_seq', 20, true);


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 229
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 1, false);


--
-- TOC entry 4699 (class 2606 OID 16553)
-- Name: cita cita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_pkey PRIMARY KEY (id_cita);


--
-- TOC entry 4711 (class 2606 OID 16623)
-- Name: especialidad especialidad_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidad
    ADD CONSTRAINT especialidad_nombre_key UNIQUE (nombre);


--
-- TOC entry 4713 (class 2606 OID 16621)
-- Name: especialidad especialidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidad
    ADD CONSTRAINT especialidad_pkey PRIMARY KEY (id_especialidad);


--
-- TOC entry 4701 (class 2606 OID 16572)
-- Name: historia historia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia
    ADD CONSTRAINT historia_pkey PRIMARY KEY (id_historial);


--
-- TOC entry 4695 (class 2606 OID 16535)
-- Name: odontologo odontologo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odontologo
    ADD CONSTRAINT odontologo_pkey PRIMARY KEY (id_odontologo);


--
-- TOC entry 4691 (class 2606 OID 16528)
-- Name: paciente paciente_dni_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_dni_key UNIQUE (dni);


--
-- TOC entry 4693 (class 2606 OID 16526)
-- Name: paciente paciente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id_paciente);


--
-- TOC entry 4703 (class 2606 OID 16591)
-- Name: pago pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 4697 (class 2606 OID 16544)
-- Name: tratamiento tratamiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamiento
    ADD CONSTRAINT tratamiento_pkey PRIMARY KEY (id_tratamiento);


--
-- TOC entry 4705 (class 2606 OID 16612)
-- Name: usuario usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_correo_key UNIQUE (correo);


--
-- TOC entry 4707 (class 2606 OID 16610)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4709 (class 2606 OID 16614)
-- Name: usuario usuario_usuario_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_usuario_login_key UNIQUE (usuario_login);


--
-- TOC entry 4715 (class 2606 OID 16559)
-- Name: cita cita_id_odontologo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_odontologo_fkey FOREIGN KEY (id_odontologo) REFERENCES public.odontologo(id_odontologo);


--
-- TOC entry 4716 (class 2606 OID 16554)
-- Name: cita cita_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);


--
-- TOC entry 4717 (class 2606 OID 16629)
-- Name: cita cita_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 4718 (class 2606 OID 16573)
-- Name: historia historia_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia
    ADD CONSTRAINT historia_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);


--
-- TOC entry 4719 (class 2606 OID 16578)
-- Name: historia historia_id_tratamiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia
    ADD CONSTRAINT historia_id_tratamiento_fkey FOREIGN KEY (id_tratamiento) REFERENCES public.tratamiento(id_tratamiento);


--
-- TOC entry 4714 (class 2606 OID 16624)
-- Name: odontologo odontologo_id_especialidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odontologo
    ADD CONSTRAINT odontologo_id_especialidad_fkey FOREIGN KEY (id_especialidad) REFERENCES public.especialidad(id_especialidad);


--
-- TOC entry 4720 (class 2606 OID 16592)
-- Name: pago pago_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);


--
-- TOC entry 4721 (class 2606 OID 16634)
-- Name: pago pago_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


-- Completed on 2025-11-12 21:03:04

--
-- PostgreSQL database dump complete
--

\unrestrict vtOvZxITQVdLnjRtwEfEnS03OzSToDe5myl1e4CluPcLl0vpJglcj1Y1lH3KNKJ

