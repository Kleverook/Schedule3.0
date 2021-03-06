--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: gen_uuid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.gen_uuid() RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
	return (SELECT uuid_in(overlay(overlay(md5(random()::text || ':' || clock_timestamp()::text) placing '4' from 13) placing to_hex(floor(random()*(11-8+1) + 8)::int)::text from 17)::cstring));
	END;
$$;


ALTER FUNCTION public.gen_uuid() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_permission_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission_role (
    id integer NOT NULL,
    id_permission integer NOT NULL,
    id_role integer NOT NULL
);


ALTER TABLE public.auth_permission_role OWNER TO postgres;

--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_role_id_seq OWNER TO postgres;

--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_role_id_seq OWNED BY public.auth_permission_role.id;


--
-- Name: auth_person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_person (
    id integer NOT NULL,
    login text NOT NULL,
    password text NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    google_calendar_key text,
    phone_number text,
    login_key text DEFAULT public.gen_uuid() NOT NULL,
    id_role integer NOT NULL
);


ALTER TABLE public.auth_person OWNER TO postgres;

--
-- Name: auth_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_person_id_seq OWNER TO postgres;

--
-- Name: auth_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_person_id_seq OWNED BY public.auth_person.id;


--
-- Name: auth_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_role (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.auth_role OWNER TO postgres;

--
-- Name: auth_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_role_id_seq OWNER TO postgres;

--
-- Name: auth_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_role_id_seq OWNED BY public.auth_role.id;


--
-- Name: list_corpus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_corpus (
    id integer NOT NULL,
    title text,
    short_title text NOT NULL,
    addres text
);


ALTER TABLE public.list_corpus OWNER TO postgres;

--
-- Name: list_corpus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.list_corpus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_corpus_id_seq OWNER TO postgres;

--
-- Name: list_corpus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.list_corpus_id_seq OWNED BY public.list_corpus.id;


--
-- Name: list_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_department (
    id integer NOT NULL,
    title text NOT NULL,
    short_title text NOT NULL,
    id_division integer NOT NULL
);


ALTER TABLE public.list_department OWNER TO postgres;

--
-- Name: list_division; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_division (
    id integer NOT NULL,
    title text NOT NULL,
    short_title text NOT NULL
);


ALTER TABLE public.list_division OWNER TO postgres;

--
-- Name: list_employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_employee (
    id integer NOT NULL,
    name text NOT NULL,
    subname text NOT NULL,
    middle_name text,
    id_department integer NOT NULL
);


ALTER TABLE public.list_employee OWNER TO postgres;

--
-- Name: list_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_group (
    id integer NOT NULL,
    course integer NOT NULL,
    title text NOT NULL,
    code text NOT NULL,
    level_education text NOT NULL,
    id_division integer NOT NULL
);


ALTER TABLE public.list_group OWNER TO postgres;

--
-- Name: list_person_employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_person_employee (
    id integer NOT NULL,
    id_person integer NOT NULL,
    id_employee integer NOT NULL
);


ALTER TABLE public.list_person_employee OWNER TO postgres;

--
-- Name: list_person_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.list_person_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_person_employee_id_seq OWNER TO postgres;

--
-- Name: list_person_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.list_person_employee_id_seq OWNED BY public.list_person_employee.id;


--
-- Name: list_person_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_person_group (
    id integer NOT NULL,
    id_person integer NOT NULL,
    id_group integer NOT NULL,
    update boolean DEFAULT false NOT NULL
);


ALTER TABLE public.list_person_group OWNER TO postgres;

--
-- Name: list_person_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.list_person_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_person_group_id_seq OWNER TO postgres;

--
-- Name: list_person_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.list_person_group_id_seq OWNED BY public.list_person_group.id;


--
-- Name: list_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_schedule (
    id integer NOT NULL,
    number_sub_gruop integer NOT NULL,
    title_subject text NOT NULL,
    type_lesson text NOT NULL,
    number_lesson integer NOT NULL,
    day_week integer NOT NULL,
    date_lesson timestamp without time zone NOT NULL,
    special text NOT NULL,
    link text NOT NULL,
    pass text NOT NULL,
    zoom_link text NOT NULL,
    zoom_password text NOT NULL,
    id_corpus integer NOT NULL,
    id_employee integer NOT NULL,
    id_group integer NOT NULL
);


ALTER TABLE public.list_schedule OWNER TO postgres;

--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_permission_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_role_id_seq'::regclass);


--
-- Name: auth_person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_person ALTER COLUMN id SET DEFAULT nextval('public.auth_person_id_seq'::regclass);


--
-- Name: auth_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_role ALTER COLUMN id SET DEFAULT nextval('public.auth_role_id_seq'::regclass);


--
-- Name: list_corpus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_corpus ALTER COLUMN id SET DEFAULT nextval('public.list_corpus_id_seq'::regclass);


--
-- Name: list_person_employee id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_employee ALTER COLUMN id SET DEFAULT nextval('public.list_person_employee_id_seq'::regclass);


--
-- Name: list_person_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_group ALTER COLUMN id SET DEFAULT nextval('public.list_person_group_id_seq'::regclass);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name) FROM stdin;
1	table_persons
\.


--
-- Data for Name: auth_permission_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission_role (id, id_permission, id_role) FROM stdin;
1	1	1
\.


--
-- Data for Name: auth_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_person (id, login, password, name, surname, google_calendar_key, phone_number, login_key, id_role) FROM stdin;
2	user1	qwerty	Alexandr	P			5cb2a8e4-55d2-4d67-baeb-192ceb3396aa	1
3	user2	qwerty	D	P			e67a79a1-2c5a-4058-907b-b0b06a848191	2
7	jjj	klll	kjj	hfug			309a7dc1-b823-4512-9620-74f70316022c	2
8	jj2j	klll	kjj	hfug	\N	\N	e25ddf51-c229-4c9b-bcf3-42bf6fa0e975	2
9	Kleveroook	asdfgh1	Daniil	Pade	\N	\N	7d4696ae-6373-4d8a-bd14-8f0b57ca57f4	2
10	Kleveroook	asdfgh1	Daniil	Pade	\N	\N	bb9bcb5a-f914-48d1-855e-9d65a9691314	2
11	Kleveroookk	asdfghj1	Daniil	Pade	\N	\N	7811e0a1-f5e2-4e32-a072-87f9203619b5	2
12	Kleverooo	asdfghj1	Daniil	Pade	\N	\N	bb489f3c-5919-4042-93a2-456ad04f5e3c	2
13	Kleverjjjvk	asdfghj1	Daniil	Pade	\N	\N	82360eeb-5adf-43cb-8d6b-44509d59fd60	2
14	Kleverjjjvk	asdfghj1	Daniil	Pade	\N	\N	603d42bd-8fb7-4f21-be59-356ff90c9311	2
15	Kleverjjjv	asdfghj1	Daniil	Pade	\N	\N	a8848e05-4b02-4716-8db3-66f704e43934	2
16	Kleveroookj	asdfgh1	Daniil	Pade	\N	\N	97a3e347-f1c4-45c5-b3ba-32ed3956dc93	2
17	Kleverookkkkk	asdfgh1	Daniil	Pade	\N	\N	9551a3d1-82ac-43fc-bce7-aef49dbc5bdf	2
18	Kleverookkkkkk	asdfgh1	Daniil	Pade	\N	\N	0ed9ca52-a40c-45be-9107-83610f0360a3	2
20	Kleverookkkkkkjgkk	asdfgh1	Daniil	Pade	\N	\N	47c66a76-0de9-4781-a51f-c297e1427748	2
21	Kleckkkkjgkk	asdfgh1	Daniil	Pade	\N	\N	af899650-3bd4-4ea5-b54f-93d35421c4d5	2
22	Kleckkkkjgkklkjhgfds	asdfgh1	Daniil	Pade	\N	\N	6ff59faf-f370-4096-9bbf-59f78956505a	2
23	Kleckkkkjgkklkjhgds	asdfgh1	Daniil	Pade	\N	\N	84f63e1d-1c1d-462a-88e8-b0e9cbc2892d	2
24	Kleckkk	asdfgh1	Daniil	Pade	\N	\N	41d5dec3-fd61-440e-a138-bf3eb09eb1aa	2
25	Kleckkkl	asdfgh1	Daniil	Pade	\N	\N	670a8c8f-950c-4e78-a2da-b21c8e80c573	2
26	Kleckkkl0	asdfghj1	Daniil	Pade	\N	\N	2a7dd66b-4e6e-4026-a77c-ffbc197714b7	2
27	Kleckkkl01	asdfgh1	Daniil	Pade	\N	\N	281bdda7-c6a2-4dd0-886c-0285fdcdb175	2
28	Kleckkkl00	asdfgh1	asdfgh	sdfgh	\N	\N	03e34f92-2ecf-4ddd-9a90-67833899bd81	2
19	Kleverookkkkkkk	asdfgh1	Daniil	Pade	xcAYzT37QnSuOdF0qXEpk0000	\N	37a5d4c9-8097-4ea1-8895-1b6ee7272b74	2
5	admin	admin	qwe	asd	ya29.a0AfH6SMBjOqgF7PvWKGpzXL1o7KI_fVdclyrfjkAivw1hiSHbqExDyx-h8a89mkK5AQl5mnqGyDZ3NtQWQed83g7yEgO44LhVxHgHQX8PLxzXTIyzR76EvsNg8NCFDfCIiylrEJdWyxG01h4D3MhsHS9d1776fB6i3-M	\N	3521b80d-1ef7-4099-a963-26685bd9ba2b	1
\.


--
-- Data for Name: auth_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_role (id, name) FROM stdin;
1	admin
2	user
\.


--
-- Data for Name: list_corpus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_corpus (id, title, short_title, addres) FROM stdin;
\.


--
-- Data for Name: list_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_department (id, title, short_title, id_division) FROM stdin;
\.


--
-- Data for Name: list_division; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_division (id, title, short_title) FROM stdin;
5	Архитектурно-строительный институт	АСИ
152	Институт естественных наук и  биотехнологии	 ИЕНиБ
11	Институт естественных наук и биотехнологии	ИЕНиБ
12	Институт заочного и очно-заочного образования	ИВЗО
164	Институт иностранных языков	Иняз
157	Институт педагогики и психологии	ИПиП
7	Институт приборостроения, автоматизации и информационных технологий	ИПАИТ
150	Физико-математический факультет	ФизМат
153	Философский факультет	Филос
159	Художественно-графический факультет	ХГФ
2	Юридический институт	ЮИ
154	Институт филологии	ИФил
289	Институт экономики и управления	ИЭиУ
167	Исторический факультет	ИстФак
488	Лечебный факультет	ЛФ
124	Политехнический институт имени Н.Н. Поликарпова	ПТИ
155	Социальный факультет	СоцФак
158	Факультет педиатрии, стоматологии и фармации	ФПСиФ
163	Факультет технологии, предпринимательства и сервиса	ФТПиС
26	Факультет физической культуры и спорта	ФФКС
\.


--
-- Data for Name: list_employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_employee (id, name, subname, middle_name, id_department) FROM stdin;
\.


--
-- Data for Name: list_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_group (id, course, title, code, level_education, id_division) FROM stdin;
7139	2	91ПГОнор	44.03.05 (б) (о)	бакалавриат	157
7140	2	91ППО	44.03.02 (б) (о)	бакалавриат	157
6868	2	91ПС	37.03.01 (а) (о)	бакалавриат	157
7189	2	91СО	44.03.03ДД (б) (о)	бакалавриат	157
7265	2	92СО	44.03.03ЛО (б) (о)	бакалавриат	157
7263	2	91ПГОпэд-м	44.04.01ПЭ (м) (о)	магистратура	157
7071	2	91ПГОтмно-м	44.04.01ПО (м) (о)	магистратура	157
7262	2	91ППОппс-м	44.04.02ПП (м) (о)	магистратура	157
6915	2	91ПС-м	37.04.01 (м) (о)	магистратура	157
6928	2	91СО-м	44.04.03 (м) (о)	магистратура	157
4976	5	61ЭБ	38.05.01 (с) (о)	специалитет	289
6631	5	62ЭБ	38.05.01 (с) (о)	специалитет	289
7513	1	01АР	07.03.01 (б) (о)	бакалавриат	5
7525	1	01ГС	07.03.04 (б) (о)	бакалавриат	5
7514	1	01С	08.03.01 (б) (о)	бакалавриат	5
7369	1	01ТБ	20.03.01 (а) (о)	бакалавриат	5
7455	1	01АР-м	07.04.01 (м) (о)	магистратура	5
7604	1	01С-м	08.04.01 (м) (о)	магистратура	5
7593	1	01СУ	08.05.01 (с) (о)	специалитет	5
7194	2	91Бз	06.03.01З (а) (о)	бакалавриат	152
7195	2	91Бм	06.03.01М (а) (о)	бакалавриат	152
6871	2	91Г	05.03.02 (а) (о)	бакалавриат	152
7192	2	91ПГОбг	44.03.05БГ (б) (о)	бакалавриат	152
7193	2	91ПГОхбж	44.03.05ЕН (б) (о)	бакалавриат	152
7005	2	91ПЧ	06.03.02 (а) (о)	бакалавриат	152
6872	2	91ТБ	20.03.01 (а) (о)	бакалавриат	152
7191	2	91Х	04.03.01 (б) (о)	бакалавриат	152
7006	2	91ЭП	05.03.06 (п) (о)	бакалавриат	152
7303	2	92ПГОбг	44.03.05БГ (б) (о)	бакалавриат	152
7082	2	91Бб-м	06.04.01Б (м) (о)	магистратура	152
7081	2	91Ббф-м	06.04.01БФ (м) (о)	магистратура	152
6896	2	91Г-м	05.04.02 (м) (о)	магистратура	152
7083	2	91ПГОбж-м	44.04.01БЖ (м) (о)	магистратура	152
7084	2	91ПГОен-м	44.04.01ЕН (м) (о)	магистратура	152
6898	2	91ПЧ-м	06.04.02 (м) (о)	магистратура	152
7685	1	01Ббм	06.03.01БМ (а) (о)	бакалавриат	152
7686	1	01Бг	06.03.01Г (а) (о)	бакалавриат	152
7552	1	01Бз	06.03.01З (а) (о)	бакалавриат	152
7550	1	01ПГОбг	44.03.05БГ (б) (о)	бакалавриат	152
7551	1	01ПГОхбж	44.03.05ЕН (б) (о)	бакалавриат	152
7549	1	01Х	04.03.01 (б) (о)	бакалавриат	152
7456	1	01ЭП	05.03.06 (п) (о)	бакалавриат	152
7502	1	01Ббф-м	06.04.01БФ (м) (о)	магистратура	152
7684	1	01Бз-м	06.04.01 (м) (о)	магистратура	152
5900	4	71ПГОдодо	44.03.05 (а) (о)	бакалавриат	157
5897	4	71ПГОнор	44.03.05 (а) (о)	бакалавриат	157
5733	4	71ППО	44.03.02 (а) (о)	бакалавриат	157
5720	4	71ПС	37.03.01 (а) (о)	бакалавриат	157
5943	4	71СО	44.03.03 (п) (о)	бакалавриат	157
5941	4	72ППО	44.03.02 (а) (о)	бакалавриат	157
6340	3	81АР	07.03.01 (а) (о)	бакалавриат	5
6438	3	81ГС	07.03.04 (п) (о)	бакалавриат	5
6341	3	81С	08.03.01 (а) (о)	бакалавриат	5
6349	3	81ТБ	20.03.01 (а) (о)	бакалавриат	5
6550	3	82АР	07.03.01 (а) (о)	бакалавриат	5
7535	1	01ПГОфк	44.03.01ФС (б) (о)	бакалавриат	26
7529	1	01Ф	49.03.01 (б) (о)	бакалавриат	26
7417	1	01СП-м	49.04.03 (м) (о)	магистратура	26
7374	1	01ЛНГ	45.03.02ТМ (а) (о)	бакалавриат	164
7555	1	01ПГОии	44.03.05ИЯ (б) (о)	бакалавриат	164
7448	1	02ЛНГ	45.03.02 (а) (о)	бакалавриат	164
7556	1	02ПГОии	44.03.05ИЯ (б) (о)	бакалавриат	164
7449	1	03ЛНГ	45.03.02 (а) (о)	бакалавриат	164
7557	1	03ПГОии	44.03.05ИЯ (б) (о)	бакалавриат	164
7450	1	04ЛНГ	45.03.02 (а) (о)	бакалавриат	164
7558	1	04ПГОии	44.03.05ИЯ (б) (о)	бакалавриат	164
7413	1	01ЛНГ-м	45.04.02 (м) (о)	магистратура	164
7427	1	01ПГОияик-м	44.04.01ИЯ (м) (о)	магистратура	164
6137	5	61ПГОдодо	44.03.05ДО (а) (о)	бакалавриат	157
5265	5	61ПГОнои	44.03.05 (а) (о)	бакалавриат	157
5264	5	61ПГОном	44.03.05 (а) (о)	бакалавриат	157
5263	5	61ПГОнор	44.03.05 (а) (о)	бакалавриат	157
6969	2	910ЛД	31.05.01 (с) (о)	специалитет	488
6970	2	911ЛД	31.05.01 (с) (о)	специалитет	488
6971	2	912ЛД	31.05.01 (с) (о)	специалитет	488
6972	2	913ЛД	31.05.01 (с) (о)	специалитет	488
6973	2	914ЛД	31.05.01 (с) (о)	специалитет	488
6974	2	915ЛД	31.05.01 (с) (о)	специалитет	488
6975	2	916ЛД	31.05.01 (с) (о)	специалитет	488
7007	2	917ЛД	31.05.01 (с) (о)	специалитет	488
7008	2	918ЛД	31.05.01 (с) (о)	специалитет	488
7009	2	919ЛД	31.05.01 (с) (о)	специалитет	488
6886	2	91ЛД	31.05.01 (с) (о)	специалитет	488
7010	2	920ЛД	31.05.01 (с) (о)	специалитет	488
7011	2	921ЛД	31.05.01 (с) (о)	специалитет	488
7012	2	922ЛД	31.05.01 (с) (о)	специалитет	488
7013	2	923ЛД	31.05.01 (с) (о)	специалитет	488
7014	2	924ЛД	31.05.01 (с) (о)	специалитет	488
7015	2	925ЛД	31.05.01 (с) (о)	специалитет	488
7016	2	926ЛД	31.05.01 (с) (о)	специалитет	488
7017	2	927ЛД	31.05.01 (с) (о)	специалитет	488
7018	2	928ЛД	31.05.01 (с) (о)	специалитет	488
7072	2	929ЛД	31.05.01 (с) (о)	специалитет	488
6961	2	92ЛД	31.05.01 (с) (о)	специалитет	488
7073	2	930ЛД	31.05.01 (с) (о)	специалитет	488
7294	2	931ЛД	31.05.01 (с) (о)	специалитет	488
6962	2	93ЛД	31.05.01 (с) (о)	специалитет	488
6963	2	94ЛД	31.05.01 (с) (о)	специалитет	488
6964	2	95ЛД	31.05.01 (с) (о)	специалитет	488
6965	2	96ЛД	31.05.01 (с) (о)	специалитет	488
6966	2	97ЛД	31.05.01 (с) (о)	специалитет	488
6967	2	98ЛД	31.05.01 (с) (о)	специалитет	488
6968	2	99ЛД	31.05.01 (с) (о)	специалитет	488
7565	1	01ПГОном	44.03.05 (б) (о)	бакалавриат	157
7616	1	01ППО	44.03.02ПО (б) (о)	бакалавриат	157
7367	1	01ПС	37.03.01 (а) (о)	бакалавриат	157
6998	2	91АП	15.03.04 (п) (о)	бакалавриат	7
7046	2	91ИБ	10.03.01 (б) (о)	бакалавриат	7
7120	2	91ИВТ	09.03.01 (б) (о)	бакалавриат	7
7110	2	91ИК	11.03.02 (б) (о)	бакалавриат	7
7112	2	91БТ	19.03.01 (а) (о)	бакалавриат	11
7050	2	91ПЖ	19.03.03 (п) (о)	бакалавриат	11
7121	2	91ПР	19.03.02 (п) (о)	бакалавриат	11
7547	1	01СО	44.03.03ДД (б) (о)	бакалавриат	157
7571	1	02СО	44.03.03ЛО (б) (о)	бакалавриат	157
7569	1	01ПГОпэд-м	44.04.01ПЭ (м) (о)	магистратура	157
7610	1	01ПГОтмно-м	44.04.01 (м) (о)	магистратура	157
7410	1	01ППОсп-м	44.04.02 (м) (о)	магистратура	157
7107	2	91ИТ	09.03.02 (б) (о)	бакалавриат	7
7151	2	91КЭ	11.03.03 (б) (о)	бакалавриат	7
7184	2	91НТК	23.03.02 (п) (о)	бакалавриат	7
7258	2	91П	12.03.01 (б) (о)	бакалавриат	7
7109	2	91ПГ	09.03.04 (б) (о)	бакалавриат	7
7108	2	91ПИ	09.03.03 (б) (о)	бакалавриат	7
7186	2	91ПИц	09.03.03Ц (б) (о)	бакалавриат	7
6939	2	91УТ	27.03.04 (п) (о)	бакалавриат	7
7183	2	91ЭФ	13.03.02Э (б) (о)	бакалавриат	7
7286	2	92ПГ	09.03.04 (б) (о)	бакалавриат	7
6903	2	91АП-м	15.04.04 (м) (о)	магистратура	7
6902	2	91КЭ-м	11.04.03 (м) (о)	магистратура	7
6901	2	91ПГ-м	09.04.04 (м) (о)	магистратура	7
6900	2	91ПИ-м	09.04.03 (м) (о)	магистратура	7
7260	2	91П-м	12.04.01 (м) (о)	магистратура	7
7259	2	91УК-м	27.04.02 (м) (о)	магистратура	7
6996	2	91УТ-м	27.04.04 (м) (о)	магистратура	7
6997	2	91ЭЭ-м	13.04.02 (м) (о)	магистратура	7
6954	2	92КЭ-м	11.04.03 (м) (о)	магистратура	7
7057	2	91ТЛ	48.03.01 (б) (о)	бакалавриат	2
7114	2	91Ю	40.03.01 (б) (о)	бакалавриат	2
7131	2	92Ю	40.03.01 (б) (о)	бакалавриат	2
7185	2	91ПГОипо-м	44.04.01ИП (м) (о)	магистратура	2
6935	2	91ТЛ-м	48.04.01 (м) (о)	магистратура	2
6921	2	91Ю-м	40.04.01 (м) (о)	магистратура	2
7047	2	91НБ	40.05.01 (с) (о)	специалитет	2
7378	1	01ИКТ	54.03.03 (а) (о)	бакалавриат	124
7548	1	01КШ	29.03.05 (б) (о)	бакалавриат	124
7454	1	01МХ	15.03.06 (а) (о)	бакалавриат	124
7370	1	01ТТ	23.03.01 (а) (о)	бакалавриат	124
7371	1	01ЭТ	23.03.03 (а) (о)	бакалавриат	124
7393	1	01КТ-м	15.04.05 (м) (о)	магистратура	124
7401	1	01КШ-м	29.04.05 (м) (о)	магистратура	124
7394	1	01МХ-м	15.04.06 (м) (о)	магистратура	124
7399	1	01ТТ-м	23.04.01 (м) (о)	магистратура	124
7595	1	01НТС	23.05.01 (с) (о)	специалитет	124
7594	1	01ПК	15.05.01 (с) (о)	специалитет	124
6885	2	91ИКТ	54.03.03 (а) (о)	бакалавриат	124
7000	2	91КТ	15.03.05 (а) (о)	бакалавриат	124
7190	2	91КШ	29.03.05 (б) (о)	бакалавриат	124
6999	2	91МХ	15.03.06 (а) (о)	бакалавриат	124
6874	2	91ЭТ	23.03.03 (а) (о)	бакалавриат	124
6904	2	91КТ-м	15.04.05 (м) (о)	магистратура	124
6914	2	91КШ-м	29.04.05 (м) (о)	магистратура	124
6905	2	91МХ-м	15.04.06 (м) (о)	магистратура	124
6912	2	91НТ-м	23.04.02 (м) (о)	магистратура	124
6911	2	91ТТ-м	23.04.01 (м) (о)	магистратура	124
6913	2	91ЭТ-м	23.04.03 (м) (о)	магистратура	124
5714	4	71БТ	19.03.01 (а) (о)	бакалавриат	11
5818	4	71ПЖ	19.03.03 (п) (о)	бакалавриат	11
5817	4	71ПР	19.03.02 (п) (о)	бакалавриат	11
5819	4	71ТП	19.03.04 (п) (о)	бакалавриат	11
5746	4	71ТД	38.05.02 (с) (о)	специалитет	11
5883	4	72ТД	38.05.02 (с) (о)	специалитет	11
5262	5	61ПГОии	44.03.05ИЯ (а) (о)	бакалавриат	164
5322	5	62ПГОии	44.03.05ИЯ (а) (о)	бакалавриат	164
5323	5	63ПГОии	44.03.05ИЯ (а) (о)	бакалавриат	164
5324	5	64ПГОии	44.03.05ИЯ (а) (о)	бакалавриат	164
6370	3	81ИКТ	54.03.03 (а) (о)	бакалавриат	124
6545	3	81КТ	15.03.05 (а) (о)	бакалавриат	124
6352	3	81КШ	29.03.05 (а) (о)	бакалавриат	124
6544	3	81МХ	15.03.06 (а) (о)	бакалавриат	124
6350	3	81ТТ	23.03.01 (а) (о)	бакалавриат	124
6351	3	81ЭТ	23.03.03 (а) (о)	бакалавриат	124
5740	4	71ИКТ	54.03.03 (а) (о)	бакалавриат	124
5974	4	71КТ	15.03.05 (а) (о)	бакалавриат	124
5719	4	71КШ	29.03.05 (а) (о)	бакалавриат	124
5973	4	71МХ	15.03.06 (а) (о)	бакалавриат	124
5716	4	71ТТ	23.03.01 (а) (о)	бакалавриат	124
5718	4	71ТШ	29.03.01 (а) (о)	бакалавриат	124
5717	4	71ЭТ	23.03.03 (а) (о)	бакалавриат	124
5975	4	71НТС	23.05.01 (с) (о)	специалитет	124
7105	2	91АР	07.03.01 (б) (о)	бакалавриат	5
7119	2	91ГС	07.03.04 (б) (о)	бакалавриат	5
6910	2	91ТБ-м	20.04.01 (м) (о)	магистратура	152
7287	2	91Х-м	04.04.01 (м) (о)	магистратура	152
6897	2	91ЭП-м	05.04.06 (м) (о)	магистратура	152
7106	2	91С	08.03.01 (б) (о)	бакалавриат	5
7003	2	91АР-м	07.04.01 (м) (о)	магистратура	5
7172	2	91С-м	08.04.01ПС (м) (о)	магистратура	5
7173	2	92С-м	08.04.01ЭЭ (м) (о)	магистратура	5
7388	1	01Г-м	05.04.02 (м) (о)	магистратура	152
7503	1	01ПГОбж-м	44.04.01БЖ (м) (о)	магистратура	152
7611	1	01ПГОб-м	44.04.01Б (м) (о)	магистратура	152
7504	1	01ПГОен-м	44.04.01ЕН (м) (о)	магистратура	152
7398	1	01ТБ-м	20.04.01 (м) (о)	магистратура	152
7576	1	01Х-м	04.04.01 (м) (о)	магистратура	152
7499	1	010СТ	31.05.03 (с) (о)	специалитет	158
7380	1	01ПД	31.05.02 (с) (о)	специалитет	158
7381	1	01СТ	31.05.03 (с) (о)	специалитет	158
7382	1	01ФР	33.05.01 (с) (о)	специалитет	158
7443	1	02ПД	31.05.02 (с) (о)	специалитет	158
7444	1	02СТ	31.05.03 (с) (о)	специалитет	158
7447	1	02ФР	33.05.01 (с) (о)	специалитет	158
7469	1	03ПД	31.05.02 (с) (о)	специалитет	158
7445	1	03СТ	31.05.03 (с) (о)	специалитет	158
7500	1	03ФР	33.05.01 (с) (о)	специалитет	158
7446	1	04СТ	31.05.03 (с) (о)	специалитет	158
7470	1	05СТ	31.05.03 (с) (о)	специалитет	158
7471	1	06СТ	31.05.03 (с) (о)	специалитет	158
7472	1	07СТ	31.05.03 (с) (о)	специалитет	158
7473	1	08СТ	31.05.03 (с) (о)	специалитет	158
7498	1	09СТ	31.05.03 (с) (о)	специалитет	158
7202	2	91ТЭ	38.03.07 (а) (о)	бакалавриат	11
6906	2	91БТ-м	19.04.01 (м) (о)	магистратура	11
6908	2	91ПЖ-м	19.04.03 (м) (о)	магистратура	11
6907	2	91ПР-м	19.04.02 (м) (о)	магистратура	11
6909	2	91ТП-м	19.04.04 (м) (о)	магистратура	11
6891	2	91ТД	38.05.02 (с) (о)	специалитет	11
5735	4	71ЛНГ	45.03.02ТМ (а) (о)	бакалавриат	164
5896	4	71ПГОии	44.03.05ИЯ (а) (о)	бакалавриат	164
5934	4	72ЛНГ	45.03.02 (а) (о)	бакалавриат	164
5938	4	72ПГОии	44.03.05ИЯ (а) (о)	бакалавриат	164
5935	4	73ЛНГ	45.03.02 (а) (о)	бакалавриат	164
5939	4	73ПГОии	44.03.05ИЯ (а) (о)	бакалавриат	164
5936	4	74ЛНГ	45.03.02 (а) (о)	бакалавриат	164
5940	4	74ПГОии	44.03.05ИЯ (а) (о)	бакалавриат	164
7402	1	01ПС-м	37.04.01 (м) (о)	магистратура	157
7411	1	01СО-м	44.04.03 (м) (о)	магистратура	157
7436	1	010ЛД	31.05.01 (с) (о)	специалитет	488
7437	1	011ЛД	31.05.01 (с) (о)	специалитет	488
7438	1	012ЛД	31.05.01 (с) (о)	специалитет	488
7439	1	013ЛД	31.05.01 (с) (о)	специалитет	488
7440	1	014ЛД	31.05.01 (с) (о)	специалитет	488
7441	1	015ЛД	31.05.01 (с) (о)	специалитет	488
7442	1	016ЛД	31.05.01 (с) (о)	специалитет	488
7457	1	017ЛД	31.05.01 (с) (о)	специалитет	488
7458	1	018ЛД	31.05.01 (с) (о)	специалитет	488
7459	1	019ЛД	31.05.01 (с) (о)	специалитет	488
7379	1	01ЛД	31.05.01 (с) (о)	специалитет	488
7460	1	020ЛД	31.05.01 (с) (о)	специалитет	488
7461	1	021ЛД	31.05.01 (с) (о)	специалитет	488
7462	1	022ЛД	31.05.01 (с) (о)	специалитет	488
7463	1	023ЛД	31.05.01 (с) (о)	специалитет	488
7464	1	024ЛД	31.05.01 (с) (о)	специалитет	488
7465	1	025ЛД	31.05.01 (с) (о)	специалитет	488
7466	1	026ЛД	31.05.01 (с) (о)	специалитет	488
7467	1	027ЛД	31.05.01 (с) (о)	специалитет	488
7468	1	028ЛД	31.05.01 (с) (о)	специалитет	488
7496	1	029ЛД	31.05.01 (с) (о)	специалитет	488
7428	1	02ЛД	31.05.01 (с) (о)	специалитет	488
7497	1	030ЛД	31.05.01 (с) (о)	специалитет	488
7429	1	03ЛД	31.05.01 (с) (о)	специалитет	488
7430	1	04ЛД	31.05.01 (с) (о)	специалитет	488
7431	1	05ЛД	31.05.01 (с) (о)	специалитет	488
7432	1	06ЛД	31.05.01 (с) (о)	специалитет	488
7433	1	07ЛД	31.05.01 (с) (о)	специалитет	488
7434	1	08ЛД	31.05.01 (с) (о)	специалитет	488
7435	1	09ЛД	31.05.01 (с) (о)	специалитет	488
6348	3	81БТ	19.03.01 (а) (о)	бакалавриат	11
6440	3	81ПР	19.03.02 (п) (о)	бакалавриат	11
6441	3	81ТП	19.03.04 (п) (о)	бакалавриат	11
6376	3	81ТД	38.05.02 (с) (о)	специалитет	11
6485	3	82ТД	38.05.02 (с) (о)	специалитет	11
\.


--
-- Data for Name: list_person_employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_person_employee (id, id_person, id_employee) FROM stdin;
\.


--
-- Data for Name: list_person_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_person_group (id, id_person, id_group, update) FROM stdin;
41	5	7513	f
42	5	7050	f
43	5	5935	f
44	5	7410	f
45	5	7193	f
46	5	7463	f
48	5	7525	f
51	5	6485	f
\.


--
-- Data for Name: list_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_schedule (id, number_sub_gruop, title_subject, type_lesson, number_lesson, day_week, date_lesson, special, link, pass, zoom_link, zoom_password, id_corpus, id_employee, id_group) FROM stdin;
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 1, true);


--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_role_id_seq', 1, true);


--
-- Name: auth_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_person_id_seq', 28, true);


--
-- Name: auth_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_role_id_seq', 2, true);


--
-- Name: list_corpus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.list_corpus_id_seq', 1, false);


--
-- Name: list_person_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.list_person_employee_id_seq', 1, false);


--
-- Name: list_person_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.list_person_group_id_seq', 51, true);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_role auth_permission_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role
    ADD CONSTRAINT auth_permission_role_pkey PRIMARY KEY (id);


--
-- Name: auth_person auth_person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_person
    ADD CONSTRAINT auth_person_pkey PRIMARY KEY (id);


--
-- Name: auth_role auth_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_role
    ADD CONSTRAINT auth_role_pkey PRIMARY KEY (id);


--
-- Name: list_corpus list_corpus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_corpus
    ADD CONSTRAINT list_corpus_pkey PRIMARY KEY (id);


--
-- Name: list_department list_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_department
    ADD CONSTRAINT list_department_pkey PRIMARY KEY (id);


--
-- Name: list_division list_division_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_division
    ADD CONSTRAINT list_division_pkey PRIMARY KEY (id);


--
-- Name: list_employee list_employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_employee
    ADD CONSTRAINT list_employee_pkey PRIMARY KEY (id);


--
-- Name: list_group list_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_group
    ADD CONSTRAINT list_group_pkey PRIMARY KEY (id);


--
-- Name: list_person_employee list_person_employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_employee
    ADD CONSTRAINT list_person_employee_pkey PRIMARY KEY (id);


--
-- Name: list_person_group list_person_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_group
    ADD CONSTRAINT list_person_group_pkey PRIMARY KEY (id);


--
-- Name: list_schedule list_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_schedule
    ADD CONSTRAINT list_schedule_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_id_idx ON public.auth_permission USING btree (id);


--
-- Name: auth_permission_role_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_role_id_idx ON public.auth_permission_role USING btree (id);


--
-- Name: auth_permission_role_id_permission_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_role_id_permission_idx ON public.auth_permission_role USING btree (id_permission);


--
-- Name: auth_permission_role_id_role_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_role_id_role_idx ON public.auth_permission_role USING btree (id_role);


--
-- Name: auth_person_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_id_idx ON public.auth_person USING btree (id);


--
-- Name: auth_person_id_role_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_id_role_idx ON public.auth_person USING btree (id_role);


--
-- Name: auth_person_login_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_login_idx ON public.auth_person USING btree (login);


--
-- Name: auth_person_login_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_login_key_idx ON public.auth_person USING btree (login_key);


--
-- Name: auth_person_phone_number_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_phone_number_idx ON public.auth_person USING btree (phone_number);


--
-- Name: auth_role_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_role_id_idx ON public.auth_role USING btree (id);


--
-- Name: auth_role_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_role_name_idx ON public.auth_role USING btree (name);


--
-- Name: list_corpus_addres_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_corpus_addres_idx ON public.list_corpus USING btree (addres);


--
-- Name: list_corpus_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_corpus_id_idx ON public.list_corpus USING btree (id);


--
-- Name: list_corpus_short_title_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_corpus_short_title_idx ON public.list_corpus USING btree (short_title);


--
-- Name: list_corpus_title_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_corpus_title_idx ON public.list_corpus USING btree (title);


--
-- Name: list_department_id_division_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_department_id_division_idx ON public.list_department USING btree (id_division);


--
-- Name: list_department_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_department_id_idx ON public.list_department USING btree (id);


--
-- Name: list_division_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_division_id_idx ON public.list_division USING btree (id);


--
-- Name: list_employee_id_department_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_id_department_idx ON public.list_employee USING btree (id_department);


--
-- Name: list_employee_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_id_idx ON public.list_employee USING btree (id);


--
-- Name: list_employee_middle_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_middle_name_idx ON public.list_employee USING btree (middle_name);


--
-- Name: list_employee_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_name_idx ON public.list_employee USING btree (name);


--
-- Name: list_employee_subname_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_subname_idx ON public.list_employee USING btree (subname);


--
-- Name: list_group_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_code_idx ON public.list_group USING btree (code);


--
-- Name: list_group_course_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_course_idx ON public.list_group USING btree (course);


--
-- Name: list_group_id_division_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_id_division_idx ON public.list_group USING btree (id_division);


--
-- Name: list_group_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_id_idx ON public.list_group USING btree (id);


--
-- Name: list_group_title_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_title_idx ON public.list_group USING btree (title);


--
-- Name: list_person_employee_id_employee_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_employee_id_employee_idx ON public.list_person_employee USING btree (id_employee);


--
-- Name: list_person_employee_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_employee_id_idx ON public.list_person_employee USING btree (id);


--
-- Name: list_person_employee_id_person_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_employee_id_person_idx ON public.list_person_employee USING btree (id_person);


--
-- Name: list_person_group_id_group_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_group_id_group_idx ON public.list_person_group USING btree (id_group);


--
-- Name: list_person_group_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_group_id_idx ON public.list_person_group USING btree (id);


--
-- Name: list_person_group_id_person_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_group_id_person_idx ON public.list_person_group USING btree (id_person);


--
-- Name: list_schedule_id_corpus_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_id_corpus_idx ON public.list_schedule USING btree (id_corpus);


--
-- Name: list_schedule_id_employee_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_id_employee_idx ON public.list_schedule USING btree (id_employee);


--
-- Name: list_schedule_id_group_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_id_group_idx ON public.list_schedule USING btree (id_group);


--
-- Name: list_schedule_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_id_idx ON public.list_schedule USING btree (id);


--
-- Name: list_schedule_title_subject_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_title_subject_idx ON public.list_schedule USING btree (title_subject);


--
-- Name: list_schedule_type_lesson_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_type_lesson_idx ON public.list_schedule USING btree (type_lesson);


--
-- Name: auth_permission_role auth_permission_role_id_permission_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role
    ADD CONSTRAINT auth_permission_role_id_permission_fkey FOREIGN KEY (id_permission) REFERENCES public.auth_permission(id);


--
-- Name: auth_permission_role auth_permission_role_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role
    ADD CONSTRAINT auth_permission_role_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.auth_role(id);


--
-- Name: auth_person auth_person_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_person
    ADD CONSTRAINT auth_person_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.auth_role(id);


--
-- Name: list_department list_department_id_division_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_department
    ADD CONSTRAINT list_department_id_division_fkey FOREIGN KEY (id_division) REFERENCES public.list_division(id);


--
-- Name: list_employee list_employee_id_department_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_employee
    ADD CONSTRAINT list_employee_id_department_fkey FOREIGN KEY (id_department) REFERENCES public.list_department(id);


--
-- Name: list_group list_group_id_division_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_group
    ADD CONSTRAINT list_group_id_division_fkey FOREIGN KEY (id_division) REFERENCES public.list_division(id);


--
-- Name: list_person_employee list_person_employee_id_employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_employee
    ADD CONSTRAINT list_person_employee_id_employee_fkey FOREIGN KEY (id_employee) REFERENCES public.list_employee(id);


--
-- Name: list_person_employee list_person_employee_id_person_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_employee
    ADD CONSTRAINT list_person_employee_id_person_fkey FOREIGN KEY (id_person) REFERENCES public.auth_person(id);


--
-- Name: list_person_group list_person_group_id_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_group
    ADD CONSTRAINT list_person_group_id_group_fkey FOREIGN KEY (id_group) REFERENCES public.list_group(id);


--
-- Name: list_person_group list_person_group_id_person_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_group
    ADD CONSTRAINT list_person_group_id_person_fkey FOREIGN KEY (id_person) REFERENCES public.auth_person(id);


--
-- Name: list_schedule list_schedule_id_corpus_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_schedule
    ADD CONSTRAINT list_schedule_id_corpus_fkey FOREIGN KEY (id_corpus) REFERENCES public.list_corpus(id);


--
-- Name: list_schedule list_schedule_id_employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_schedule
    ADD CONSTRAINT list_schedule_id_employee_fkey FOREIGN KEY (id_employee) REFERENCES public.list_employee(id);


--
-- Name: list_schedule list_schedule_id_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_schedule
    ADD CONSTRAINT list_schedule_id_group_fkey FOREIGN KEY (id_group) REFERENCES public.list_group(id);


--
-- PostgreSQL database dump complete
--

