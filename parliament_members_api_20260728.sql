--
-- PostgreSQL database dump
--

\restrict P09s7NrlzJ35Qu4Mc9UM3Jws36bHcVrGdkvMBuv9cu5e7EcIMje35VhT4fU2YdF

-- Dumped from database version 18.4 (Postgres.app)
-- Dumped by pg_dump version 18.4

-- Started on 2026-07-28 13:19:26 BST

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

ALTER TABLE IF EXISTS ONLY public.post_holders DROP CONSTRAINT IF EXISTS post_holders_post_id_fkey;
ALTER TABLE IF EXISTS ONLY public.post_holders DROP CONSTRAINT IF EXISTS post_holders_member_id_fkey;
ALTER TABLE IF EXISTS ONLY public.post_departments DROP CONSTRAINT IF EXISTS post_departments_post_id_fkey;
ALTER TABLE IF EXISTS ONLY public.post_departments DROP CONSTRAINT IF EXISTS post_departments_department_id_fkey;
ALTER TABLE IF EXISTS ONLY public.member_contacts DROP CONSTRAINT IF EXISTS member_contacts_member_id_fkey;
DROP INDEX IF EXISTS public.idx_post_holders_post;
DROP INDEX IF EXISTS public.idx_post_holders_member;
DROP INDEX IF EXISTS public.idx_member_contacts_member;
ALTER TABLE IF EXISTS ONLY public.posts DROP CONSTRAINT IF EXISTS posts_pkey;
ALTER TABLE IF EXISTS ONLY public.post_holders DROP CONSTRAINT IF EXISTS post_holders_post_id_member_id_start_date_key;
ALTER TABLE IF EXISTS ONLY public.post_holders DROP CONSTRAINT IF EXISTS post_holders_pkey;
ALTER TABLE IF EXISTS ONLY public.post_departments DROP CONSTRAINT IF EXISTS post_departments_pkey;
ALTER TABLE IF EXISTS ONLY public.members DROP CONSTRAINT IF EXISTS members_pkey;
ALTER TABLE IF EXISTS ONLY public.member_contacts DROP CONSTRAINT IF EXISTS member_contacts_pkey;
ALTER TABLE IF EXISTS ONLY public.departments DROP CONSTRAINT IF EXISTS departments_pkey;
ALTER TABLE IF EXISTS public.post_holders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.member_contacts ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public.posts;
DROP SEQUENCE IF EXISTS public.post_holders_id_seq;
DROP TABLE IF EXISTS public.post_holders;
DROP TABLE IF EXISTS public.post_departments;
DROP TABLE IF EXISTS public.members;
DROP SEQUENCE IF EXISTS public.member_contacts_id_seq;
DROP TABLE IF EXISTS public.member_contacts;
DROP TABLE IF EXISTS public.departments;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16841)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16902)
-- Name: member_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.member_contacts (
    id integer NOT NULL,
    member_id integer NOT NULL,
    type text,
    phone text,
    email text,
    line1 text
);


ALTER TABLE public.member_contacts OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16901)
-- Name: member_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.member_contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.member_contacts_id_seq OWNER TO postgres;

--
-- TOC entry 3875 (class 0 OID 0)
-- Dependencies: 225
-- Name: member_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.member_contacts_id_seq OWNED BY public.member_contacts.id;


--
-- TOC entry 222 (class 1259 OID 16867)
-- Name: members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.members (
    id integer NOT NULL,
    name_display_as text,
    name_full_title text,
    party_name text,
    gender text
);


ALTER TABLE public.members OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16850)
-- Name: post_departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_departments (
    post_id integer NOT NULL,
    department_id integer NOT NULL
);


ALTER TABLE public.post_departments OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16876)
-- Name: post_holders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_holders (
    id integer NOT NULL,
    post_id integer NOT NULL,
    member_id integer NOT NULL,
    start_date date,
    end_date date,
    laying_minister_name text
);


ALTER TABLE public.post_holders OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16875)
-- Name: post_holders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_holders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.post_holders_id_seq OWNER TO postgres;

--
-- TOC entry 3876 (class 0 OID 0)
-- Dependencies: 223
-- Name: post_holders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_holders_id_seq OWNED BY public.post_holders.id;


--
-- TOC entry 219 (class 1259 OID 16832)
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    name text NOT NULL,
    hansard_name text
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- TOC entry 3692 (class 2604 OID 16905)
-- Name: member_contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_contacts ALTER COLUMN id SET DEFAULT nextval('public.member_contacts_id_seq'::regclass);


--
-- TOC entry 3691 (class 2604 OID 16879)
-- Name: post_holders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_holders ALTER COLUMN id SET DEFAULT nextval('public.post_holders_id_seq'::regclass);


--
-- TOC entry 3863 (class 0 OID 16841)
-- Dependencies: 220
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departments VALUES (1006, 'Department for Business and Trade ');
INSERT INTO public.departments VALUES (119, 'UK Export Finance');
INSERT INTO public.departments VALUES (1005, 'Department for Science, Innovation and Technology');
INSERT INTO public.departments VALUES (15, 'Department for Culture, Media and Sport');
INSERT INTO public.departments VALUES (87, 'Prime Minister');
INSERT INTO public.departments VALUES (5, 'Cabinet Office');
INSERT INTO public.departments VALUES (50, 'HM Treasury');
INSERT INTO public.departments VALUES (1002, 'Foreign, Commonwealth and Development Office');
INSERT INTO public.departments VALUES (51, 'Home Office');
INSERT INTO public.departments VALUES (64, 'Ministry of Defence');
INSERT INTO public.departments VALUES (67, 'Ministry of Justice');
INSERT INTO public.departments VALUES (118, 'Department of Health and Social Care');
INSERT INTO public.departments VALUES (99, 'Department for Education');
INSERT INTO public.departments VALUES (117, 'Ministry of Housing, Communities and Local Government');
INSERT INTO public.departments VALUES (1004, 'Department for Energy Security and Net Zero');
INSERT INTO public.departments VALUES (24, 'Department for Work and Pensions');
INSERT INTO public.departments VALUES (1007, 'Department for Business, Innovation, Science and Trade');
INSERT INTO public.departments VALUES (18, 'Department for Environment, Food and Rural Affairs');
INSERT INTO public.departments VALUES (23, 'Department for Transport');
INSERT INTO public.departments VALUES (80, 'Northern Ireland Office');
INSERT INTO public.departments VALUES (90, 'Scotland Office');
INSERT INTO public.departments VALUES (95, 'Wales Office');
INSERT INTO public.departments VALUES (116, 'Department for Digital, Culture, Media and Sport');
INSERT INTO public.departments VALUES (52, 'Office of the Leader of the House of Lords');
INSERT INTO public.departments VALUES (55, 'Office of the Leader of the House of Commons');
INSERT INTO public.departments VALUES (3, 'Attorney General''s Office');


--
-- TOC entry 3869 (class 0 OID 16902)
-- Dependencies: 226
-- Data for Name: member_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.member_contacts VALUES (1104, 1427, 'Parliamentary office', NULL, 'andy.burnham.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1105, 400, 'Parliamentary office', '020 7219 4031', 'john.healey.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1106, 400, 'Constituency office', '01709 875943', 'john.healey.mp@parliament.uk', '79 High Street');
INSERT INTO public.member_contacts VALUES (1107, 400, 'Website', NULL, NULL, 'http://www.johnhealeymp.co.uk');
INSERT INTO public.member_contacts VALUES (1108, 400, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/JohnHealey_MP');
INSERT INTO public.member_contacts VALUES (1109, 4473, 'Parliamentary office', '0207 219 5255', 'louise.haigh.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1110, 4473, 'Constituency office', '0114 250 8113', 'louise.haigh.mp@parliament.uk', 'Constituency office');
INSERT INTO public.member_contacts VALUES (1111, 4473, 'Website', NULL, NULL, 'http://www.louisehaigh.org.uk/');
INSERT INTO public.member_contacts VALUES (1112, 4473, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/louhaigh');
INSERT INTO public.member_contacts VALUES (1113, 1510, 'Parliamentary office', '020 7219 7318', 'ed.miliband.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1114, 1510, 'Constituency office', '01302875462', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1115, 1510, 'Facebook', NULL, NULL, 'https://www.facebook.com/edmiliband');
INSERT INTO public.member_contacts VALUES (1116, 1510, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/Ed_Miliband');
INSERT INTO public.member_contacts VALUES (1117, 3914, 'Parliamentary office', '0121 661 9440', 'shabana.mahmood.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1118, 3914, 'Website', NULL, NULL, 'https://www.shabanamahmood.org');
INSERT INTO public.member_contacts VALUES (1119, 3914, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/ShabanaMahmood');
INSERT INTO public.member_contacts VALUES (1120, 4504, 'Parliamentary office', '020 7219 6132', 'wes.streeting.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1121, 4504, 'Constituency office', '0203 475 7901', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1122, 4504, 'Website', NULL, NULL, 'http://www.wesstreeting.org/');
INSERT INTO public.member_contacts VALUES (1123, 4504, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/wesstreeting');
INSERT INTO public.member_contacts VALUES (1124, 4641, 'Parliamentary office', '0207 219 3899', 'alex.norris.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1125, 4641, 'Constituency office', '0115 975 2377', NULL, '15 Commercial Road');
INSERT INTO public.member_contacts VALUES (1126, 4641, 'Facebook', NULL, NULL, 'https://www.facebook.com/AlexforNottmNorthandKimberley');
INSERT INTO public.member_contacts VALUES (1127, 4641, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/AlexJJNorris');
INSERT INTO public.member_contacts VALUES (1128, 420, 'Parliamentary office', '020 7219 5080', 'coopery@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1129, 420, 'Constituency office', '01977 553388', 'coopery@parliament.uk', 'Queen''s Mill');
INSERT INTO public.member_contacts VALUES (1130, 420, 'Website', NULL, NULL, 'http://www.yvettecooper.com');
INSERT INTO public.member_contacts VALUES (1131, 420, 'Facebook', NULL, NULL, 'https://www.facebook.com/YvetteCooperMP');
INSERT INTO public.member_contacts VALUES (1132, 420, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/YvetteCooperMP');
INSERT INTO public.member_contacts VALUES (1185, 5038, 'Parliamentary office', NULL, 'anneliese.midgley.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1186, 5038, 'Constituency office', '0151 305 9026', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1187, 5038, 'Facebook', NULL, NULL, 'https://www.facebook.com/annelieseforknowsley');
INSERT INTO public.member_contacts VALUES (1188, 5038, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/anneliese_midge');
INSERT INTO public.member_contacts VALUES (1133, 4263, 'Parliamentary office', '020 7219 4402', 'contact@lucypowell.org.uk ', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1134, 4263, 'Constituency office', '020 3084 9046', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1135, 4263, 'Website', NULL, NULL, 'http://lucypowell.org.uk/');
INSERT INTO public.member_contacts VALUES (1136, 4263, 'Facebook', NULL, NULL, 'https://www.facebook.com/lucy4mcr/');
INSERT INTO public.member_contacts VALUES (1137, 4263, 'Instagram', NULL, NULL, 'https://www.instagram.com/lucympowell/?hl=en');
INSERT INTO public.member_contacts VALUES (1138, 4263, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/LucyMPowell');
INSERT INTO public.member_contacts VALUES (1139, 4046, 'Parliamentary office', '020 7219 7087', 'bridget.phillipson.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1140, 4046, 'Constituency office', '0191 584 4317', NULL, '106 Newbottle Street');
INSERT INTO public.member_contacts VALUES (1141, 4046, 'Website', NULL, NULL, 'http://www.BridgetPhillipson.com');
INSERT INTO public.member_contacts VALUES (1142, 4046, 'Facebook', NULL, NULL, 'https://www.facebook.com/bridgetphillipson');
INSERT INTO public.member_contacts VALUES (1143, 4046, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/bphillipsonMP');
INSERT INTO public.member_contacts VALUES (1144, 4356, 'Parliamentary office', '020 7219 8782', 'angela.rayner.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1145, 4356, 'Constituency office', '0161 342 5800', NULL, 'Ashton Market Hall');
INSERT INTO public.member_contacts VALUES (1146, 4356, 'Website', NULL, NULL, 'https://www.angelarayner.co.uk/');
INSERT INTO public.member_contacts VALUES (1147, 4356, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/angelarayner');
INSERT INTO public.member_contacts VALUES (1148, 5099, 'Parliamentary office', '02072197634', 'miatta.fahnbulleh.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1149, 1587, 'Parliamentary office', '020 7219 4036', 'mcfaddenp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1150, 1587, 'Constituency office', '01902 405762', '', 'Crescent House');
INSERT INTO public.member_contacts VALUES (1151, 1587, 'Website', NULL, NULL, 'http://www.patmcfadden.com');
INSERT INTO public.member_contacts VALUES (1152, 1587, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/patmcfaddenmp');
INSERT INTO public.member_contacts VALUES (1153, 4119, 'Parliamentary office', NULL, 'jonathan.reynolds.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1154, 4119, 'Constituency office', '0161 367 8077', '', 'Hyde Town Hall');
INSERT INTO public.member_contacts VALUES (1155, 4119, 'Website', NULL, NULL, 'http://www.jonathanreynolds.org.uk');
INSERT INTO public.member_contacts VALUES (1156, 4119, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/jreynoldsMP');
INSERT INTO public.member_contacts VALUES (1157, 491, 'Parliamentary office', '020 7219 5057', 'angela.eagle.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1158, 491, 'Constituency office', '0151 637 1979', '', 'Sherlock House');
INSERT INTO public.member_contacts VALUES (1159, 491, 'Facebook', NULL, NULL, 'https://www.facebook.com/angela4labour/');
INSERT INTO public.member_contacts VALUES (1160, 491, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/angelaeagle');
INSERT INTO public.member_contacts VALUES (1161, 4038, 'Parliamentary office', NULL, 'heidi.alexander.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1162, 4038, 'Website', NULL, NULL, 'https://www.heidialexander.org.uk');
INSERT INTO public.member_contacts VALUES (1163, 4038, 'Facebook', NULL, NULL, 'https://facebook.com/heidialexanderswindon');
INSERT INTO public.member_contacts VALUES (1164, 4038, 'Instagram', NULL, NULL, 'https://instagram.com/heidi_labour');
INSERT INTO public.member_contacts VALUES (1165, 4038, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/heidi_labour');
INSERT INTO public.member_contacts VALUES (1166, 1446, 'Parliamentary office', '020 7219 8315', 'chris.bryant.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1167, 1446, 'Constituency office', '01443 442521', 'garethw.hughes@parliament.uk', '9 Compton Road');
INSERT INTO public.member_contacts VALUES (1168, 1446, 'Website', NULL, NULL, 'http://www.chrisbryant.org.uk/');
INSERT INTO public.member_contacts VALUES (1169, 632, 'Parliamentary office', NULL, 'douglas.alexander.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1170, 632, 'Website', NULL, NULL, 'https://douglasalexandermp.com');
INSERT INTO public.member_contacts VALUES (1171, 632, 'Facebook', NULL, NULL, 'https://www.facebook.com/douglas4eastlothian');
INSERT INTO public.member_contacts VALUES (1172, 632, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/D_G_Alexander');
INSERT INTO public.member_contacts VALUES (1173, 4359, 'Parliamentary office', '020 7219 8801', 'stephen.kinnock.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1174, 4359, 'Website', NULL, NULL, 'http://www.stephenkinnock.co.uk/');
INSERT INTO public.member_contacts VALUES (1175, 4359, 'Facebook', NULL, NULL, 'https://www.facebook.com/stephenkinnock');
INSERT INTO public.member_contacts VALUES (1176, 4359, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/skinnock');
INSERT INTO public.member_contacts VALUES (1177, 4082, 'Parliamentary office', '020 7219 3000', 'lisa.nandy.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1178, 4082, 'Constituency office', '01942 242 047', NULL, '2nd Floor');
INSERT INTO public.member_contacts VALUES (1179, 4082, 'Website', NULL, NULL, 'https://lisanandy.laboursites.org');
INSERT INTO public.member_contacts VALUES (1180, 4170, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk ', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1189, 4077, 'Parliamentary office', '020 7219 3000', 'emma.reynolds.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (248, 5235, 'Constituency office', '07594 530309', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1181, 529, 'Parliamentary office', '020 7219 3000', 'alan.campbell.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1182, 529, 'Constituency office', '0191 257 1927', NULL, 'Suite 1:11');
INSERT INTO public.member_contacts VALUES (1183, 529, 'Website', NULL, NULL, 'http://www.alancampbellmp.co.uk');
INSERT INTO public.member_contacts VALUES (1184, 529, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/alancampbellmp');
INSERT INTO public.member_contacts VALUES (1190, 4077, 'Website', NULL, NULL, 'www.emmaforwycombe.org.uk');
INSERT INTO public.member_contacts VALUES (1191, 4077, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/emmaforwycombe');
INSERT INTO public.member_contacts VALUES (1192, 4620, 'Parliamentary office', '020 7219 2589', 'ellie.reeves.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1193, 4620, 'Constituency office', '020 7219 2668', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1194, 4620, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/elliereeves');
INSERT INTO public.member_contacts VALUES (1195, 5039, 'Parliamentary office', NULL, 'kanishka.narayan.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1196, 5148, 'Parliamentary office', '01522 449638', 'hamish.falconer.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1197, 5148, 'Constituency office', '01522 449638', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1198, 4520, 'Parliamentary office', '020 7219 6280', 'matthew.pennycook.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1199, 4520, 'Government department', NULL, NULL, 'Ministry of Housing, Communities and Local Government');
INSERT INTO public.member_contacts VALUES (1200, 4520, 'Website', NULL, NULL, 'http://www.matthewpennycook.com/');
INSERT INTO public.member_contacts VALUES (1201, 4520, 'Bluesky', NULL, NULL, 'https://bsky.app/profile/matthewpennycookmp.bsky.social');
INSERT INTO public.member_contacts VALUES (1202, 4520, 'Facebook', NULL, NULL, 'https://www.facebook.com/MPennycook');
INSERT INTO public.member_contacts VALUES (1203, 4520, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/mtpennycook');
INSERT INTO public.member_contacts VALUES (1204, 1516, 'Parliamentary office', '020 7219 4990', 'slaughtera@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1205, 1516, 'Constituency office', '020 7610 1950', 'andy@andyslaughter.com', '28 Greyhound Road');
INSERT INTO public.member_contacts VALUES (1206, 1516, 'Website', NULL, NULL, 'http://www.andyslaughter.co.uk');
INSERT INTO public.member_contacts VALUES (1207, 1516, 'Facebook', NULL, NULL, 'https://www.facebook.com/andy4hammersmith');
INSERT INTO public.member_contacts VALUES (1208, 1516, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/hammersmithandy');
INSERT INTO public.member_contacts VALUES (1209, 4243, 'Parliamentary office', '0207 219 1082', 'dan.jarvis.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1210, 4243, 'Constituency office', '01226 787893', 'dan.jarvis.mp@parliament.uk', 'Corporate Mail Room');
INSERT INTO public.member_contacts VALUES (1211, 4243, 'Website', NULL, NULL, 'https://www.danjarvis.org');
INSERT INTO public.member_contacts VALUES (1212, 4243, 'Facebook', NULL, NULL, 'https://www.facebook.com/DanJarvisMBE');
INSERT INTO public.member_contacts VALUES (1213, 4243, 'Instagram', NULL, NULL, 'https://www.instagram.com/danjarvis_mp/');
INSERT INTO public.member_contacts VALUES (1214, 4243, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/DanJarvisMBE');
INSERT INTO public.member_contacts VALUES (1215, 5031, 'Parliamentary office', NULL, 'mark.ferguson.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1216, 5031, 'Constituency office', '0191 429 8200', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1217, 5031, 'Facebook', NULL, NULL, 'https://www.facebook.com/people/Mark-Ferguson-for-Gateshead-Central-and-Whickham/61560612202018/');
INSERT INTO public.member_contacts VALUES (1218, 5031, 'Instagram', NULL, NULL, 'https://www.instagram.com/markfergusonmp/');
INSERT INTO public.member_contacts VALUES (1219, 5031, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/markfergusonmp');
INSERT INTO public.member_contacts VALUES (1220, 4966, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1221, 5282, 'Parliamentary office', '020 7219 6510', 'dan.tomlinson.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1222, 5282, 'Facebook', NULL, NULL, 'https://www.facebook.com/dan4barnet');
INSERT INTO public.member_contacts VALUES (1223, 5282, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/dan4barnet');
INSERT INTO public.member_contacts VALUES (1224, 5178, 'Parliamentary office', '020 7219 7105', 'sally.jameson.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1225, 5178, 'Constituency office', '01302 326297', NULL, '19 Southmall');
INSERT INTO public.member_contacts VALUES (1226, 5178, 'Facebook', NULL, NULL, 'https://www.facebook.com/SallyJamesonLabour');
INSERT INTO public.member_contacts VALUES (1227, 5178, 'Instagram', NULL, NULL, 'https://www.instagram.com/Sally.Jameson/');
INSERT INTO public.member_contacts VALUES (1228, 5178, 'TikTok', NULL, NULL, 'https://www.tiktok.com/@sallyjamesonmp');
INSERT INTO public.member_contacts VALUES (1229, 5178, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/SallyJameson');
INSERT INTO public.member_contacts VALUES (1230, 4645, 'Parliamentary office', NULL, 'emma.hardy.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1231, 4645, 'Constituency office', '01482 219211', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1232, 4653, 'Parliamentary office', '0207 219 3906', 'stephen.morgan.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1233, 4653, 'Constituency office', '023 9229 1088', NULL, '72 Albert Road');
INSERT INTO public.member_contacts VALUES (1234, 4653, 'Website', NULL, NULL, 'http://www.stephenmorgan.org.uk/');
INSERT INTO public.member_contacts VALUES (1235, 4653, 'Facebook', NULL, NULL, 'https://www.facebook.com/StephenMorganMP');
INSERT INTO public.member_contacts VALUES (1236, 4653, 'Instagram', NULL, NULL, 'https://www.instagram.com/stephenmorganmp/');
INSERT INTO public.member_contacts VALUES (1237, 4653, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/stephenmorganmp');
INSERT INTO public.member_contacts VALUES (1238, 5160, 'Parliamentary office', NULL, 'jenny.riddellcarpenter.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1239, 4395, 'Parliamentary office', '020 7219 4554', 'haymans@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1240, 4395, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/suehayman1');
INSERT INTO public.member_contacts VALUES (1241, 4972, 'Parliamentary office', '0207 219 5353', 'hendyp@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1242, 4418, 'Parliamentary office', '020 7219 6584', 'justin.madders.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1243, 4418, 'Constituency office', '0151 355 2365', 'justin.madders.mp@parliament.uk', '31 Whitby Road');
INSERT INTO public.member_contacts VALUES (1244, 4418, 'Website', NULL, NULL, 'http://www.justinmadders.com/');
INSERT INTO public.member_contacts VALUES (1245, 4418, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/justinmadders');
INSERT INTO public.member_contacts VALUES (1246, 4993, 'Parliamentary office', NULL, 'keir.mather.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1247, 4993, 'Constituency office', '01757 247 990', 'keir.mather.mp@parliament.uk', 'The Office of Keir Mather MP');
INSERT INTO public.member_contacts VALUES (1248, 4993, 'Website', NULL, NULL, 'https://www.keirmather.org/');
INSERT INTO public.member_contacts VALUES (1249, 4993, 'Facebook', NULL, NULL, 'https://www.facebook.com/KeirMatherLabour/ ');
INSERT INTO public.member_contacts VALUES (1250, 4993, 'Instagram', NULL, NULL, 'https://www.instagram.com/keirmathermp');
INSERT INTO public.member_contacts VALUES (1251, 4993, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/Mather_Keir');
INSERT INTO public.member_contacts VALUES (1252, 4943, 'Parliamentary office', NULL, 'simon.lightwood.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1253, 4943, 'Constituency office', '01924 682269', NULL, '16 Westmorland Street');
INSERT INTO public.member_contacts VALUES (1254, 4943, 'Website', NULL, NULL, 'https://www.simonlightwood.org.uk');
INSERT INTO public.member_contacts VALUES (1255, 4943, 'Facebook', NULL, NULL, 'https://www.facebook.com/simonlightwoodmp');
INSERT INTO public.member_contacts VALUES (1256, 4943, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/simonlightwood');
INSERT INTO public.member_contacts VALUES (1257, 4979, 'Parliamentary office', NULL, 'andrew.western.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1258, 4979, 'Constituency office', '0161 749 9120', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1259, 4979, 'Government department', NULL, NULL, 'DWP Ministerial Correspondence Team');
INSERT INTO public.member_contacts VALUES (1260, 4979, 'Facebook', NULL, NULL, 'https://www.facebook.com/AndrewWesternLabour');
INSERT INTO public.member_contacts VALUES (1261, 4979, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/andrewhwestern');
INSERT INTO public.member_contacts VALUES (1262, 269, 'Parliamentary office', '020 7219 5353', 'smithjq@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1263, 163, 'Parliamentary office', '020 7219 4000', 'timmss@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1264, 163, 'Constituency office', NULL, 'stephen@stephentimms.org.uk', 'Constituency office');
INSERT INTO public.member_contacts VALUES (1265, 163, 'Website', NULL, NULL, 'http://www.stephentimms.org.uk');
INSERT INTO public.member_contacts VALUES (1266, 163, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/stephenctimms');
INSERT INTO public.member_contacts VALUES (1267, 4147, 'Parliamentary office', '020 7219 5353', 'sherlockm@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1268, 4147, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/MaeveSherlock');
INSERT INTO public.member_contacts VALUES (1269, 4029, 'Parliamentary office', '020 7219 7122', 'lilian.greenwood.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1270, 4029, 'Constituency office', '0115 711 7000', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1271, 4029, 'Website', NULL, NULL, 'http://www.liliangreenwood.co.uk/');
INSERT INTO public.member_contacts VALUES (1272, 4029, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/LilianGreenwood');
INSERT INTO public.member_contacts VALUES (1273, 5069, 'Parliamentary office', NULL, 'torsten.bell.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1274, 5069, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/TorstenBell');
INSERT INTO public.member_contacts VALUES (1275, 5333, 'Parliamentary office', '0207 219 7605', 'lucy.rigby.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1276, 5333, 'Constituency office', '01604 915131', 'lucy.rigby.casework@parliament.uk', 'Constituency office');
INSERT INTO public.member_contacts VALUES (1277, 5430, 'Parliamentary office', '020 7219 3000', 'pittwatsond@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1278, 5430, 'Website', NULL, NULL, 'https://pitt-watson.com/');
INSERT INTO public.member_contacts VALUES (1279, 5041, 'Parliamentary office', '01952 973 714', 'shaun.davies.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1280, 5041, 'Website', NULL, NULL, 'https://www.shaundavies.org/');
INSERT INTO public.member_contacts VALUES (1281, 5041, 'Facebook', NULL, NULL, 'https://www.facebook.com/ShaunDaviesMP/');
INSERT INTO public.member_contacts VALUES (1282, 5113, 'Parliamentary office', NULL, 'claire.hughes.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1283, 5167, 'Parliamentary office', NULL, 'gregor.poynton.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1284, 5167, 'Constituency office', NULL, NULL, 'Craigsfarm Community Hub');
INSERT INTO public.member_contacts VALUES (1285, 5167, 'Website', NULL, NULL, 'http://www.gregorpoynton.com/');
INSERT INTO public.member_contacts VALUES (1286, 5167, 'Facebook', NULL, NULL, 'https://www.facebook.com/GregorPoyntonLabour');
INSERT INTO public.member_contacts VALUES (1287, 5167, 'Instagram', NULL, NULL, 'https://www.instagram.com/gregorpoynton/');
INSERT INTO public.member_contacts VALUES (1288, 5167, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/gregorpoynton');
INSERT INTO public.member_contacts VALUES (1289, 5236, 'Parliamentary office', '0207 219 7012', 'jade.botterill.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1290, 5236, 'Constituency office', '01924 208354', 'jade.botterill.mp@parliament.uk ', '3 Wellgate Centre');
INSERT INTO public.member_contacts VALUES (1291, 4871, 'Parliamentary office', '020 7219 6437', 'christian.wakeford.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1292, 4871, 'Constituency office', '01615330801', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1293, 4871, 'Website', NULL, NULL, 'https://www.christianwakeford.org.uk');
INSERT INTO public.member_contacts VALUES (1294, 4449, 'Parliamentary office', NULL, 'anna.turley.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1295, 4449, 'Constituency office', '01642 929159', NULL, 'The Palace Hub');
INSERT INTO public.member_contacts VALUES (1296, 4449, 'Website', NULL, NULL, 'https://www.annaturley.org/');
INSERT INTO public.member_contacts VALUES (1297, 4449, 'Facebook', NULL, NULL, 'https://www.facebook.com/Anna4Redcar/');
INSERT INTO public.member_contacts VALUES (1298, 4449, 'LinkedIn', NULL, NULL, 'https://www.linkedin.com/in/anna-turley-8b666519b/');
INSERT INTO public.member_contacts VALUES (1299, 4449, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/annaturley');
INSERT INTO public.member_contacts VALUES (1300, 4631, 'Parliamentary office', '0207 219 2963', 'sarah.jones.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1301, 4631, 'Constituency office', '0208 191 7066', NULL, 'Unit 2150');
INSERT INTO public.member_contacts VALUES (1302, 4631, 'Website', NULL, NULL, 'http://www.sarah-jones.org/');
INSERT INTO public.member_contacts VALUES (1303, 4631, 'Facebook', NULL, NULL, 'https://www.facebook.com/CroydonSarah');
INSERT INTO public.member_contacts VALUES (1304, 4631, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/LabourSJ');
INSERT INTO public.member_contacts VALUES (1305, 533, 'Parliamentary office', '020 7219 5353', 'hansond@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1306, 5105, 'Parliamentary office', NULL, 'jo.white.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1307, 5105, 'Constituency office', '01909 212171', NULL, 'The Crossing Church & Centre');
INSERT INTO public.member_contacts VALUES (1308, 5105, 'Website', NULL, NULL, 'https://www.jowhite.uk');
INSERT INTO public.member_contacts VALUES (1309, 5105, 'Facebook', NULL, NULL, 'https://www.facebook.com/jowhitebassetlaw');
INSERT INTO public.member_contacts VALUES (1310, 4222, 'Parliamentary office', '020 7219 1675', 'collinsr@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1311, 4222, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/Lord_Collins');
INSERT INTO public.member_contacts VALUES (1312, 5271, 'Parliamentary office', NULL, 'satvir.kaur.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1313, 5271, 'Website', NULL, NULL, 'https://satvirkaur.info');
INSERT INTO public.member_contacts VALUES (1314, 5271, 'Facebook', NULL, NULL, 'https://facebook.com/laboursatvir');
INSERT INTO public.member_contacts VALUES (1315, 5271, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/laboursatvir');
INSERT INTO public.member_contacts VALUES (1316, 4682, 'Parliamentary office', '0207 219 2749', 'luke.pollard.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1317, 4682, 'Constituency office', '01752 717 255', 'luke.pollard.mp@parliament.uk', '13 Frankfort Gate');
INSERT INTO public.member_contacts VALUES (1318, 4682, 'Website', NULL, NULL, 'http://www.lukepollard.org/');
INSERT INTO public.member_contacts VALUES (1319, 4682, 'Facebook', NULL, NULL, 'https://www.facebook.com/LukePollard/');
INSERT INTO public.member_contacts VALUES (1320, 4682, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/LukePollard');
INSERT INTO public.member_contacts VALUES (1321, 360, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1322, 360, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/Vernon_Coaker');
INSERT INTO public.member_contacts VALUES (1323, 5258, 'Parliamentary office', NULL, 'louise.sandherjones.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1324, 5258, 'Constituency office', '01246 439120', NULL, 'Eckington Business Centre');
INSERT INTO public.member_contacts VALUES (1325, 5258, 'Facebook', NULL, NULL, 'https://www.facebook.com/Louisejones4ned');
INSERT INTO public.member_contacts VALUES (1326, 5258, 'Instagram', NULL, NULL, 'https://www.instagram.com/LouiseJones4NED');
INSERT INTO public.member_contacts VALUES (1327, 5258, 'X (formerly Twitter)', NULL, NULL, 'https://www.x.com/Louise_Jones_MP');
INSERT INTO public.member_contacts VALUES (1328, 5054, 'Parliamentary office', NULL, 'calvin.bailey.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1329, 5054, 'Website', NULL, NULL, 'https://www.calvinbailey.co.uk/');
INSERT INTO public.member_contacts VALUES (1330, 5054, 'Facebook', NULL, NULL, 'https://www.facebook.com/profile.php?id=61569349976743 ');
INSERT INTO public.member_contacts VALUES (1331, 5054, 'Instagram', NULL, NULL, 'https://www.instagram.com/calvinbaileymp');
INSERT INTO public.member_contacts VALUES (1332, 5054, 'LinkedIn', NULL, NULL, 'https://www.linkedin.com/in/calvin-bailey-mp/');
INSERT INTO public.member_contacts VALUES (1333, 5054, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/CalvinBailey');
INSERT INTO public.member_contacts VALUES (1334, 4125, 'Parliamentary office', '020 7219 7115', 'catherine.mckinnell.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1335, 4125, 'Constituency office', '0191 229 0352', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1336, 4125, 'Website', NULL, NULL, 'http://www.catherinemckinnellmp.co.uk/');
INSERT INTO public.member_contacts VALUES (1337, 4125, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/CMcKinnellMP');
INSERT INTO public.member_contacts VALUES (1338, 5204, 'Parliamentary office', NULL, 'sarah.sackman.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1339, 5382, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1340, 4849, 'Parliamentary office', '0207 219 4981', 'alex.daviesjones.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1341, 4849, 'Constituency office', '01443 401122', NULL, '10 Market Street');
INSERT INTO public.member_contacts VALUES (1342, 4849, 'Website', NULL, NULL, 'https://alexdaviesjones.laboursites.org/');
INSERT INTO public.member_contacts VALUES (1343, 4849, 'Facebook', NULL, NULL, 'https://www.facebook.com/AlexDaviesJonesMP/');
INSERT INTO public.member_contacts VALUES (1344, 4849, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/AlexDaviesJones');
INSERT INTO public.member_contacts VALUES (1345, 5082, 'Parliamentary office', NULL, 'jake.richards.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1346, 5082, 'Constituency office', '01909 384605', NULL, '39 Laughton Road');
INSERT INTO public.member_contacts VALUES (1347, 5082, 'Website', NULL, NULL, 'https://www.jakerichards.co.uk/');
INSERT INTO public.member_contacts VALUES (1348, 5082, 'Facebook', NULL, NULL, 'https://www.facebook.com/Richards4RotherValley');
INSERT INTO public.member_contacts VALUES (247, 5235, 'Parliamentary office', NULL, 'al.carns.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1349, 5082, 'TikTok', NULL, NULL, 'https://www.tiktok.com/@jakerichardsmp');
INSERT INTO public.member_contacts VALUES (1350, 5082, 'X (formerly Twitter)', NULL, NULL, 'https://www.x.com/jakebenrichards');
INSERT INTO public.member_contacts VALUES (1351, 4508, 'Parliamentary office', '020 7219 3000', 'andersonr@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1352, 4508, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/RuthAnderson');
INSERT INTO public.member_contacts VALUES (1353, 4777, 'Parliamentary office', '020 7219 8409', 'sarah.owen.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1354, 4777, 'Constituency office', NULL, NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1355, 4777, 'Website', NULL, NULL, 'https://sarahowen.org.uk/');
INSERT INTO public.member_contacts VALUES (1356, 4777, 'Bluesky', NULL, NULL, 'https://bsky.app/profile/sarahowen.org.uk');
INSERT INTO public.member_contacts VALUES (1357, 4777, 'Facebook', NULL, NULL, 'https://www.facebook.com/SarahOwen4LutonNorth');
INSERT INTO public.member_contacts VALUES (1358, 5240, 'Parliamentary office', NULL, 'melanie.ward.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1359, 5240, 'Constituency office', NULL, NULL, '287-289 High Street');
INSERT INTO public.member_contacts VALUES (1360, 5240, 'Facebook', NULL, NULL, 'https://www.facebook.com/MelanieWardMP');
INSERT INTO public.member_contacts VALUES (1361, 4632, 'Parliamentary office', '0207 219 4307', 'anna.mcmorrin.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1362, 4632, 'Constituency office', '02920 624 440', NULL, 'Office of Anna McMorrin MP');
INSERT INTO public.member_contacts VALUES (1363, 4632, 'Website', NULL, NULL, 'https://www.annamcmorrin.org/');
INSERT INTO public.member_contacts VALUES (1364, 4632, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/annamcmorrin');
INSERT INTO public.member_contacts VALUES (1365, 5305, 'Parliamentary office', '020 8968 7999', 'georgia.gould.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1366, 5305, 'Instagram', NULL, NULL, 'https://www.instagram.com/georgia__gould/');
INSERT INTO public.member_contacts VALUES (1367, 5305, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/georgia_gould');
INSERT INTO public.member_contacts VALUES (790, 4505, 'Facebook', NULL, NULL, 'https://www.facebook.com/hoveandportslade');
INSERT INTO public.member_contacts VALUES (791, 4505, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/peterkyle');
INSERT INTO public.member_contacts VALUES (792, 4026, 'Parliamentary office', '020 7219 3000', 'liz.kendall.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (793, 4026, 'Government department', NULL, 'correspondence@dsit.gov.uk', 'Department for Science, Innovation and Technology');
INSERT INTO public.member_contacts VALUES (794, 4026, 'Website', NULL, NULL, 'https://www.lizkendall.org');
INSERT INTO public.member_contacts VALUES (795, 4026, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/leicesterliz');
INSERT INTO public.member_contacts VALUES (1368, 5071, 'Parliamentary office', NULL, 'paul.waugh.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1369, 5071, 'Constituency office', '01706 391482', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1370, 5071, 'Website', NULL, NULL, 'https://paulwaugh.co.uk/');
INSERT INTO public.member_contacts VALUES (1371, 5071, 'Bluesky', NULL, NULL, 'https://bsky.app/profile/paulwaughmp.bsky.social');
INSERT INTO public.member_contacts VALUES (1372, 5071, 'Facebook', NULL, NULL, 'https://www.facebook.com/PaulWaughUK/');
INSERT INTO public.member_contacts VALUES (1373, 5033, 'Parliamentary office', NULL, 'josh.macalister.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1374, 5033, 'Constituency office', '01946 458023', 'hello@joshmacalister.uk', 'First Floor');
INSERT INTO public.member_contacts VALUES (1375, 5033, 'Facebook', NULL, NULL, 'https://www.facebook.com/josh4wc');
INSERT INTO public.member_contacts VALUES (1376, 5033, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/joshmacalister');
INSERT INTO public.member_contacts VALUES (1377, 3966, 'Parliamentary office', '020 7219 7064', 'ian.murray.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1378, 3966, 'Constituency office', '0131 662 4520', 'ian.murray.mp@parliament.uk', '31 Minto Street');
INSERT INTO public.member_contacts VALUES (807, 413, 'Parliamentary office', '020 7219 5770', 'bennh@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (808, 413, 'Constituency office', '0113 244 1097', 'boxj@parliament.uk', 'Suite 7');
INSERT INTO public.member_contacts VALUES (809, 413, 'Website', NULL, NULL, 'http://www.hilarybennmp.com/');
INSERT INTO public.member_contacts VALUES (810, 413, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/hilarybennmp');
INSERT INTO public.member_contacts VALUES (1379, 3966, 'Website', NULL, NULL, 'https://www.ianmurraymp.com/');
INSERT INTO public.member_contacts VALUES (1380, 3966, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/IanMurrayMP');
INSERT INTO public.member_contacts VALUES (1381, 5414, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1382, 4607, 'Parliamentary office', '0207 219 4129', 'stephanie.peacock.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (815, 4425, 'Parliamentary office', '020 7219 8290', 'jo.stevens.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (816, 4425, 'Constituency office', '02921 329736', NULL, '116 Albany Road');
INSERT INTO public.member_contacts VALUES (817, 4425, 'Website', NULL, NULL, 'http://www.jostevens.co.uk/');
INSERT INTO public.member_contacts VALUES (818, 4425, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/jostevenslabour');
INSERT INTO public.member_contacts VALUES (1383, 4607, 'Constituency office', '01226 743 483', 'stephanie.peacock.mp@parliament.uk', 'Constituency Office');
INSERT INTO public.member_contacts VALUES (1384, 4607, 'Website', NULL, NULL, 'http://www.stephaniepeacock.org.uk/');
INSERT INTO public.member_contacts VALUES (1385, 4607, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/Steph_Peacock');
INSERT INTO public.member_contacts VALUES (1386, 4491, 'Parliamentary office', '020 7219 5934', 'vicky.foxcroft.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1387, 4491, 'Constituency office', '020 8469 4638', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1388, 4491, 'Website', NULL, NULL, 'http://www.vickyfoxcroft.org.uk/');
INSERT INTO public.member_contacts VALUES (1389, 4491, 'Bluesky', NULL, NULL, 'https://bsky.app/profile/vickyfoxcroftmp.bsky.social');
INSERT INTO public.member_contacts VALUES (1390, 4491, 'Facebook', NULL, NULL, 'https://www.facebook.com/VickyFoxcroftLabour');
INSERT INTO public.member_contacts VALUES (1391, 4491, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/vickyfoxcroft');
INSERT INTO public.member_contacts VALUES (1392, 4870, 'Parliamentary office', '0207 219 6552', 'florence.eshalomi.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1393, 4912, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (830, 5365, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1394, 4569, 'Parliamentary office', '020 7219 3000', 'jim.mcmahon.mp@parliament.uk ', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1395, 4569, 'Constituency office', '0161 652 8485', 'jim.mcmahon.mp@parliament.uk', 'Chadderton Town Hall');
INSERT INTO public.member_contacts VALUES (1396, 4569, 'Website', NULL, NULL, 'https://www.jimmcmahon.co.uk/');
INSERT INTO public.member_contacts VALUES (1397, 4569, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/JimfromOldham');
INSERT INTO public.member_contacts VALUES (1398, 4956, 'Parliamentary office', '020 7219 5353', 'taylors@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1399, 4956, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/SharonStevenage');
INSERT INTO public.member_contacts VALUES (837, 3972, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (838, 3972, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/JennyChapman');
INSERT INTO public.member_contacts VALUES (1400, 5116, 'Parliamentary office', NULL, 'chris.mcdonald.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1401, 4083, 'Parliamentary office', '020 7219 7190', 'alison.mcgovern.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1402, 4083, 'Constituency office', '0151 645 6590', NULL, 'Make Hamilton');
INSERT INTO public.member_contacts VALUES (842, 4479, 'Parliamentary office', '020 7219 4294', 'nick.thomassymonds.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (843, 4479, 'Constituency office', '01495 740498', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (844, 4479, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/nicktorfaen');
INSERT INTO public.member_contacts VALUES (1403, 4083, 'Website', NULL, NULL, 'http://www.alisonmcgovern.org.uk/');
INSERT INTO public.member_contacts VALUES (1404, 4083, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/Alison_McGovern');
INSERT INTO public.member_contacts VALUES (1405, 1533, 'Parliamentary office', '020 7219 5647', 'johnsond@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1406, 1533, 'Constituency office', '01482 319135', 'johnsond@parliament.uk', 'Constituency office');
INSERT INTO public.member_contacts VALUES (1407, 1533, 'Website', NULL, NULL, 'http://www.dianajohnson.co.uk/');
INSERT INTO public.member_contacts VALUES (1408, 1533, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/DianaJohnsonMP');
INSERT INTO public.member_contacts VALUES (1409, 4444, 'Parliamentary office', NULL, 'karin.smyth.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1410, 4444, 'Constituency office', '0117 953 3575', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1411, 4444, 'Website', NULL, NULL, 'http://karinsmyth.com/');
INSERT INTO public.member_contacts VALUES (735, 4514, 'Prime Minister''s office', NULL, NULL, 'https://contact.no10.gov.uk/');
INSERT INTO public.member_contacts VALUES (736, 4514, 'Parliamentary office', NULL, 'keir.starmer.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (737, 4514, 'Constituency office', NULL, 'keir.starmer.constituency@parliament.uk', 'Constituency Office');
INSERT INTO public.member_contacts VALUES (738, 4514, 'Website', NULL, NULL, 'http://www.keirstarmer.com/');
INSERT INTO public.member_contacts VALUES (739, 4514, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/keir_starmer');
INSERT INTO public.member_contacts VALUES (740, 206, 'Parliamentary office', NULL, 'david.lammy.mp@parliament.uk ', 'House of Commons');
INSERT INTO public.member_contacts VALUES (741, 206, 'Website', NULL, NULL, 'http://www.davidlammy.co.uk');
INSERT INTO public.member_contacts VALUES (742, 206, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/DavidLammy');
INSERT INTO public.member_contacts VALUES (743, 4268, 'Parliamentary office', '020 7219 7297', 'steve.reed.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (744, 4268, 'Website', NULL, NULL, 'http://www.stevereedmp.co.uk/');
INSERT INTO public.member_contacts VALUES (745, 4268, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/SteveReedMP');
INSERT INTO public.member_contacts VALUES (746, 4031, 'Chancellor of the Exchequer''s office', NULL, 'public.enquiries@hmtreasury.gov.uk', 'Ministerial office');
INSERT INTO public.member_contacts VALUES (747, 4031, 'Parliamentary office', '020 7219 7097', 'rachel.reeves.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (748, 4031, 'Constituency office', '0113 255 2311', 'leedswestandpudsey@parliament.uk', 'Unit 8A');
INSERT INTO public.member_contacts VALUES (749, 4031, 'Website', NULL, NULL, 'https://www.rachelreevesmp.co.uk/');
INSERT INTO public.member_contacts VALUES (750, 4031, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/RachelReevesMP');
INSERT INTO public.member_contacts VALUES (751, 4621, 'Parliamentary office', '0207 219 5225', 'darren.jones.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (752, 4621, 'Constituency office', '0117 959 6545', NULL, 'Constituency Office');
INSERT INTO public.member_contacts VALUES (753, 4621, 'Website', NULL, NULL, 'http://www.darren-jones.co.uk/');
INSERT INTO public.member_contacts VALUES (754, 4621, 'Facebook', NULL, NULL, 'https://www.facebook.com/darrenjonesmp');
INSERT INTO public.member_contacts VALUES (755, 4621, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/darrenpjones');
INSERT INTO public.member_contacts VALUES (1412, 4444, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/karinsmyth');
INSERT INTO public.member_contacts VALUES (1413, 4637, 'Parliamentary office', NULL, 'james.frith.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1414, 4637, 'Constituency office', '0161 560 5667', 'james.frith.mp@parliament.uk', '18 Bolton Street');
INSERT INTO public.member_contacts VALUES (1415, 4637, 'Facebook', NULL, NULL, 'https://www.facebook.com/JamesFrithBury');
INSERT INTO public.member_contacts VALUES (1416, 4637, 'LinkedIn', NULL, NULL, 'https://www.linkedin.com/in/jamesfrith ');
INSERT INTO public.member_contacts VALUES (1417, 4637, 'TikTok', NULL, NULL, 'https://www.tiktok.com/@james.frith.mp');
INSERT INTO public.member_contacts VALUES (1418, 4637, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/JamesFrith');
INSERT INTO public.member_contacts VALUES (1419, 347, 'Parliamentary office', '020 7219 5353', 'merrong@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1420, 5114, 'Parliamentary office', NULL, 'kirsty.mcneill.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1421, 5114, 'Website', NULL, NULL, 'www.kirstymcneill.com');
INSERT INTO public.member_contacts VALUES (1422, 5114, 'Facebook', NULL, NULL, 'www.facebook.com/KirstyMcNeillLabour');
INSERT INTO public.member_contacts VALUES (1423, 5114, 'Instagram', NULL, NULL, 'https://www.instagram.com/kirstyjmcneill/');
INSERT INTO public.member_contacts VALUES (1424, 5114, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/kirstyjmcneill');
INSERT INTO public.member_contacts VALUES (1425, 5114, 'Youtube', NULL, NULL, 'https://www.youtube.com/@kirstymcneillmidlothian24');
INSERT INTO public.member_contacts VALUES (770, 4797, 'Parliamentary office', '020 7219 3000', 'james.murray.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1426, 4264, 'Parliamentary office', '020 7219 5348', 'stephen.doughty.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1427, 4264, 'Website', NULL, NULL, 'https://www.stephendoughty.wales');
INSERT INTO public.member_contacts VALUES (1428, 4264, 'Facebook', NULL, NULL, 'https://www.facebook.com/StephenDoughtyMP');
INSERT INTO public.member_contacts VALUES (1429, 4264, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/SDoughtyMP');
INSERT INTO public.member_contacts VALUES (1430, 4217, 'Parliamentary office', '020 7219 5854', 'stewart.wood@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1431, 4217, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/StewartWood');
INSERT INTO public.member_contacts VALUES (1432, 4217, 'Youtube', NULL, NULL, 'https://www.youtube.com/@DailySporran');
INSERT INTO public.member_contacts VALUES (1433, 390, 'Parliamentary office', '020 7219 5353', 'wintertonr@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1434, 5278, 'Parliamentary office', '020 7219 7777', 'uma.kumaran.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1435, 5278, 'Website', NULL, NULL, 'https://www.umakumaran.co.uk');
INSERT INTO public.member_contacts VALUES (1436, 5278, 'Instagram', NULL, NULL, 'https://instagram.com/uma.kumaran.mp');
INSERT INTO public.member_contacts VALUES (1437, 5278, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/uma_kumaran');
INSERT INTO public.member_contacts VALUES (1438, 4572, 'Parliamentary office', '0207 219 3000', 'Chris.Elmore.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1439, 4572, 'Constituency office', '01656 860034', 'Chris.Elmore.mp@parliament.uk', 'Caroline Court');
INSERT INTO public.member_contacts VALUES (1440, 4572, 'Website', NULL, NULL, 'https://www.chriselmore.wales/');
INSERT INTO public.member_contacts VALUES (1441, 4572, 'Facebook', NULL, NULL, 'https://facebook.com/ChrisElmoreMP/');
INSERT INTO public.member_contacts VALUES (1442, 4572, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/cpjelmore');
INSERT INTO public.member_contacts VALUES (1443, 5260, 'Parliamentary office', NULL, 'katie.white.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1444, 4998, 'Parliamentary office', NULL, 'michael.shanks.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1445, 4998, 'Constituency office', '0141 319 8998', NULL, 'Aspire Business Centre');
INSERT INTO public.member_contacts VALUES (1446, 4998, 'Instagram', NULL, NULL, 'https://instagram.com/michaelshanksmp');
INSERT INTO public.member_contacts VALUES (1447, 4998, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/mgshanks');
INSERT INTO public.member_contacts VALUES (1448, 3982, 'Parliamentary office', '020 7219 5353', 'curranm@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1449, 5123, 'Parliamentary office', NULL, 'polly.billington.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1450, 5129, 'Parliamentary office', '020 7219 8353', 'martin.mccluskey.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1451, 5129, 'Constituency office', '01475 789223', NULL, 'Custom House');
INSERT INTO public.member_contacts VALUES (1452, 5129, 'Website', NULL, NULL, 'https://www.martinmccluskey.scot');
INSERT INTO public.member_contacts VALUES (1453, 5129, 'Facebook', NULL, NULL, 'https://facebook.com/martinmccluskey');
INSERT INTO public.member_contacts VALUES (1454, 5129, 'Instagram', NULL, NULL, 'https://instagram.com/martinmccluskeymp');
INSERT INTO public.member_contacts VALUES (1455, 5129, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/martinmccluskey');
INSERT INTO public.member_contacts VALUES (1456, 5076, 'Parliamentary office', NULL, 'blair.mcdougall.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1457, 5076, 'Constituency office', '0141 280 2005', NULL, '8 Benview Road');
INSERT INTO public.member_contacts VALUES (1458, 5076, 'Website', NULL, NULL, 'https://www.blairmcdougall.com/');
INSERT INTO public.member_contacts VALUES (1459, 5076, 'Facebook', NULL, NULL, 'https://facebook.com/blairforeastren');
INSERT INTO public.member_contacts VALUES (1460, 5076, 'Instagram', NULL, NULL, 'https://www.instagram.com/blairforeastren');
INSERT INTO public.member_contacts VALUES (1461, 5224, 'Parliamentary office', NULL, 'kate.dearden.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1462, 5224, 'Website', NULL, NULL, 'www.kateforhalifax.com');
INSERT INTO public.member_contacts VALUES (1463, 5224, 'Facebook', NULL, NULL, 'https://www.facebook.com/KateDeardenMP');
INSERT INTO public.member_contacts VALUES (1464, 5224, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/Kate_Dearden');
INSERT INTO public.member_contacts VALUES (1465, 4959, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (771, 4797, 'Website', NULL, NULL, 'https://www.jamesmurray.org/');
INSERT INTO public.member_contacts VALUES (772, 4797, 'Facebook', NULL, NULL, 'https://www.facebook.com/james4ealing');
INSERT INTO public.member_contacts VALUES (773, 4797, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/jamesmurray_ldn');
INSERT INTO public.member_contacts VALUES (787, 4505, 'Parliamentary office', '020 7219 1897', 'peter.kyle.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (788, 4505, 'Constituency office', '01273 933 380', 'hove.portslade@parliament.uk', '99 Church Road');
INSERT INTO public.member_contacts VALUES (789, 4505, 'Website', NULL, NULL, 'http://www.peterkyle.co.uk/');
INSERT INTO public.member_contacts VALUES (861, 5276, 'Parliamentary office', '020 7219 2076', 'chris.ward.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (862, 5276, 'Constituency office', '01273 082531', NULL, 'Constituency Office');
INSERT INTO public.member_contacts VALUES (863, 5276, 'Website', NULL, NULL, 'https://chriswardmp.co.uk/');
INSERT INTO public.member_contacts VALUES (864, 5276, 'Facebook', NULL, NULL, 'https://www.facebook.com/chriswardmp');
INSERT INTO public.member_contacts VALUES (865, 5276, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/chriswardmp');
INSERT INTO public.member_contacts VALUES (885, 1579, 'Parliamentary office', NULL, 'mary.creagh.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (886, 1579, 'Constituency office', '0247 7180 425', NULL, 'Office of Mary Creagh MP CBE');
INSERT INTO public.member_contacts VALUES (887, 1579, 'Website', NULL, NULL, 'https://www.marycreagh.co.uk');
INSERT INTO public.member_contacts VALUES (888, 1579, 'Facebook', NULL, NULL, 'https://facebook.com/marycreaghlabour');
INSERT INTO public.member_contacts VALUES (889, 1579, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/marycreagh_');
INSERT INTO public.member_contacts VALUES (924, 4559, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (925, 5413, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (926, 5257, 'Parliamentary office', '0207 219 6543', 'rachel.blake.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (927, 5257, 'Constituency office', NULL, 'rachel.blake.casework@parliament.uk', 'Constituency office');
INSERT INTO public.member_contacts VALUES (928, 5257, 'Instagram', NULL, NULL, 'https://www.instagram.com/rachel_blake_cities/');
INSERT INTO public.member_contacts VALUES (929, 5257, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/RNBlake');
INSERT INTO public.member_contacts VALUES (935, 5075, 'Parliamentary office', NULL, 'deirdre.costigan.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (936, 5075, 'Constituency office', '0208 243 8611', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (937, 5075, 'Bluesky', NULL, NULL, 'https://bsky.app/profile/deirdrecostiganmp.bsky.social');
INSERT INTO public.member_contacts VALUES (938, 5075, 'Facebook', NULL, NULL, 'https://facebook.com/DeirdreCostiganMP');
INSERT INTO public.member_contacts VALUES (939, 5075, 'Instagram', NULL, NULL, 'https://instagram.com/deirdre.costigan.mp');
INSERT INTO public.member_contacts VALUES (940, 5075, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/deirdrecostigan');
INSERT INTO public.member_contacts VALUES (944, 4779, 'Parliamentary office', NULL, 'taiwo.owatemi.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (945, 4779, 'Constituency office', '024 7767 2089', 'Taiwo.owatemi.mp@parliament.uk', 'Constituency office ');
INSERT INTO public.member_contacts VALUES (946, 4779, 'Website', NULL, NULL, 'https://taiwoowatemi.co.uk/');
INSERT INTO public.member_contacts VALUES (947, 4779, 'Facebook', NULL, NULL, 'https://www.facebook.com/TaiwoOwatemiMP');
INSERT INTO public.member_contacts VALUES (948, 4779, 'Instagram', NULL, NULL, 'https://www.instagram.com/taiwo_owatemi/');
INSERT INTO public.member_contacts VALUES (949, 4779, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/TaiwoOwatemi');
INSERT INTO public.member_contacts VALUES (950, 4779, 'Youtube', NULL, NULL, 'https://www.youtube.com/channel/UCwt3TinSgA023bLJhBtSQkw');
INSERT INTO public.member_contacts VALUES (961, 5053, 'Parliamentary office', '0207 219 5665', 'natalie.fleet.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (962, 5053, 'Website', NULL, NULL, 'https://www.nataliefleetbolsover.com/');
INSERT INTO public.member_contacts VALUES (963, 5266, 'Parliamentary office', NULL, 'mike.tapp.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (985, 5364, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (986, 5143, 'Parliamentary office', NULL, 'catherine.atkinson.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (993, 5381, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (994, 5162, 'Parliamentary office', '0207 219 7907', 'matthew.patrick.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (995, 5162, 'Constituency office', '0151 319 3998', NULL, 'Hilbre House');
INSERT INTO public.member_contacts VALUES (996, 5162, 'Website', NULL, NULL, 'www.matthewpatrick.co.uk');
INSERT INTO public.member_contacts VALUES (997, 5162, 'Facebook', NULL, NULL, 'https://www.facebook.com/people/Matthew-Patrick-for-Wirral-West/61550576948707/');
INSERT INTO public.member_contacts VALUES (998, 5162, 'Instagram', NULL, NULL, 'https://www.instagram.com/matthewpatrickmp/');
INSERT INTO public.member_contacts VALUES (999, 5162, 'X (formerly Twitter)', NULL, NULL, 'https://x.com/Matthew_Patrick');
INSERT INTO public.member_contacts VALUES (1018, 5337, 'Parliamentary office', NULL, 'olivia.bailey.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1019, 5337, 'Constituency office', NULL, 'olivia.bailey.mp@parliament.uk', 'Constituency office');
INSERT INTO public.member_contacts VALUES (1020, 5337, 'Website', NULL, NULL, 'https://www.oliviabailey.co.uk');
INSERT INTO public.member_contacts VALUES (1021, 5337, 'Facebook', NULL, NULL, 'https://facebook.com/oliviabailey4rwmb');
INSERT INTO public.member_contacts VALUES (1022, 5337, 'Instagram', NULL, NULL, 'https://instagram.com/obaileymp');
INSERT INTO public.member_contacts VALUES (1023, 4253, 'Parliamentary office', '020 7219 8957', 'seema.malhotra.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1024, 4253, 'Website', NULL, NULL, 'http://www.seemamalhotra.com/');
INSERT INTO public.member_contacts VALUES (1025, 4253, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/SeemaMalhotra1');
INSERT INTO public.member_contacts VALUES (1037, 5180, 'Parliamentary office', NULL, 'nesil.caliskan.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1038, 5180, 'Constituency office', NULL, 'nesil.caliskan.casework@parliament.uk', 'Constituency Office');
INSERT INTO public.member_contacts VALUES (1039, 4976, 'Parliamentary office', '020 7219 3000', 'Samantha.dixon.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1040, 4976, 'Constituency office', '01244 343 229', NULL, 'Constituency Office');
INSERT INTO public.member_contacts VALUES (1041, 4976, 'Website', NULL, NULL, 'https://samantha-dixon.co.uk/');
INSERT INTO public.member_contacts VALUES (1042, 4976, 'Facebook', NULL, NULL, 'https://www.facebook.com/samdixonchester/');
INSERT INTO public.member_contacts VALUES (1043, 4976, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/samanthadixonmp');
INSERT INTO public.member_contacts VALUES (1054, 4603, 'Parliamentary office', '0207 219 2879', 'preet.gill.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1055, 4603, 'Constituency office', '0121 392 8426', NULL, 'Constituency office');
INSERT INTO public.member_contacts VALUES (1056, 4603, 'Website', NULL, NULL, 'https://www.preetkaurgill.co.uk/');
INSERT INTO public.member_contacts VALUES (1057, 4603, 'Facebook', NULL, NULL, 'https://www.facebook.com/PreetKaurGillMP/');
INSERT INTO public.member_contacts VALUES (1058, 4603, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/PreetKGillMP');
INSERT INTO public.member_contacts VALUES (1059, 1521, 'Parliamentary office', '020 7219 5160', 'sharon.hodgson.mp@parliament.uk', 'House of Commons');
INSERT INTO public.member_contacts VALUES (1060, 1521, 'Constituency office', '0191 417 2000', 'sharon.hodgson.mp@parliament.uk', 'Constituency office');
INSERT INTO public.member_contacts VALUES (1061, 1521, 'Website', NULL, NULL, 'http://www.sharonhodgson.org/');
INSERT INTO public.member_contacts VALUES (1062, 1521, 'X (formerly Twitter)', NULL, NULL, 'https://twitter.com/SharonHodgsonMP');
INSERT INTO public.member_contacts VALUES (1075, 62, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');
INSERT INTO public.member_contacts VALUES (1080, 5363, 'Parliamentary office', '020 7219 5353', 'contactholmember@parliament.uk', 'House of Lords');


--
-- TOC entry 3865 (class 0 OID 16867)
-- Dependencies: 222
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.members VALUES (4797, 'James Murray', 'Rt Hon James Murray MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (4505, 'Peter Kyle', 'Rt Hon Peter Kyle MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4026, 'Liz Kendall', 'Rt Hon Liz Kendall MP', 'Labour', 'F');
INSERT INTO public.members VALUES (413, 'Hilary Benn', 'Rt Hon Hilary Benn MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4425, 'Jo Stevens', 'Rt Hon Jo Stevens MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5365, 'Lord Hermer', 'The Rt Hon. the Lord Hermer KC', 'Labour', 'M');
INSERT INTO public.members VALUES (3972, 'Baroness Chapman of Darlington', 'The Rt Hon. the Baroness Chapman of Darlington', 'Labour', 'F');
INSERT INTO public.members VALUES (4479, 'Nick Thomas-Symonds', 'Rt Hon Nick Thomas-Symonds MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5276, 'Chris Ward', 'Chris Ward MP', 'Labour', 'M');
INSERT INTO public.members VALUES (1579, 'Mary Creagh', 'Mary Creagh MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4559, 'Lord Livermore', 'The Lord Livermore', 'Labour', 'M');
INSERT INTO public.members VALUES (5413, 'Lord Stockwood', 'The Lord Stockwood', 'Labour', 'M');
INSERT INTO public.members VALUES (5257, 'Rachel Blake', 'Rachel Blake MP', 'Labour (Co-op)', 'F');
INSERT INTO public.members VALUES (5075, 'Deirdre Costigan', 'Deirdre Costigan MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4779, 'Taiwo Owatemi', 'Taiwo Owatemi MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5053, 'Natalie Fleet', 'Natalie Fleet MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5266, 'Mike Tapp', 'Mike Tapp MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5364, 'Lord Timpson', 'The Lord Timpson OBE DL', 'Labour', 'M');
INSERT INTO public.members VALUES (5143, 'Catherine Atkinson', 'Catherine Atkinson MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5381, 'Baroness Levitt', 'The Baroness Levitt KC', 'Labour', 'F');
INSERT INTO public.members VALUES (5235, 'Al Carns', 'Al Carns MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5162, 'Matthew Patrick', 'Matthew Patrick MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5337, 'Olivia Bailey', 'Olivia Bailey MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4253, 'Seema Malhotra', 'Seema Malhotra MP', 'Labour (Co-op)', 'F');
INSERT INTO public.members VALUES (5180, 'Nesil Caliskan', 'Nesil Caliskan MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4976, 'Samantha Dixon', 'Samantha Dixon MP', 'Labour', 'F');
INSERT INTO public.members VALUES (1427, 'Andy Burnham', 'Rt Hon Andy Burnham', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (400, 'John Healey', 'Rt Hon John Healey MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4473, 'Louise Haigh', 'Rt Hon Louise Haigh MP', 'Labour', 'F');
INSERT INTO public.members VALUES (1510, 'Ed Miliband', 'Rt Hon Ed Miliband MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4504, 'Wes Streeting', 'Rt Hon Wes Streeting MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4641, 'Alex Norris', 'Alex Norris MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (4263, 'Lucy Powell', 'Rt Hon Lucy Powell MP', 'Labour (Co-op)', 'F');
INSERT INTO public.members VALUES (4046, 'Bridget Phillipson', 'Rt Hon Bridget Phillipson MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4356, 'Angela Rayner', 'Rt Hon Angela Rayner MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5099, 'Miatta Fahnbulleh', 'Miatta Fahnbulleh MP', 'Labour (Co-op)', 'F');
INSERT INTO public.members VALUES (1587, 'Pat McFadden', 'Rt Hon Pat McFadden MP', 'Labour', 'M');
INSERT INTO public.members VALUES (3914, 'Shabana Mahmood', 'Rt Hon Shabana Mahmood KC MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4514, 'Sir Keir Starmer', 'Rt Hon Sir Keir Starmer MP', 'Labour', 'M');
INSERT INTO public.members VALUES (206, 'Mr David Lammy', 'Rt Hon David Lammy MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4268, 'Steve Reed', 'Rt Hon Steve Reed MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (4031, 'Rachel Reeves', 'Rt Hon Rachel Reeves MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4621, 'Darren Jones', 'Rt Hon Darren Jones MP', 'Labour', 'M');
INSERT INTO public.members VALUES (420, 'Yvette Cooper', 'Rt Hon Yvette Cooper MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4119, 'Jonathan Reynolds', 'Rt Hon Jonathan Reynolds MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (491, 'Dame Angela Eagle', 'Dame Angela Eagle MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4038, 'Heidi Alexander', 'Rt Hon Heidi Alexander MP', 'Labour', 'F');
INSERT INTO public.members VALUES (632, 'Mr Douglas Alexander', 'Rt Hon Douglas Alexander MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (4359, 'Stephen Kinnock', 'Stephen Kinnock MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4082, 'Lisa Nandy', 'Rt Hon Lisa Nandy MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4170, 'Baroness Smith of Basildon', 'The Rt Hon. the Baroness Smith of Basildon', 'Labour', 'F');
INSERT INTO public.members VALUES (529, 'Sir Alan Campbell', 'Rt Hon Sir Alan Campbell MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5038, 'Anneliese Midgley', 'Anneliese Midgley MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4077, 'Emma Reynolds', 'Rt Hon Emma Reynolds MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4620, 'Ellie Reeves', 'Rt Hon Ellie Reeves KC MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4520, 'Matthew Pennycook', 'Matthew Pennycook MP', 'Labour', 'M');
INSERT INTO public.members VALUES (1516, 'Andy Slaughter', 'Andy Slaughter MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4243, 'Dan Jarvis', 'Rt Hon Dan Jarvis MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5031, 'Mark Ferguson', 'Mark Ferguson MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4966, 'Baroness Twycross', 'The Baroness Twycross', 'Labour', 'F');
INSERT INTO public.members VALUES (5282, 'Dan Tomlinson', 'Dan Tomlinson MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5178, 'Sally Jameson', 'Sally Jameson MP', 'Labour (Co-op)', 'F');
INSERT INTO public.members VALUES (4645, 'Emma Hardy', 'Emma Hardy MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4653, 'Stephen Morgan', 'Stephen Morgan MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5160, 'Jenny Riddell-Carpenter', 'Jenny Riddell-Carpenter MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4395, 'Baroness Hayman of Ullock', 'The Baroness Hayman of Ullock', 'Labour', 'F');
INSERT INTO public.members VALUES (4972, 'Lord Hendy of Richmond Hill', 'The Lord Hendy of Richmond Hill CBE', 'Labour', 'M');
INSERT INTO public.members VALUES (4418, 'Justin Madders', 'Justin Madders MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4993, 'Keir Mather', 'Keir Mather MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4943, 'Simon Lightwood', 'Simon Lightwood MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (4979, 'Andrew Western', 'Andrew Western MP', 'Labour', 'M');
INSERT INTO public.members VALUES (269, 'Baroness Smith of Malvern', 'The Rt Hon. the Baroness Smith of Malvern', 'Labour', 'F');
INSERT INTO public.members VALUES (163, 'Sir Stephen Timms', 'Rt Hon Sir Stephen Timms MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4147, 'Baroness Sherlock', 'The Baroness Sherlock OBE', 'Labour', 'F');
INSERT INTO public.members VALUES (4029, 'Lilian Greenwood', 'Lilian Greenwood MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5069, 'Torsten Bell', 'Torsten Bell MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5333, 'Lucy Rigby', 'Rt Hon Lucy Rigby KC MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5430, 'Lord Pitt-Watson', 'The Lord Pitt-Watson', 'Labour', 'M');
INSERT INTO public.members VALUES (5041, 'Shaun Davies', 'Shaun Davies MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5113, 'Claire Hughes', 'Claire Hughes MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5167, 'Gregor Poynton', 'Gregor Poynton MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5236, 'Jade Botterill', 'Jade Botterill MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4871, 'Christian Wakeford', 'Christian Wakeford MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4449, 'Anna Turley', 'Rt Hon Anna Turley MP', 'Labour (Co-op)', 'F');
INSERT INTO public.members VALUES (4631, 'Sarah Jones', 'Sarah Jones MP', 'Labour', 'F');
INSERT INTO public.members VALUES (533, 'Lord Hanson of Flint', 'The Rt Hon. the Lord Hanson of Flint', 'Labour', 'M');
INSERT INTO public.members VALUES (5105, 'Jo White', 'Jo White MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4222, 'Lord Collins of Highbury', 'The Lord Collins of Highbury', 'Labour', 'M');
INSERT INTO public.members VALUES (5271, 'Satvir Kaur', 'Satvir Kaur MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4682, 'Luke Pollard', 'Luke Pollard MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (360, 'Lord Coaker', 'The Lord Coaker', 'Labour', 'M');
INSERT INTO public.members VALUES (5258, 'Louise Sandher-Jones', 'Louise Sandher-Jones MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5054, 'Mr Calvin Bailey', 'Mr Calvin Bailey MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4125, 'Catherine McKinnell', 'Catherine McKinnell MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5204, 'Sarah Sackman', 'Sarah Sackman MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5382, 'Lord Lemos', 'The Lord Lemos CMG CBE', 'Labour', 'M');
INSERT INTO public.members VALUES (4849, 'Alex Davies-Jones', 'Alex Davies-Jones MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5082, 'Jake Richards', 'Jake Richards MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4508, 'Baroness Anderson of Stoke-on-Trent', 'The Baroness Anderson of Stoke-on-Trent', 'Labour', 'F');
INSERT INTO public.members VALUES (4777, 'Sarah Owen', 'Sarah Owen MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5240, 'Melanie Ward', 'Melanie Ward MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4632, 'Anna McMorrin', 'Anna McMorrin MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5305, 'Georgia Gould', 'Georgia Gould MP', 'Labour', 'F');
INSERT INTO public.members VALUES (5071, 'Paul Waugh', 'Paul Waugh MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (5033, 'Josh MacAlister', 'Josh MacAlister MP', 'Labour', 'M');
INSERT INTO public.members VALUES (3966, 'Ian Murray', 'Rt Hon Ian Murray MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4607, 'Stephanie Peacock', 'Stephanie Peacock MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4491, 'Vicky Foxcroft', 'Vicky Foxcroft MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4870, 'Florence Eshalomi', 'Florence Eshalomi MP', 'Labour (Co-op)', 'F');
INSERT INTO public.members VALUES (4912, 'Baroness Blake of Leeds', 'The Baroness Blake of Leeds CBE', 'Labour', 'F');
INSERT INTO public.members VALUES (4569, 'Jim McMahon', 'Jim McMahon MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (4956, 'Baroness Taylor of Stevenage', 'The Baroness Taylor of Stevenage OBE', 'Labour', 'F');
INSERT INTO public.members VALUES (5116, 'Chris McDonald', 'Chris McDonald MP', 'Labour', 'M');
INSERT INTO public.members VALUES (4083, 'Alison McGovern', 'Alison McGovern MP', 'Labour', 'F');
INSERT INTO public.members VALUES (1533, 'Dame Diana Johnson', 'Rt Hon Dame Diana Johnson MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4444, 'Karin Smyth', 'Karin Smyth MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4637, 'Mr James Frith', 'Mr James Frith MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5114, 'Kirsty McNeill', 'Kirsty McNeill MP', 'Labour (Co-op)', 'F');
INSERT INTO public.members VALUES (4217, 'Lord Wood of Anfield', 'The Lord Wood of Anfield', 'Labour', 'M');
INSERT INTO public.members VALUES (390, 'Baroness Winterton of Doncaster', 'The Rt Hon. the Baroness Winterton of Doncaster DBE', 'Labour', 'F');
INSERT INTO public.members VALUES (5278, 'Uma Kumaran', 'Uma Kumaran MP', 'Labour', 'F');
INSERT INTO public.members VALUES (3982, 'Baroness Curran', 'The Baroness Curran', 'Labour', 'F');
INSERT INTO public.members VALUES (5123, 'Ms Polly Billington', 'Ms Polly Billington MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4959, 'Lord Leong', 'The Lord Leong CBE', 'Labour', 'M');
INSERT INTO public.members VALUES (4603, 'Preet Kaur Gill', 'Preet Kaur Gill MP', 'Labour (Co-op)', 'F');
INSERT INTO public.members VALUES (1521, 'Mrs Sharon Hodgson', 'Mrs Sharon Hodgson MP', 'Labour', 'F');
INSERT INTO public.members VALUES (62, 'Lord Whitehead', 'The Lord Whitehead CBE', 'Labour', 'M');
INSERT INTO public.members VALUES (5363, 'Lord Vallance of Balham', 'The Lord Vallance of Balham KCB', 'Labour', 'M');
INSERT INTO public.members VALUES (1446, 'Chris Bryant', 'Chris Bryant MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5039, 'Kanishka Narayan', 'Kanishka Narayan MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5148, 'Mr Hamish Falconer', 'Mr Hamish Falconer MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5414, 'Baroness Lloyd of Effra', 'The Baroness Lloyd of Effra CBE', 'Labour', 'F');
INSERT INTO public.members VALUES (347, 'Baroness Merron', 'The Baroness Merron', 'Labour', 'F');
INSERT INTO public.members VALUES (4264, 'Stephen Doughty', 'Stephen Doughty MP', 'Labour (Co-op)', 'M');
INSERT INTO public.members VALUES (4572, 'Chris Elmore', 'Chris Elmore MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5260, 'Katie White', 'Katie White MP', 'Labour', 'F');
INSERT INTO public.members VALUES (4998, 'Michael Shanks', 'Michael Shanks MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5129, 'Martin McCluskey', 'Martin McCluskey MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5076, 'Blair McDougall', 'Blair McDougall MP', 'Labour', 'M');
INSERT INTO public.members VALUES (5224, 'Kate Dearden', 'Kate Dearden MP', 'Labour (Co-op)', 'F');


--
-- TOC entry 3864 (class 0 OID 16850)
-- Dependencies: 221
-- Data for Name: post_departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post_departments VALUES (22, 3);
INSERT INTO public.post_departments VALUES (34, 50);
INSERT INTO public.post_departments VALUES (36, 50);
INSERT INTO public.post_departments VALUES (54, 52);
INSERT INTO public.post_departments VALUES (74, 51);
INSERT INTO public.post_departments VALUES (211, 24);
INSERT INTO public.post_departments VALUES (222, 64);
INSERT INTO public.post_departments VALUES (292, 24);
INSERT INTO public.post_departments VALUES (346, 50);
INSERT INTO public.post_departments VALUES (366, 51);
INSERT INTO public.post_departments VALUES (417, 51);
INSERT INTO public.post_departments VALUES (506, 3);
INSERT INTO public.post_departments VALUES (523, 50);
INSERT INTO public.post_departments VALUES (537, 90);
INSERT INTO public.post_departments VALUES (540, 67);
INSERT INTO public.post_departments VALUES (543, 95);
INSERT INTO public.post_departments VALUES (599, 24);
INSERT INTO public.post_departments VALUES (691, 64);
INSERT INTO public.post_departments VALUES (704, 18);
INSERT INTO public.post_departments VALUES (718, 67);
INSERT INTO public.post_departments VALUES (721, 80);
INSERT INTO public.post_departments VALUES (726, 90);
INSERT INTO public.post_departments VALUES (739, 23);
INSERT INTO public.post_departments VALUES (743, 95);
INSERT INTO public.post_departments VALUES (744, 24);
INSERT INTO public.post_departments VALUES (829, 99);
INSERT INTO public.post_departments VALUES (836, 67);
INSERT INTO public.post_departments VALUES (850, 18);
INSERT INTO public.post_departments VALUES (856, 5);
INSERT INTO public.post_departments VALUES (936, 18);
INSERT INTO public.post_departments VALUES (947, 99);
INSERT INTO public.post_departments VALUES (949, 99);
INSERT INTO public.post_departments VALUES (1067, 80);
INSERT INTO public.post_departments VALUES (1120, 23);
INSERT INTO public.post_departments VALUES (1126, 23);
INSERT INTO public.post_departments VALUES (1133, 80);
INSERT INTO public.post_departments VALUES (1137, 52);
INSERT INTO public.post_departments VALUES (1142, 55);
INSERT INTO public.post_departments VALUES (1202, 116);
INSERT INTO public.post_departments VALUES (1204, 116);
INSERT INTO public.post_departments VALUES (1209, 117);
INSERT INTO public.post_departments VALUES (1210, 118);
INSERT INTO public.post_departments VALUES (1211, 118);
INSERT INTO public.post_departments VALUES (1212, 118);
INSERT INTO public.post_departments VALUES (1213, 117);
INSERT INTO public.post_departments VALUES (1214, 117);
INSERT INTO public.post_departments VALUES (1225, 116);
INSERT INTO public.post_departments VALUES (1230, 50);
INSERT INTO public.post_departments VALUES (1238, 1002);
INSERT INTO public.post_departments VALUES (1239, 1002);
INSERT INTO public.post_departments VALUES (1245, 1002);
INSERT INTO public.post_departments VALUES (1267, 5);
INSERT INTO public.post_departments VALUES (1267, 87);
INSERT INTO public.post_departments VALUES (1272, 50);
INSERT INTO public.post_departments VALUES (1274, 1004);
INSERT INTO public.post_departments VALUES (1276, 1004);
INSERT INTO public.post_departments VALUES (1279, 1004);
INSERT INTO public.post_departments VALUES (1299, 99);
INSERT INTO public.post_departments VALUES (1309, 64);
INSERT INTO public.post_departments VALUES (1310, 5);
INSERT INTO public.post_departments VALUES (1310, 51);
INSERT INTO public.post_departments VALUES (1312, 64);
INSERT INTO public.post_departments VALUES (1313, 5);
INSERT INTO public.post_departments VALUES (1314, 1007);
INSERT INTO public.post_departments VALUES (1315, 5);
INSERT INTO public.post_departments VALUES (1315, 1007);
INSERT INTO public.post_departments VALUES (1316, 5);
INSERT INTO public.post_departments VALUES (1316, 1002);
INSERT INTO public.post_departments VALUES (1317, 1007);
INSERT INTO public.post_departments VALUES (1318, 117);
INSERT INTO public.post_departments VALUES (1319, 1007);
INSERT INTO public.post_departments VALUES (1320, 5);
INSERT INTO public.post_departments VALUES (1320, 50);
INSERT INTO public.post_departments VALUES (1322, 117);
INSERT INTO public.post_departments VALUES (1323, 117);
INSERT INTO public.post_departments VALUES (1324, 1004);
INSERT INTO public.post_departments VALUES (1324, 1007);
INSERT INTO public.post_departments VALUES (1325, 5);
INSERT INTO public.post_departments VALUES (1325, 117);


--
-- TOC entry 3867 (class 0 OID 16876)
-- Dependencies: 224
-- Data for Name: post_holders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post_holders VALUES (250, 1267, 1427, '2026-07-20', NULL, 'The Prime Minister');
INSERT INTO public.post_holders VALUES (251, 34, 400, '2026-07-20', NULL, 'The Chancellor of the Exchequer');
INSERT INTO public.post_holders VALUES (252, 1313, 4473, '2026-07-20', NULL, 'Secretary Louise Haigh');
INSERT INTO public.post_holders VALUES (253, 1245, 1510, '2026-07-20', NULL, 'Secretary Ed Miliband');
INSERT INTO public.post_holders VALUES (255, 691, 4504, '2026-07-20', NULL, 'Secretary Wes Streeting');
INSERT INTO public.post_holders VALUES (256, 718, 4641, '2026-07-20', NULL, 'Secretary Alex Norris');
INSERT INTO public.post_holders VALUES (257, 1210, 420, '2026-07-20', NULL, 'Secretary Yvette Cooper');
INSERT INTO public.post_holders VALUES (258, 829, 4263, '2026-07-20', NULL, 'Secretary Lucy Powell');
INSERT INTO public.post_holders VALUES (260, 1213, 4356, '2026-07-20', NULL, 'Secretary Angela Rayner');
INSERT INTO public.post_holders VALUES (261, 1274, 5099, '2026-07-20', NULL, 'Secretary Miatta Fahnbulleh');
INSERT INTO public.post_holders VALUES (263, 1314, 4119, '2026-07-20', NULL, 'Secretary Jonathan Reynolds');
INSERT INTO public.post_holders VALUES (264, 704, 491, '2026-07-20', NULL, 'Secretary Angela Eagle');
INSERT INTO public.post_holders VALUES (21, 739, 4038, '2024-11-29', NULL, 'Secretary Heidi Alexander');
INSERT INTO public.post_holders VALUES (266, 721, 1446, '2026-07-20', NULL, 'Secretary Chris Bryant');
INSERT INTO public.post_holders VALUES (23, 726, 632, '2025-09-05', NULL, 'Secretary Douglas Alexander');
INSERT INTO public.post_holders VALUES (268, 743, 4359, '2026-07-20', NULL, 'Secretary Stephen Kinnock');
INSERT INTO public.post_holders VALUES (269, 1202, 4082, '2026-07-20', NULL, 'Secretary Lisa Nandy');
INSERT INTO public.post_holders VALUES (25, 1137, 4170, '2024-07-05', NULL, 'The Lord Privy Seal');
INSERT INTO public.post_holders VALUES (26, 1142, 529, '2025-09-05', NULL, 'Sir Alan Campbell');
INSERT INTO public.post_holders VALUES (272, 523, 5038, '2026-07-20', NULL, NULL);
INSERT INTO public.post_holders VALUES (273, 36, 4077, '2026-07-20', NULL, 'Emma Reynolds');
INSERT INTO public.post_holders VALUES (274, 22, 4620, '2026-07-20', NULL, 'The Attorney General');
INSERT INTO public.post_holders VALUES (275, 1315, 5039, '2026-07-20', NULL, 'Kanishka Narayan');
INSERT INTO public.post_holders VALUES (276, 1316, 5148, '2026-07-20', NULL, 'Hamish Falconer');
INSERT INTO public.post_holders VALUES (277, 1318, 4520, '2026-07-20', NULL, 'Matthew Pennycook');
INSERT INTO public.post_holders VALUES (278, 506, 1516, '2026-07-21', NULL, 'The Solicitor General');
INSERT INTO public.post_holders VALUES (279, 1310, 4243, '2026-07-21', NULL, 'Dan Jarvis');
INSERT INTO public.post_holders VALUES (280, 856, 5031, '2026-07-22', NULL, 'Mark Ferguson');
INSERT INTO public.post_holders VALUES (281, 856, 4966, '2026-07-22', NULL, 'Baroness Twycross');
INSERT INTO public.post_holders VALUES (282, 1320, 5282, '2026-07-22', NULL, 'Dan Tomlinson');
INSERT INTO public.post_holders VALUES (283, 1325, 5178, '2026-07-22', NULL, 'Sally Jameson');
INSERT INTO public.post_holders VALUES (284, 936, 4645, '2026-07-21', NULL, 'Emma Hard');
INSERT INTO public.post_holders VALUES (285, 850, 4653, '2026-07-22', NULL, 'Stephen Morgan');
INSERT INTO public.post_holders VALUES (286, 850, 5160, '2026-07-22', NULL, 'Jenny Riddell-Carpenter');
INSERT INTO public.post_holders VALUES (44, 850, 4395, '2024-07-09', NULL, 'Baroness Hayman of Ullock ');
INSERT INTO public.post_holders VALUES (47, 1126, 4972, '2024-07-08', NULL, 'Lord Hendy of Richmond Hill');
INSERT INTO public.post_holders VALUES (289, 1120, 4418, '2026-07-22', NULL, 'Justin Madders');
INSERT INTO public.post_holders VALUES (50, 1120, 4943, '2024-07-09', NULL, 'Simon Lightwood');
INSERT INTO public.post_holders VALUES (292, 211, 4979, '2026-07-21', NULL, 'Andrew Western');
INSERT INTO public.post_holders VALUES (52, 211, 269, '2025-09-06', NULL, 'Baroness Smith of Malvern');
INSERT INTO public.post_holders VALUES (53, 211, 163, '2024-07-08', NULL, 'Sir Stephen Timms');
INSERT INTO public.post_holders VALUES (54, 292, 4147, '2024-12-17', NULL, 'Baroness Sherlock');
INSERT INTO public.post_holders VALUES (296, 599, 4029, '2026-07-22', NULL, 'Lilian Greenwood');
INSERT INTO public.post_holders VALUES (55, 599, 5069, '2025-01-14', NULL, 'Torsten Bell');
INSERT INTO public.post_holders VALUES (298, 346, 5333, '2026-07-21', NULL, 'Lucy Rigby');
INSERT INTO public.post_holders VALUES (299, 1272, 5430, '2026-07-22', NULL, 'Lord Pitt-Watson');
INSERT INTO public.post_holders VALUES (61, 1272, 5069, '2025-01-14', NULL, 'Torsten Bell');
INSERT INTO public.post_holders VALUES (301, 1230, 5041, '2026-07-22', NULL, 'Shaun Davies');
INSERT INTO public.post_holders VALUES (302, 1230, 5113, '2026-07-22', NULL, 'Claire Hughes');
INSERT INTO public.post_holders VALUES (303, 1230, 5167, '2026-07-22', NULL, 'Gregor Poynton');
INSERT INTO public.post_holders VALUES (62, 1230, 5236, '2026-06-12', NULL, 'Jade Botterill');
INSERT INTO public.post_holders VALUES (65, 1230, 4871, '2025-09-07', NULL, 'Christian Wakeford');
INSERT INTO public.post_holders VALUES (306, 417, 4449, '2026-07-21', NULL, 'Anna Turley');
INSERT INTO public.post_holders VALUES (67, 417, 4631, '2025-09-06', NULL, 'Sarah Jones');
INSERT INTO public.post_holders VALUES (69, 417, 533, '2024-07-09', NULL, 'Lord Hanson of Flint');
INSERT INTO public.post_holders VALUES (309, 366, 5105, '2026-07-22', NULL, 'Jo White');
INSERT INTO public.post_holders VALUES (310, 366, 4222, '2026-07-22', NULL, 'Lord Collins of Highbury');
INSERT INTO public.post_holders VALUES (311, 366, 5271, '2026-07-22', NULL, 'Satvir Kaur');
INSERT INTO public.post_holders VALUES (72, 54, 4222, '2024-07-09', NULL, NULL);
INSERT INTO public.post_holders VALUES (73, 222, 4682, '2025-09-06', NULL, 'Luke Pollard');
INSERT INTO public.post_holders VALUES (74, 222, 360, '2024-07-08', NULL, 'Lord Coaker');
INSERT INTO public.post_holders VALUES (75, 1309, 5258, '2026-06-12', NULL, 'Louise Sandher-Jones');
INSERT INTO public.post_holders VALUES (76, 1312, 5054, '2026-06-12', NULL, 'Calvin Bailey');
INSERT INTO public.post_holders VALUES (317, 836, 4125, '2026-07-21', NULL, 'Catherine McKinnell');
INSERT INTO public.post_holders VALUES (77, 836, 5204, '2024-12-02', NULL, 'Sarah Sackman');
INSERT INTO public.post_holders VALUES (319, 540, 5382, '2026-07-22', NULL, 'Lord Lemos');
INSERT INTO public.post_holders VALUES (320, 540, 4849, '2026-07-22', NULL, 'Alex Davies-Jones');
INSERT INTO public.post_holders VALUES (80, 540, 5082, '2025-09-07', NULL, 'Jake Richards');
INSERT INTO public.post_holders VALUES (322, 1133, 4508, '2026-07-22', NULL, 'Baroness Anderson of Stoke-on-Trent');
INSERT INTO public.post_holders VALUES (323, 1133, 4777, '2026-07-22', NULL, 'Sarah Owen');
INSERT INTO public.post_holders VALUES (83, 1067, 4508, '2024-07-11', NULL, NULL);
INSERT INTO public.post_holders VALUES (325, 537, 5240, '2026-07-22', NULL, 'Melanie Ward');
INSERT INTO public.post_holders VALUES (85, 543, 5113, '2025-09-16', NULL, 'Claire Hughes');
INSERT INTO public.post_holders VALUES (86, 543, 4632, '2025-09-07', NULL, 'Anna McMorrin');
INSERT INTO public.post_holders VALUES (87, 947, 5305, '2025-09-06', NULL, 'Georgia Gould');
INSERT INTO public.post_holders VALUES (88, 947, 269, '2024-07-06', NULL, 'Baroness Smith of Malvern');
INSERT INTO public.post_holders VALUES (330, 949, 5071, '2026-07-22', NULL, 'Paul Waugh');
INSERT INTO public.post_holders VALUES (90, 949, 5033, '2025-09-07', NULL, 'Josh MacAlister');
INSERT INTO public.post_holders VALUES (332, 1225, 3966, '2026-07-21', NULL, 'Ian Murray');
INSERT INTO public.post_holders VALUES (333, 1204, 5414, '2026-07-23', NULL, 'Baroness Lloyd of Effra');
INSERT INTO public.post_holders VALUES (334, 1204, 4607, '2026-07-22', NULL, 'Stephanie Peacock');
INSERT INTO public.post_holders VALUES (335, 1204, 4491, '2026-07-22', NULL, 'Vicky Foxcroft');
INSERT INTO public.post_holders VALUES (336, 1204, 4966, '2026-07-21', NULL, 'Baroness Twycross');
INSERT INTO public.post_holders VALUES (337, 1214, 4870, '2026-07-21', NULL, 'Florence Eshalomi');
INSERT INTO public.post_holders VALUES (338, 1323, 163, '2026-07-22', NULL, 'Sir Stephen Timms');
INSERT INTO public.post_holders VALUES (339, 1209, 4912, '2026-07-22', NULL, 'Baroness Blake of Leeds');
INSERT INTO public.post_holders VALUES (340, 1209, 4569, '2026-07-22', NULL, 'Jim McMahon');
INSERT INTO public.post_holders VALUES (97, 1209, 4956, '2024-07-09', NULL, 'Baroness Taylor of Stevenage');
INSERT INTO public.post_holders VALUES (342, 1322, 4222, '2026-07-22', NULL, 'Lord Collins of Highbury');
INSERT INTO public.post_holders VALUES (343, 1322, 5271, '2026-07-22', NULL, 'Satvir Kaur');
INSERT INTO public.post_holders VALUES (344, 1322, 4943, '2026-07-22', NULL, 'Simon Lightwood');
INSERT INTO public.post_holders VALUES (345, 1211, 5116, '2026-07-23', NULL, 'Chris McDonald ');
INSERT INTO public.post_holders VALUES (346, 1211, 4083, '2026-07-22', NULL, 'Alison McGovern ');
INSERT INTO public.post_holders VALUES (347, 1211, 1533, '2026-07-21', NULL, 'Dame Diana Johnson');
INSERT INTO public.post_holders VALUES (99, 1211, 4444, '2024-07-08', NULL, 'Karin Smyth');
INSERT INTO public.post_holders VALUES (349, 1212, 4637, '2026-07-22', NULL, 'James Frith');
INSERT INTO public.post_holders VALUES (102, 1212, 347, '2024-07-09', NULL, 'Baroness Merron');
INSERT INTO public.post_holders VALUES (351, 1238, 5114, '2026-07-21', NULL, 'Kirsty McNeill');
INSERT INTO public.post_holders VALUES (103, 1238, 4264, '2024-07-08', NULL, 'Stephen Doughty');
INSERT INTO public.post_holders VALUES (353, 1239, 4217, '2026-07-23', NULL, 'Lord Wood of Anfield');
INSERT INTO public.post_holders VALUES (354, 1239, 390, '2026-07-23', NULL, 'Baroness Winterton of Doncaster');
INSERT INTO public.post_holders VALUES (355, 1239, 5278, '2026-07-22', NULL, 'Uma Kumaran');
INSERT INTO public.post_holders VALUES (104, 1239, 4572, '2025-09-07', NULL, 'Chris Elmore');
INSERT INTO public.post_holders VALUES (357, 1276, 5260, '2026-07-21', NULL, 'Katie White');
INSERT INTO public.post_holders VALUES (109, 1276, 4998, '2025-09-06', NULL, 'Michael Shanks');
INSERT INTO public.post_holders VALUES (359, 1279, 3982, '2026-07-22', NULL, 'Baroness Curran');
INSERT INTO public.post_holders VALUES (360, 1279, 5123, '2026-07-22', NULL, 'Polly Billington');
INSERT INTO public.post_holders VALUES (112, 1279, 5129, '2025-09-07', NULL, 'Martin McCluskey');
INSERT INTO public.post_holders VALUES (362, 1324, 5076, '2026-07-22', NULL, 'Blair McDougall');
INSERT INTO public.post_holders VALUES (363, 1317, 5224, '2026-07-21', NULL, 'Kate Dearden');
INSERT INTO public.post_holders VALUES (364, 1317, 5116, '2026-07-21', NULL, 'Chris McDonald');
INSERT INTO public.post_holders VALUES (365, 1319, 5414, '2026-07-22', NULL, 'Baroness Lloyd of Effra');
INSERT INTO public.post_holders VALUES (366, 1319, 4959, '2026-07-21', NULL, 'Lord Leong');
INSERT INTO public.post_holders VALUES (1, 1267, 4514, '2024-07-05', '2026-07-27', 'The Prime Minister');
INSERT INTO public.post_holders VALUES (2, 1244, 206, '2025-09-05', '2026-07-27', 'Secretary David Lammy');
INSERT INTO public.post_holders VALUES (3, 1213, 4268, '2025-09-05', '2026-07-27', 'Secretary Steve Reed');
INSERT INTO public.post_holders VALUES (5, 1306, 4621, '2025-09-06', '2026-07-27', 'Darren Jones');
INSERT INTO public.post_holders VALUES (4, 34, 4031, '2024-07-05', '2026-07-27', 'The Chancellor of the Exchequer');
INSERT INTO public.post_holders VALUES (6, 1189, 4621, '2025-09-05', '2026-07-27', 'Darren Jones');
INSERT INTO public.post_holders VALUES (7, 1245, 420, '2025-09-05', '2026-07-27', 'Secretary Yvette Cooper');
INSERT INTO public.post_holders VALUES (36, 856, 4637, '2026-03-03', '2026-07-10', 'James Frith');
INSERT INTO public.post_holders VALUES (116, 1280, 4637, '2026-03-03', '2026-07-10', 'James Frith');
INSERT INTO public.post_holders VALUES (122, 1281, 5414, '2025-09-11', '2026-07-10', 'Baroness Lloyd of Effra');
INSERT INTO public.post_holders VALUES (8, 74, 3914, '2025-09-05', NULL, 'Secretary Shabana Mahmood');
INSERT INTO public.post_holders VALUES (13, 1299, 4046, '2024-07-08', NULL, 'Secretary Bridget Phillipson');
INSERT INTO public.post_holders VALUES (15, 744, 1587, '2025-09-05', NULL, 'Secretary Pat McFadden');
INSERT INTO public.post_holders VALUES (49, 1120, 4993, '2025-09-07', NULL, 'Keir Mather');
INSERT INTO public.post_holders VALUES (9, 691, 4243, '2026-06-11', '2026-07-27', 'Secretary Dan Jarvis');
INSERT INTO public.post_holders VALUES (10, 718, 206, '2025-09-05', '2026-07-27', 'Secretary David Lammy');
INSERT INTO public.post_holders VALUES (11, 1210, 4797, '2026-05-14', '2026-07-27', 'Secretary James Murray');
INSERT INTO public.post_holders VALUES (12, 829, 4046, '2024-07-05', '2026-07-27', 'Secretary Bridget Phillipson');
INSERT INTO public.post_holders VALUES (14, 1274, 1510, '2024-07-05', '2026-07-27', 'Secretary Ed Miliband');
INSERT INTO public.post_holders VALUES (16, 1286, 4505, '2025-09-05', '2026-07-27', 'Secretary Peter Kyle');
INSERT INTO public.post_holders VALUES (17, 1288, 4505, '2025-09-05', '2026-07-27', 'Secretary Peter Kyle');
INSERT INTO public.post_holders VALUES (18, 1275, 4026, '2025-09-05', '2026-07-27', 'Secretary Liz Kendall');
INSERT INTO public.post_holders VALUES (19, 689, 4082, '2024-07-05', '2026-07-27', 'Secretary Lisa Nandy');
INSERT INTO public.post_holders VALUES (20, 704, 4077, '2025-09-05', '2026-07-27', 'Secretary Emma Reynolds');
INSERT INTO public.post_holders VALUES (22, 721, 413, '2024-07-05', '2026-07-27', 'Secretary Hilary Benn');
INSERT INTO public.post_holders VALUES (24, 743, 4425, '2024-07-05', '2026-07-27', 'Secretary Jo Stevens');
INSERT INTO public.post_holders VALUES (27, 523, 4119, '2025-09-05', '2026-07-27', NULL);
INSERT INTO public.post_holders VALUES (28, 1307, 4621, '2025-09-01', '2026-07-27', NULL);
INSERT INTO public.post_holders VALUES (29, 36, 5333, '2026-05-14', '2026-07-27', 'Lucy Rigby');
INSERT INTO public.post_holders VALUES (30, 22, 5365, '2024-07-05', '2026-07-27', 'Lord Hermer');
INSERT INTO public.post_holders VALUES (31, 1108, 4449, '2025-09-06', '2026-07-27', 'Anna Turley');
INSERT INTO public.post_holders VALUES (32, 1302, 3972, '2025-02-28', '2026-07-27', 'Baroness Chapman of Darlington');
INSERT INTO public.post_holders VALUES (33, 506, 4620, '2025-09-06', '2026-07-27', 'The Solicitor General');
INSERT INTO public.post_holders VALUES (34, 831, 4479, '2024-07-08', '2026-07-27', 'Nick Thomas-Symonds');
INSERT INTO public.post_holders VALUES (35, 1310, 491, '2026-06-12', '2026-07-27', NULL);
INSERT INTO public.post_holders VALUES (160, 856, 4637, '2026-06-12', '2026-07-27', 'James Frith');
INSERT INTO public.post_holders VALUES (37, 856, 4508, '2026-03-03', '2026-07-27', 'Baroness Anderson of Stoke-on-Trent');
INSERT INTO public.post_holders VALUES (38, 856, 5271, '2025-09-07', '2026-07-27', 'Satvir Kaur');
INSERT INTO public.post_holders VALUES (39, 856, 5276, '2025-09-06', '2026-07-27', 'Chris Ward');
INSERT INTO public.post_holders VALUES (40, 1094, 3966, '2025-09-06', '2026-07-27', 'Ian Murray');
INSERT INTO public.post_holders VALUES (41, 1094, 4966, '2025-02-24', '2026-07-27', 'Baroness Twycross');
INSERT INTO public.post_holders VALUES (42, 1284, 4607, '2024-07-09', '2026-07-27', 'Stephanie Peacock');
INSERT INTO public.post_holders VALUES (43, 936, 4653, '2026-06-12', '2026-07-27', 'Stephen Morgan');
INSERT INTO public.post_holders VALUES (45, 850, 4645, '2024-07-09', '2026-07-27', 'Emma Hardy');
INSERT INTO public.post_holders VALUES (46, 937, 1579, '2024-07-18', '2026-07-27', 'Mary Creagh');
INSERT INTO public.post_holders VALUES (48, 1120, 4029, '2025-09-16', '2026-07-27', 'Lilian Greenwood');
INSERT INTO public.post_holders VALUES (51, 211, 1533, '2025-09-06', '2026-07-27', 'Dame Diana Johnson');
INSERT INTO public.post_holders VALUES (56, 599, 4979, '2024-07-09', '2026-07-27', 'Andrew Western');
INSERT INTO public.post_holders VALUES (57, 348, 4559, '2024-07-08', '2026-07-27', 'Lord Livermore');
INSERT INTO public.post_holders VALUES (58, 400, 5413, '2025-09-06', '2026-07-27', NULL);
INSERT INTO public.post_holders VALUES (59, 346, 5257, '2026-05-14', '2026-07-27', 'Rachel Blake');
INSERT INTO public.post_holders VALUES (60, 62, 5282, '2025-09-01', '2026-07-27', 'Dan Tomlinson');
INSERT INTO public.post_holders VALUES (63, 1230, 5075, '2026-05-12', '2026-07-27', 'Deirdre Costigan');
INSERT INTO public.post_holders VALUES (64, 1230, 4029, '2025-09-16', '2026-07-27', 'Lilian Greenwood');
INSERT INTO public.post_holders VALUES (66, 1230, 4779, '2024-07-10', '2026-07-27', 'Taiwo Owatemi');
INSERT INTO public.post_holders VALUES (68, 417, 4641, '2025-09-06', '2026-07-27', 'Alex Norris');
INSERT INTO public.post_holders VALUES (70, 366, 5053, '2026-05-12', '2026-07-27', 'Natalie Fleet');
INSERT INTO public.post_holders VALUES (71, 366, 5266, '2025-09-06', '2026-07-27', 'Mike Tapp');
INSERT INTO public.post_holders VALUES (78, 836, 5364, '2024-07-05', '2026-07-27', 'Lord Timpson');
INSERT INTO public.post_holders VALUES (79, 540, 5143, '2026-05-12', '2026-07-27', 'Catherine Atkinson');
INSERT INTO public.post_holders VALUES (81, 540, 5381, '2025-09-06', '2026-07-27', 'Baroness Levitt');
INSERT INTO public.post_holders VALUES (82, 1133, 5162, '2025-09-07', '2026-07-27', 'Matthew Patrick');
INSERT INTO public.post_holders VALUES (84, 537, 5114, '2024-07-09', '2026-07-27', 'Kirsty McNeill');
INSERT INTO public.post_holders VALUES (89, 1298, 269, '2025-03-04', '2026-07-27', 'Baroness Smith of Malvern');
INSERT INTO public.post_holders VALUES (91, 1303, 5337, '2025-09-07', '2026-07-27', NULL);
INSERT INTO public.post_holders VALUES (92, 1303, 4253, '2024-10-08', '2026-07-27', 'Seema Malhotra');
INSERT INTO public.post_holders VALUES (93, 1214, 4083, '2025-09-06', '2026-07-27', 'Alison McGovern');
INSERT INTO public.post_holders VALUES (94, 1214, 4520, '2024-07-09', '2026-07-27', 'Matthew Pennycook');
INSERT INTO public.post_holders VALUES (219, 1209, 5382, '2026-06-12', '2026-07-27', 'Lord Lemos');
INSERT INTO public.post_holders VALUES (95, 1209, 5180, '2026-05-12', '2026-07-27', 'Nesil Caliskan');
INSERT INTO public.post_holders VALUES (96, 1209, 4976, '2025-09-06', '2026-07-27', 'Samantha Dixon');
INSERT INTO public.post_holders VALUES (98, 1211, 4359, '2024-07-08', '2026-07-27', 'Stephen Kinnock');
INSERT INTO public.post_holders VALUES (100, 1212, 4603, '2026-05-12', '2026-07-27', 'Preet Kaur Gill');
INSERT INTO public.post_holders VALUES (101, 1212, 1521, '2026-03-03', '2026-07-27', 'Mrs Sharon Hodgson');
INSERT INTO public.post_holders VALUES (105, 1239, 4253, '2025-09-06', '2026-07-27', 'Seema Malhotra');
INSERT INTO public.post_holders VALUES (106, 1239, 5148, '2025-02-28', '2026-07-27', 'Mr Hamish Falconer');
INSERT INTO public.post_holders VALUES (107, 1239, 4222, '2024-07-09', '2026-07-27', 'Lord Collins of Highbury');
INSERT INTO public.post_holders VALUES (108, 1276, 62, '2025-11-11', '2026-07-27', 'Lord Whitehead');
INSERT INTO public.post_holders VALUES (110, 1276, 5363, '2025-09-06', '2026-07-27', 'Lord Vallance of Balham');
INSERT INTO public.post_holders VALUES (111, 1279, 5116, '2025-09-11', '2026-07-27', 'Chris McDonald');
INSERT INTO public.post_holders VALUES (113, 1279, 5260, '2025-09-07', '2026-07-27', 'Katie White');
INSERT INTO public.post_holders VALUES (114, 1277, 3966, '2025-09-06', '2026-07-27', 'Ian Murray');
INSERT INTO public.post_holders VALUES (115, 1277, 5363, '2024-07-05', '2026-07-27', 'Lord Vallance of Balham');
INSERT INTO public.post_holders VALUES (241, 1280, 4637, '2026-06-12', '2026-07-27', 'James Frith');
INSERT INTO public.post_holders VALUES (117, 1280, 5414, '2025-09-11', '2026-07-27', 'Baroness Lloyd of Effra');
INSERT INTO public.post_holders VALUES (118, 1280, 5039, '2025-09-07', '2026-07-27', 'Kanishka Narayan');
INSERT INTO public.post_holders VALUES (119, 1278, 1446, '2025-09-06', '2026-07-27', 'Chris Bryant');
INSERT INTO public.post_holders VALUES (120, 1278, 5413, '2025-09-06', '2026-07-27', 'Lord Stockwood');
INSERT INTO public.post_holders VALUES (246, 1281, 4959, '2026-06-12', '2026-07-27', 'Lord Leong');
INSERT INTO public.post_holders VALUES (121, 1281, 5116, '2025-09-11', '2026-07-27', 'Chris McDonald');
INSERT INTO public.post_holders VALUES (123, 1281, 5224, '2025-09-07', '2026-07-27', 'Kate Dearden');
INSERT INTO public.post_holders VALUES (124, 1281, 5076, '2025-09-07', '2026-07-27', 'Blair McDougall');


--
-- TOC entry 3862 (class 0 OID 16832)
-- Dependencies: 219
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.posts VALUES (1307, 'Minister of State (Chief Secretary to the Prime Minister)', 'Minister of State (Chief Secretary to the Prime Minister)');
INSERT INTO public.posts VALUES (1108, 'Minister without Portfolio (Cabinet Office)', 'Minister without Portfolio ');
INSERT INTO public.posts VALUES (1302, 'Minister of State (Development)', 'Minister of State (Development)');
INSERT INTO public.posts VALUES (831, 'Paymaster General and Minister for the Cabinet Office', 'The Paymaster General and Minister for the Cabinet Office');
INSERT INTO public.posts VALUES (1094, 'Minister of State (Department for Culture, Media and Sport)', 'The Minister of State, Department for Culture, Media and Sport');
INSERT INTO public.posts VALUES (1284, 'Parliamentary Under Secretary of State (Department for Culture, Media and Sport)', 'Parliamentary Under Secretary of State (Department for Culture, Media and Sport)');
INSERT INTO public.posts VALUES (937, 'Parliamentary Under-Secretary (Department for Environment, Food and Rural Affairs)', 'The Parliamentary Under-Secretary of State for Environment, Food and Rural Affairs');
INSERT INTO public.posts VALUES (1298, 'Minister of State (Minister for Women and Equalities) ', 'Minister of State (Minister for Women and Equalities) ');
INSERT INTO public.posts VALUES (1303, 'Parliamentary Under-Secretary of State (Department for Education) (Equalities)', 'Parliamentary Under-Secretary of State (Department for Education) (Equalities)');
INSERT INTO public.posts VALUES (473, 'Minister of State (Cabinet Office)', 'Minister of State (Cabinet Office)');
INSERT INTO public.posts VALUES (1277, 'Minister of State (Department for Science, Innovation and Technology)', 'Minister of State (Department for Science, Innovation and Technology)');
INSERT INTO public.posts VALUES (1280, 'Parliamentary Under Secretary of State (Department for Science, Innovation and Technology)', 'Parliamentary Under Secretary of State (Department for Science, Innovation and Technology)');
INSERT INTO public.posts VALUES (1278, 'Minister of State (Department for Business and Trade)', 'Minister of State (Department for Business and Trade)');
INSERT INTO public.posts VALUES (1281, 'Parliamentary Under Secretary of State (Department for Business and Trade)', 'Parliamentary Under Secretary of State (Department for Business and Trade)');
INSERT INTO public.posts VALUES (1313, 'First Secretary of State, Chancellor of the Duchy of Lancaster, and Minister for the Cabinet Office', 'First Secretary of State, Chancellor of the Duchy of Lancaster, and Minister for the Cabinet Office');
INSERT INTO public.posts VALUES (1314, 'Secretary of State for Business, Innovation, Science and Trade', 'Secretary of State for Business, Innovation, Science and Trade');
INSERT INTO public.posts VALUES (726, 'Secretary of State for Scotland', 'The Secretary of State for Scotland');
INSERT INTO public.posts VALUES (743, 'Secretary of State for Wales', 'The Secretary of State for Wales');
INSERT INTO public.posts VALUES (1202, 'Secretary of State for Digital, Culture, Media and Sport', 'The Secretary of State for Digital, Culture, Media and Sport');
INSERT INTO public.posts VALUES (1137, 'Leader of the House of Lords and Lord Privy Seal', 'Leader of the House of Lords and Lord Privy Seal');
INSERT INTO public.posts VALUES (1142, 'Lord President of the Council and Leader of the House of Commons', 'Lord President of the Council and Leader of the House of Commons');
INSERT INTO public.posts VALUES (523, 'Parliamentary Secretary to the Treasury (Chief Whip)', 'The Parliamentary Secretary to the Treasury');
INSERT INTO public.posts VALUES (36, 'Chief Secretary to the Treasury', 'The Chief Secretary to the Treasury');
INSERT INTO public.posts VALUES (1315, 'Minister of State (Cabinet Office) (Jointly with the Department for Business, Innovation, Science and Technology)', 'Minister of State (Cabinet Office) (Jointly with the Department for Business, Innovation, Science and Technology)');
INSERT INTO public.posts VALUES (1316, 'Minister of State (Cabinet Office) (Jointly with the Foreign, Commonwealth and Development Office)', 'Minister of State (Cabinet Office) (Jointly with the Foreign, Commonwealth and Development Office)');
INSERT INTO public.posts VALUES (1318, 'Minister of State (Housing, Communities and Local Government)', 'Minister of State (Housing, Communities and Local Government)');
INSERT INTO public.posts VALUES (506, 'Solicitor General (Attorney General''s Office)', 'The Solicitor-General');
INSERT INTO public.posts VALUES (54, 'Deputy Leader of the House of Lords', NULL);
INSERT INTO public.posts VALUES (854, 'Parliamentary Under-Secretary (Ministry of Defence)', 'The Parliamentary Under-Secretary of State for Defence');
INSERT INTO public.posts VALUES (1300, 'Parliamentary Under-Secretary (Ministry of Defence) (Minister for Veterans)', 'Parliamentary Under-Secretary (Ministry of Defence) (Minister for Veterans)');
INSERT INTO public.posts VALUES (1267, 'Prime Minister and First Lord of the Treasury', 'The Prime Minister');
INSERT INTO public.posts VALUES (1244, 'Deputy Prime Minister', 'Deputy Prime Minister');
INSERT INTO public.posts VALUES (1306, 'Minister for Intergovernmental Relations', 'Minister for Intergovernmental Relations');
INSERT INTO public.posts VALUES (1189, 'Chancellor of the Duchy of Lancaster', 'Chancellor of the Duchy of Lancaster');
INSERT INTO public.posts VALUES (34, 'Chancellor of the Exchequer', 'The Chancellor of the Exchequer');
INSERT INTO public.posts VALUES (1245, 'Foreign Secretary', 'Foreign Secretary, Foreign, Commonwealth and Development Office');
INSERT INTO public.posts VALUES (74, 'Home Secretary', 'The Secretary of State for the Home Department');
INSERT INTO public.posts VALUES (691, 'Secretary of State for Defence', 'The Secretary of State for Defence');
INSERT INTO public.posts VALUES (718, 'Lord Chancellor and Secretary of State for Justice', 'The Lord Chancellor and Secretary of State for Justice ');
INSERT INTO public.posts VALUES (1210, 'Secretary of State for Health and Social Care', 'Secretary of State for Health and Social Care');
INSERT INTO public.posts VALUES (829, 'Secretary of State for Education', 'The Secretary of State for Education');
INSERT INTO public.posts VALUES (1299, 'Minister for Women and Equalities', 'Minister for Women and Equalities');
INSERT INTO public.posts VALUES (1213, 'Secretary of State for Housing, Communities and Local Government', 'The Secretary of State for Housing, Communities and Local Government');
INSERT INTO public.posts VALUES (1274, 'Secretary of State for Energy Security and Net Zero', 'The Secretary of State for Energy Security and Net Zero');
INSERT INTO public.posts VALUES (744, 'Secretary of State for Work and Pensions', 'The Secretary of State for Work and Pensions');
INSERT INTO public.posts VALUES (704, 'Secretary of State for Environment, Food and Rural Affairs', 'The Secretary of State for Environment, Food and Rural Affairs');
INSERT INTO public.posts VALUES (739, 'Secretary of State for Transport', 'The Secretary of State for Transport');
INSERT INTO public.posts VALUES (721, 'Secretary of State for Northern Ireland', 'The Secretary of State for Northern Ireland');
INSERT INTO public.posts VALUES (22, 'Attorney General', 'The Attorney-General');
INSERT INTO public.posts VALUES (1310, 'Minister of State (Home Office) (Security) (Jointly with the Cabinet Office)', 'Minister of State (Home Office) (Security) (Jointly with the Cabinet Office)');
INSERT INTO public.posts VALUES (856, 'Parliamentary Secretary (Cabinet Office)', 'The Parliamentary Secretary, Cabinet Office');
INSERT INTO public.posts VALUES (1320, 'Exchequer Secretary (Cabinet Office) (Jointly with HM Treasury)', 'Exchequer Secretary (Cabinet Office) (Jointly with HM Treasury)');
INSERT INTO public.posts VALUES (1325, 'Parliamentary Secretary and Parliamentary Under-Secretary of State (Cabinet Office) (Jointly with the Ministry for Housing, Communities and Local Government)', 'Parliamentary Secretary and Parliamentary Under-Secretary of State (Cabinet Office) (Jointly with the Ministry for Housing, Communities and Local Government)');
INSERT INTO public.posts VALUES (936, 'Minister of State (Department for Environment, Food and Rural Affairs)', 'The Minister of State, Department for Environment, Food and Rural Affairs');
INSERT INTO public.posts VALUES (1286, 'Secretary of State for Business and Trade', 'Secretary of State for Business and Trade');
INSERT INTO public.posts VALUES (1288, 'President of the Board of Trade', 'President of the Board of Trade');
INSERT INTO public.posts VALUES (1275, 'Secretary of State for Science, Innovation and Technology', 'The Secretary of State for Science, Innovation and Technology');
INSERT INTO public.posts VALUES (689, 'Secretary of State for Culture, Media and Sport', 'The Secretary of State for Culture, Media and Sport');
INSERT INTO public.posts VALUES (850, 'Parliamentary Under-Secretary (Department for Environment, Food and Rural Affairs)', 'The Parliamentary Under-Secretary of State for Environment, Food and Rural Affairs');
INSERT INTO public.posts VALUES (1126, 'Minister of State (Department for Transport)', 'Minister of State (Department for Transport)');
INSERT INTO public.posts VALUES (543, 'Parliamentary Under-Secretary (Wales Office)', 'The Parliamentary Under-Secretary of State for Wales');
INSERT INTO public.posts VALUES (947, 'Minister of State (Education)', 'Minister of State (Education)');
INSERT INTO public.posts VALUES (949, 'Parliamentary Under-Secretary (Department for Education)', 'The Parliamentary Under-Secretary of State for Education');
INSERT INTO public.posts VALUES (1225, 'Minister of State (Department for Digital, Culture, Media and Sport)', 'Minister of State');
INSERT INTO public.posts VALUES (1204, 'Parliamentary Under-Secretary of State (Department for Digital, Culture, Media and Sport)', 'Parliamentary Under-Secretary of State (Department for Digital, Culture, Media and Sport)');
INSERT INTO public.posts VALUES (1214, 'Minister of State (Housing, Communities and Local Government)', 'Minister of State (Housing, Communities and Local Government)');
INSERT INTO public.posts VALUES (1323, 'Minister of State (Ministry of Housing Communities and Local Government) (Equalities)', 'Minister of State (Ministry of Housing Communities and Local Government) (Equalities)');
INSERT INTO public.posts VALUES (1209, 'Parliamentary Under-Secretary (Housing, Communities and Local Government)', 'Parliamentary Under-Secretary (Housing, Communities and Local Government)');
INSERT INTO public.posts VALUES (1322, 'Parliamentary Under-Secretary (Housing, Communities and Local Government) (Minister for Equalities)', 'Parliamentary Under-Secretary (Housing, Communities and Local Government) (Minister for Equalities)');
INSERT INTO public.posts VALUES (1211, 'Minister of State (Department of Health and Social Care)', 'Minister of State (Department of Health and Social Care)');
INSERT INTO public.posts VALUES (1212, 'Parliamentary Under-Secretary (Department of Health and Social Care)', 'The Parliamentary Under-Secretary for Health and Social Care');
INSERT INTO public.posts VALUES (1238, 'Minister of State (Foreign, Commonwealth and Development Office)', 'Minister of State (Foreign, Commonwealth and Development Office)');
INSERT INTO public.posts VALUES (1239, 'Parliamentary Under-Secretary (Foreign, Commonwealth and Development Office)', 'Parliamentary Under-Secretary (Foreign, Commonwealth and Development Office)');
INSERT INTO public.posts VALUES (1120, 'Parliamentary Under-Secretary (Department for Transport)', 'Parliamentary Under-Secretary (Department for Transport)');
INSERT INTO public.posts VALUES (211, 'Minister of State (Department for Work and Pensions)', 'The Minister of State, Department for Work and Pensions');
INSERT INTO public.posts VALUES (292, 'Minister of State (Department for Work and Pensions)', 'The Minister of State, Department for Work and Pensions');
INSERT INTO public.posts VALUES (599, 'Parliamentary Under-Secretary (Department for Work and Pensions)', 'The Parliamentary Under-Secretary of State for Work and Pensions');
INSERT INTO public.posts VALUES (346, 'Economic Secretary (HM Treasury)', 'The Economic Secretary to the Treasury');
INSERT INTO public.posts VALUES (1272, 'Parliamentary Secretary (HM Treasury)', 'The Parliamentary Secretary, HM Treasury');
INSERT INTO public.posts VALUES (1230, 'Government Whip, Lord Commissioner of HM Treasury', 'Government Whip, Lord Commissioner of HM Treasury');
INSERT INTO public.posts VALUES (417, 'Minister of State (Home Office)', 'The Minister of State, Home Department');
INSERT INTO public.posts VALUES (366, 'Parliamentary Under-Secretary (Home Office)', 'The Parliamentary Under-Secretary of State for the Home Department');
INSERT INTO public.posts VALUES (222, 'Minister of State (Ministry of Defence)', 'The Minister of State, Ministry of Defence');
INSERT INTO public.posts VALUES (1309, 'Parliamentary Under-Secretary (Ministry of Defence) (Minister for the Armed Forces)', 'Parliamentary Under-Secretary (Ministry of Defence) (Minister for the Armed Forces)');
INSERT INTO public.posts VALUES (1312, 'Parliamentary Under-Secretary (Ministry of Defence) (Minister for Veterans and People)', 'Parliamentary Under-Secretary (Ministry of Defence) (Minister for Veterans and People)');
INSERT INTO public.posts VALUES (836, 'Minister of State (Ministry of Justice)', 'The Minister of State, Ministry of Justice');
INSERT INTO public.posts VALUES (540, 'Parliamentary Under-Secretary (Ministry of Justice)', 'The Parliamentary Under-Secretary of State for Justice');
INSERT INTO public.posts VALUES (1133, 'Parliamentary Under-Secretary (Northern Ireland Office)', 'Parliamentary Under-Secretary (Northern Ireland Office)');
INSERT INTO public.posts VALUES (1067, 'Lords Spokesperson (Northern Ireland Office)', NULL);
INSERT INTO public.posts VALUES (348, 'Financial Secretary (HM Treasury)', 'The Financial Secretary to the Treasury');
INSERT INTO public.posts VALUES (400, 'Minister of State (HM Treasury)', 'Minister of State (HM Treasury)');
INSERT INTO public.posts VALUES (62, 'Exchequer Secretary (HM Treasury)', 'The Exchequer Secretary');
INSERT INTO public.posts VALUES (537, 'Parliamentary Under-Secretary (Scotland Office)', 'The Parliamentary Under-Secretary of State for Scotland');
INSERT INTO public.posts VALUES (1276, 'Minister of State (Department for Energy Security and Net Zero)', 'Minister of State (Department for Energy Security and Net Zero)');
INSERT INTO public.posts VALUES (1279, 'Parliamentary Under-Secretary of State (Department for Energy Security and Net Zero)', 'Parliamentary Under-Secretary of State (Department for Energy Security and Net Zero)');
INSERT INTO public.posts VALUES (1324, 'Parliamentary Under-Secretary of State (Department for Business, Innovation, Science and Trade) (Jointly with the Department for Energy Security and Net Zero) ', 'Parliamentary Under-Secretary of State (Department for Business, Innovation, Science and Trade) (Jointly with the Department for Energy Security and Net Zero) ');
INSERT INTO public.posts VALUES (1317, 'Minister of State (Department for Business, Innovation, Science and Trade)', 'Minister of State (Department for Business, Innovation, Science and Trade)');
INSERT INTO public.posts VALUES (1319, 'Parliamentary Under-Secretary of State (Department for Business, Innovation, Science and Trade)', 'Parliamentary Under-Secretary of State (Department for Business, Innovation, Science and Trade)');


--
-- TOC entry 3877 (class 0 OID 0)
-- Dependencies: 225
-- Name: member_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.member_contacts_id_seq', 1465, true);


--
-- TOC entry 3878 (class 0 OID 0)
-- Dependencies: 223
-- Name: post_holders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_holders_id_seq', 366, true);


--
-- TOC entry 3696 (class 2606 OID 16849)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- TOC entry 3709 (class 2606 OID 16911)
-- Name: member_contacts member_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_contacts
    ADD CONSTRAINT member_contacts_pkey PRIMARY KEY (id);


--
-- TOC entry 3700 (class 2606 OID 16874)
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- TOC entry 3698 (class 2606 OID 16856)
-- Name: post_departments post_departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_departments
    ADD CONSTRAINT post_departments_pkey PRIMARY KEY (post_id, department_id);


--
-- TOC entry 3704 (class 2606 OID 16886)
-- Name: post_holders post_holders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_holders
    ADD CONSTRAINT post_holders_pkey PRIMARY KEY (id);


--
-- TOC entry 3706 (class 2606 OID 16888)
-- Name: post_holders post_holders_post_id_member_id_start_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_holders
    ADD CONSTRAINT post_holders_post_id_member_id_start_date_key UNIQUE (post_id, member_id, start_date);


--
-- TOC entry 3694 (class 2606 OID 16840)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 3707 (class 1259 OID 16917)
-- Name: idx_member_contacts_member; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_member_contacts_member ON public.member_contacts USING btree (member_id);


--
-- TOC entry 3701 (class 1259 OID 16899)
-- Name: idx_post_holders_member; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_post_holders_member ON public.post_holders USING btree (member_id);


--
-- TOC entry 3702 (class 1259 OID 16900)
-- Name: idx_post_holders_post; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_post_holders_post ON public.post_holders USING btree (post_id);


--
-- TOC entry 3714 (class 2606 OID 16912)
-- Name: member_contacts member_contacts_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_contacts
    ADD CONSTRAINT member_contacts_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 3710 (class 2606 OID 16862)
-- Name: post_departments post_departments_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_departments
    ADD CONSTRAINT post_departments_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id) ON DELETE CASCADE;


--
-- TOC entry 3711 (class 2606 OID 16857)
-- Name: post_departments post_departments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_departments
    ADD CONSTRAINT post_departments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 3712 (class 2606 OID 16894)
-- Name: post_holders post_holders_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_holders
    ADD CONSTRAINT post_holders_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 3713 (class 2606 OID 16889)
-- Name: post_holders post_holders_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_holders
    ADD CONSTRAINT post_holders_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


-- Completed on 2026-07-28 13:19:27 BST

--
-- PostgreSQL database dump complete
--

\unrestrict P09s7NrlzJ35Qu4Mc9UM3Jws36bHcVrGdkvMBuv9cu5e7EcIMje35VhT4fU2YdF

