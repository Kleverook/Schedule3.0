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
    id_group integer NOT NULL
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
5	admin	admin	qwe	asd	\N	\N	3521b80d-1ef7-4099-a963-26685bd9ba2b	1
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
19	Kleverookkkkkkk	asdfgh1	Daniil	Pade	\N	\N	37a5d4c9-8097-4ea1-8895-1b6ee7272b74	2
20	Kleverookkkkkkjgkk	asdfgh1	Daniil	Pade	\N	\N	47c66a76-0de9-4781-a51f-c297e1427748	2
21	Kleckkkkjgkk	asdfgh1	Daniil	Pade	\N	\N	af899650-3bd4-4ea5-b54f-93d35421c4d5	2
22	Kleckkkkjgkklkjhgfds	asdfgh1	Daniil	Pade	\N	\N	6ff59faf-f370-4096-9bbf-59f78956505a	2
23	Kleckkkkjgkklkjhgds	asdfgh1	Daniil	Pade	\N	\N	84f63e1d-1c1d-462a-88e8-b0e9cbc2892d	2
24	Kleckkk	asdfgh1	Daniil	Pade	\N	\N	41d5dec3-fd61-440e-a138-bf3eb09eb1aa	2
25	Kleckkkl	asdfgh1	Daniil	Pade	\N	\N	670a8c8f-950c-4e78-a2da-b21c8e80c573	2
26	Kleckkkl0	asdfghj1	Daniil	Pade	\N	\N	2a7dd66b-4e6e-4026-a77c-ffbc197714b7	2
27	Kleckkkl01	asdfgh1	Daniil	Pade	\N	\N	281bdda7-c6a2-4dd0-886c-0285fdcdb175	2
28	Kleckkkl00	asdfgh1	asdfgh	sdfgh	\N	\N	03e34f92-2ecf-4ddd-9a90-67833899bd81	2
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
5	╨Р╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨╜╨╛-╤Б╤В╤А╨╛╨╕╤В╨╡╨╗╤М╨╜╤Л╨╣ ╨╕╨╜╤Б╤В╨╕╤В╤Г╤В	╨Р╨б╨Ш
152	╨Ш╨╜╤Б╤В╨╕╤В╤Г╤В ╨╡╤Б╤В╨╡╤Б╤В╨▓╨╡╨╜╨╜╤Л╤Е ╨╜╨░╤Г╨║ ╨╕  ╨▒╨╕╨╛╤В╨╡╤Е╨╜╨╛╨╗╨╛╨│╨╕╨╕	 ╨Ш╨Х╨Э╨╕╨С
11	╨Ш╨╜╤Б╤В╨╕╤В╤Г╤В ╨╡╤Б╤В╨╡╤Б╤В╨▓╨╡╨╜╨╜╤Л╤Е ╨╜╨░╤Г╨║ ╨╕ ╨▒╨╕╨╛╤В╨╡╤Е╨╜╨╛╨╗╨╛╨│╨╕╨╕	╨Ш╨Х╨Э╨╕╨С
12	╨Ш╨╜╤Б╤В╨╕╤В╤Г╤В ╨╖╨░╨╛╤З╨╜╨╛╨│╨╛ ╨╕ ╨╛╤З╨╜╨╛-╨╖╨░╨╛╤З╨╜╨╛╨│╨╛ ╨╛╨▒╤А╨░╨╖╨╛╨▓╨░╨╜╨╕╤П	╨Ш╨Т╨Ч╨Ю
164	╨Ш╨╜╤Б╤В╨╕╤В╤Г╤В ╨╕╨╜╨╛╤Б╤В╤А╨░╨╜╨╜╤Л╤Е ╤П╨╖╤Л╨║╨╛╨▓	╨Ш╨╜╤П╨╖
157	╨Ш╨╜╤Б╤В╨╕╤В╤Г╤В ╨┐╨╡╨┤╨░╨│╨╛╨│╨╕╨║╨╕ ╨╕ ╨┐╤Б╨╕╤Е╨╛╨╗╨╛╨│╨╕╨╕	╨Ш╨Я╨╕╨Я
7	╨Ш╨╜╤Б╤В╨╕╤В╤Г╤В ╨┐╤А╨╕╨▒╨╛╤А╨╛╤Б╤В╤А╨╛╨╡╨╜╨╕╤П, ╨░╨▓╤В╨╛╨╝╨░╤В╨╕╨╖╨░╤Ж╨╕╨╕ ╨╕ ╨╕╨╜╤Д╨╛╤А╨╝╨░╤Ж╨╕╨╛╨╜╨╜╤Л╤Е ╤В╨╡╤Е╨╜╨╛╨╗╨╛╨│╨╕╨╣	╨Ш╨Я╨Р╨Ш╨в
159	╨е╤Г╨┤╨╛╨╢╨╡╤Б╤В╨▓╨╡╨╜╨╜╨╛-╨│╤А╨░╤Д╨╕╤З╨╡╤Б╨║╨╕╨╣ ╤Д╨░╨║╤Г╨╗╤М╤В╨╡╤В	╨е╨У╨д
2	╨о╤А╨╕╨┤╨╕╤З╨╡╤Б╨║╨╕╨╣ ╨╕╨╜╤Б╤В╨╕╤В╤Г╤В	╨о╨Ш
154	╨Ш╨╜╤Б╤В╨╕╤В╤Г╤В ╤Д╨╕╨╗╨╛╨╗╨╛╨│╨╕╨╕	╨Ш╨д╨╕╨╗
289	╨Ш╨╜╤Б╤В╨╕╤В╤Г╤В ╤Н╨║╨╛╨╜╨╛╨╝╨╕╨║╨╕ ╨╕ ╤Г╨┐╤А╨░╨▓╨╗╨╡╨╜╨╕╤П	╨Ш╨н╨╕╨г
167	╨Ш╤Б╤В╨╛╤А╨╕╤З╨╡╤Б╨║╨╕╨╣ ╤Д╨░╨║╤Г╨╗╤М╤В╨╡╤В	╨Ш╤Б╤В╨д╨░╨║
488	╨Ы╨╡╤З╨╡╨▒╨╜╤Л╨╣ ╤Д╨░╨║╤Г╨╗╤М╤В╨╡╤В	╨Ы╨д
124	╨Я╨╛╨╗╨╕╤В╨╡╤Е╨╜╨╕╤З╨╡╤Б╨║╨╕╨╣ ╨╕╨╜╤Б╤В╨╕╤В╤Г╤В ╨╕╨╝╨╡╨╜╨╕ ╨Э.╨Э. ╨Я╨╛╨╗╨╕╨║╨░╤А╨┐╨╛╨▓╨░	╨Я╨в╨Ш
155	╨б╨╛╤Ж╨╕╨░╨╗╤М╨╜╤Л╨╣ ╤Д╨░╨║╤Г╨╗╤М╤В╨╡╤В	╨б╨╛╤Ж╨д╨░╨║
158	╨д╨░╨║╤Г╨╗╤М╤В╨╡╤В ╨┐╨╡╨┤╨╕╨░╤В╤А╨╕╨╕, ╤Б╤В╨╛╨╝╨░╤В╨╛╨╗╨╛╨│╨╕╨╕ ╨╕ ╤Д╨░╤А╨╝╨░╤Ж╨╕╨╕	╨д╨Я╨б╨╕╨д
163	╨д╨░╨║╤Г╨╗╤М╤В╨╡╤В ╤В╨╡╤Е╨╜╨╛╨╗╨╛╨│╨╕╨╕, ╨┐╤А╨╡╨┤╨┐╤А╨╕╨╜╨╕╨╝╨░╤В╨╡╨╗╤М╤Б╤В╨▓╨░ ╨╕ ╤Б╨╡╤А╨▓╨╕╤Б╨░	╨д╨в╨Я╨╕╨б
26	╨д╨░╨║╤Г╨╗╤М╤В╨╡╤В ╤Д╨╕╨╖╨╕╤З╨╡╤Б╨║╨╛╨╣ ╨║╤Г╨╗╤М╤В╤Г╤А╤Л ╨╕ ╤Б╨┐╨╛╤А╤В╨░	╨д╨д╨Ъ╨б
150	╨д╨╕╨╖╨╕╨║╨╛-╨╝╨░╤В╨╡╨╝╨░╤В╨╕╤З╨╡╤Б╨║╨╕╨╣ ╤Д╨░╨║╤Г╨╗╤М╤В╨╡╤В	╨д╨╕╨╖╨Ь╨░╤В
153	╨д╨╕╨╗╨╛╤Б╨╛╤Д╤Б╨║╨╕╨╣ ╤Д╨░╨║╤Г╨╗╤М╤В╨╡╤В	╨д╨╕╨╗╨╛╤Б
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
\.


--
-- Data for Name: list_person_employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_person_employee (id, id_person, id_employee) FROM stdin;
\.


--
-- Data for Name: list_person_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_person_group (id, id_person, id_group) FROM stdin;
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

SELECT pg_catalog.setval('public.list_person_group_id_seq', 1, false);


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

