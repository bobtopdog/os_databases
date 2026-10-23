--
-- PostgreSQL database dump
--

\restrict pYkPoI7U7lalnMsTUS4uW4n6b4scdNeVKmYhpzUhTri0EirnS2RyzCT8pcu6MIT

-- Dumped from database version 18.6 (Postgres.app)
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-23 15:35:55 BST

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
-- TOC entry 220 (class 1259 OID 16624)
-- Name: government_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.government_posts (
    post_id integer NOT NULL,
    name text,
    hansard_name text,
    departments text[]
);


--
-- TOC entry 223 (class 1259 OID 16653)
-- Name: member_contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.member_contacts (
    id integer NOT NULL,
    member_id integer,
    type text,
    phone text,
    email text,
    line1 text
);


--
-- TOC entry 222 (class 1259 OID 16652)
-- Name: member_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.member_contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3856 (class 0 OID 0)
-- Dependencies: 222
-- Name: member_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.member_contacts_id_seq OWNED BY public.member_contacts.id;


--
-- TOC entry 219 (class 1259 OID 16616)
-- Name: members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.members (
    member_id integer NOT NULL,
    name_display_as text,
    name_full_title text,
    gender text,
    latest_party text
);


--
-- TOC entry 224 (class 1259 OID 16827)
-- Name: members_posts; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.members_posts AS
 SELECT member_id,
    name_display_as,
    name_full_title,
    gender,
    latest_party
   FROM public.members;


--
-- TOC entry 221 (class 1259 OID 16632)
-- Name: post_holders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_holders (
    post_id integer NOT NULL,
    member_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    laying_minister_name text
);


--
-- TOC entry 3686 (class 2604 OID 16656)
-- Name: member_contacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member_contacts ALTER COLUMN id SET DEFAULT nextval('public.member_contacts_id_seq'::regclass);


--
-- TOC entry 3847 (class 0 OID 16624)
-- Dependencies: 220
-- Data for Name: government_posts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.government_posts (post_id, name, hansard_name, departments) FROM stdin;
1275	Secretary of State for Science, Innovation and Technology	The Secretary of State for Science, Innovation and Technology	{"Department for Science, Innovation and Technology"}
689	Secretary of State for Culture, Media and Sport	The Secretary of State for Culture, Media and Sport	{"Department for Culture, Media and Sport"}
704	Secretary of State for Environment, Food and Rural Affairs	The Secretary of State for Environment, Food and Rural Affairs	{"Department for Environment, Food and Rural Affairs"}
739	Secretary of State for Transport	The Secretary of State for Transport	{"Department for Transport"}
721	Secretary of State for Northern Ireland	The Secretary of State for Northern Ireland	{"Northern Ireland Office"}
726	Secretary of State for Scotland	The Secretary of State for Scotland	{"Scotland Office"}
743	Secretary of State for Wales	The Secretary of State for Wales	{"Wales Office"}
523	Parliamentary Secretary to the Treasury (Chief Whip)	The Parliamentary Secretary to the Treasury	{"HM Treasury"}
1307	Minister of State (Chief Secretary to the Prime Minister)	Minister of State (Chief Secretary to the Prime Minister)	{"Cabinet Office"}
36	Chief Secretary to the Treasury	The Chief Secretary to the Treasury	{"HM Treasury"}
22	Attorney General	The Attorney-General	{"Attorney General's Office"}
1108	Minister without Portfolio (Cabinet Office)	Minister without Portfolio 	{"Cabinet Office"}
1302	Minister of State (Development)	Minister of State (Development)	{"Foreign, Commonwealth and Development Office"}
1267	Prime Minister and First Lord of the Treasury	The Prime Minister	{"Prime Minister","Cabinet Office"}
1244	Deputy Prime Minister	Deputy Prime Minister	{"Cabinet Office"}
1213	Secretary of State for Housing, Communities and Local Government	The Secretary of State for Housing, Communities and Local Government	{"Ministry of Housing, Communities and Local Government"}
34	Chancellor of the Exchequer	The Chancellor of the Exchequer	{"HM Treasury"}
1306	Minister for Intergovernmental Relations	Minister for Intergovernmental Relations	{"Cabinet Office"}
1189	Chancellor of the Duchy of Lancaster	Chancellor of the Duchy of Lancaster	{"Cabinet Office"}
74	Home Secretary	The Secretary of State for the Home Department	{"Home Office"}
691	Secretary of State for Defence	The Secretary of State for Defence	{"Ministry of Defence"}
718	Lord Chancellor and Secretary of State for Justice	The Lord Chancellor and Secretary of State for Justice 	{"Ministry of Justice"}
1210	Secretary of State for Health and Social Care	Secretary of State for Health and Social Care	{"Department of Health and Social Care"}
829	Secretary of State for Education	The Secretary of State for Education	{"Department for Education"}
1299	Minister for Women and Equalities	Minister for Women and Equalities	{"Department for Education"}
1274	Secretary of State for Energy Security and Net Zero	The Secretary of State for Energy Security and Net Zero	{"Department for Energy Security and Net Zero"}
744	Secretary of State for Work and Pensions	The Secretary of State for Work and Pensions	{"Department for Work and Pensions"}
1286	Secretary of State for Business and Trade	Secretary of State for Business and Trade	{"Department for Business and Trade "}
1288	President of the Board of Trade	President of the Board of Trade	{"Department for Business and Trade ","UK Export Finance"}
1137	Leader of the House of Lords and Lord Privy Seal	Leader of the House of Lords and Lord Privy Seal	{"Office of the Leader of the House of Lords"}
1142	Lord President of the Council and Leader of the House of Commons	Lord President of the Council and Leader of the House of Commons	{"Office of the Leader of the House of Commons"}
1245	Foreign Secretary	Foreign Secretary, Foreign, Commonwealth and Development Office	{"Foreign, Commonwealth and Development Office"}
\.


--
-- TOC entry 3850 (class 0 OID 16653)
-- Dependencies: 223
-- Data for Name: member_contacts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.member_contacts (id, member_id, type, phone, email, line1) FROM stdin;
1	4514	Prime Minister's office	\N	\N	https://contact.no10.gov.uk/
2	4514	Parliamentary office	\N	keir.starmer.mp@parliament.uk	House of Commons
3	4514	Constituency office	\N	keir.starmer.constituency@parliament.uk	Constituency Office
4	4514	Website	\N	\N	http://www.keirstarmer.com/
5	4514	X (formerly Twitter)	\N	\N	https://twitter.com/keir_starmer
6	206	Parliamentary office	\N	david.lammy.mp@parliament.uk 	House of Commons
7	206	Website	\N	\N	http://www.davidlammy.co.uk
8	206	X (formerly Twitter)	\N	\N	https://twitter.com/DavidLammy
9	4268	Parliamentary office	020 7219 7297	steve.reed.mp@parliament.uk	House of Commons
10	4268	Website	\N	\N	http://www.stevereedmp.co.uk/
11	4268	X (formerly Twitter)	\N	\N	https://twitter.com/SteveReedMP
12	4031	Chancellor of the Exchequer's office	\N	public.enquiries@hmtreasury.gov.uk	Ministerial office
13	4031	Parliamentary office	020 7219 7097	rachel.reeves.mp@parliament.uk	House of Commons
14	4031	Constituency office	0113 255 2311	leedswestandpudsey@parliament.uk	Unit 8A
15	4031	Website	\N	\N	https://www.rachelreevesmp.co.uk/
16	4031	X (formerly Twitter)	\N	\N	https://twitter.com/RachelReevesMP
17	4621	Parliamentary office	0207 219 5225	darren.jones.mp@parliament.uk	House of Commons
18	4621	Constituency office	0117 959 6545	\N	Constituency Office
19	4621	Website	\N	\N	http://www.darren-jones.co.uk/
20	4621	Facebook	\N	\N	https://www.facebook.com/darrenjonesmp
21	4621	X (formerly Twitter)	\N	\N	https://twitter.com/darrenpjones
22	420	Parliamentary office	020 7219 5080	coopery@parliament.uk	House of Commons
23	420	Constituency office	01977 553388	coopery@parliament.uk	Queen's Mill
24	420	Website	\N	\N	http://www.yvettecooper.com
25	420	Facebook	\N	\N	https://www.facebook.com/YvetteCooperMP
26	420	X (formerly Twitter)	\N	\N	https://twitter.com/YvetteCooperMP
27	3914	Parliamentary office	0121 661 9440	shabana.mahmood.mp@parliament.uk	House of Commons
28	3914	Website	\N	\N	https://www.shabanamahmood.org
29	3914	X (formerly Twitter)	\N	\N	https://twitter.com/ShabanaMahmood
30	400	Parliamentary office	020 7219 4031	john.healey.mp@parliament.uk	House of Commons
31	400	Constituency office	01709 875943	john.healey.mp@parliament.uk	79 High Street
32	400	Website	\N	\N	http://www.johnhealeymp.co.uk
33	400	X (formerly Twitter)	\N	\N	https://twitter.com/JohnHealey_MP
34	4504	Parliamentary office	020 7219 6132	wes.streeting.mp@parliament.uk	House of Commons
35	4504	Constituency office	0203 475 7901	\N	Constituency office
36	4504	Website	\N	\N	http://www.wesstreeting.org/
37	4504	X (formerly Twitter)	\N	\N	https://twitter.com/wesstreeting
38	4046	Parliamentary office	020 7219 7087	bridget.phillipson.mp@parliament.uk	House of Commons
39	4046	Constituency office	0191 584 4317	\N	106 Newbottle Street
40	4046	Website	\N	\N	http://www.BridgetPhillipson.com
41	4046	Facebook	\N	\N	https://www.facebook.com/bridgetphillipson
42	4046	X (formerly Twitter)	\N	\N	https://twitter.com/bphillipsonMP
43	1510	Parliamentary office	020 7219 7318	ed.miliband.mp@parliament.uk	House of Commons
44	1510	Constituency office	01302875462	\N	Constituency office
45	1510	Facebook	\N	\N	https://www.facebook.com/edmiliband
46	1510	X (formerly Twitter)	\N	\N	https://twitter.com/Ed_Miliband
47	1587	Parliamentary office	020 7219 4036	mcfaddenp@parliament.uk	House of Commons
48	1587	Constituency office	01902 405762		Crescent House
49	1587	Website	\N	\N	http://www.patmcfadden.com
50	1587	X (formerly Twitter)	\N	\N	https://twitter.com/patmcfaddenmp
51	4505	Parliamentary office	020 7219 1897	peter.kyle.mp@parliament.uk	House of Commons
52	4505	Constituency office	01273 933 380	hove.portslade@parliament.uk	99 Church Road
53	4505	Website	\N	\N	http://www.peterkyle.co.uk/
54	4505	Facebook	\N	\N	https://www.facebook.com/hoveandportslade
55	4505	X (formerly Twitter)	\N	\N	https://twitter.com/peterkyle
56	4026	Parliamentary office	020 7219 3000	liz.kendall.mp@parliament.uk	House of Commons
57	4026	Government department	\N	correspondence@dsit.gov.uk	Department for Science, Innovation and Technology
58	4026	Website	\N	\N	https://www.lizkendall.org
59	4026	X (formerly Twitter)	\N	\N	https://twitter.com/leicesterliz
60	4082	Parliamentary office	020 7219 3000	lisa.nandy.mp@parliament.uk	House of Commons
61	4082	Constituency office	01942 242 047	\N	2nd Floor
62	4082	Website	\N	\N	https://lisanandy.laboursites.org
63	4082	X (formerly Twitter)	\N	\N	https://twitter.com/lisanandy
64	4077	Parliamentary office	020 7219 3000	emma.reynolds.mp@parliament.uk	House of Commons
65	4077	Website	\N	\N	www.emmaforwycombe.org.uk
66	4077	X (formerly Twitter)	\N	\N	https://x.com/emmaforwycombe
67	4038	Parliamentary office	\N	heidi.alexander.mp@parliament.uk	House of Commons
68	4038	Website	\N	\N	https://www.heidialexander.org.uk
69	4038	Facebook	\N	\N	https://facebook.com/heidialexanderswindon
70	4038	Instagram	\N	\N	https://instagram.com/heidi_labour
71	4038	X (formerly Twitter)	\N	\N	https://twitter.com/heidi_labour
72	413	Parliamentary office	020 7219 5770	bennh@parliament.uk	House of Commons
73	413	Constituency office	0113 244 1097	boxj@parliament.uk	Suite 7
74	413	Website	\N	\N	http://www.hilarybennmp.com/
75	413	X (formerly Twitter)	\N	\N	https://twitter.com/hilarybennmp
76	632	Parliamentary office	\N	douglas.alexander.mp@parliament.uk	House of Commons
77	632	Website	\N	\N	https://douglasalexandermp.com
78	632	Facebook	\N	\N	https://www.facebook.com/douglas4eastlothian
79	632	X (formerly Twitter)	\N	\N	https://x.com/D_G_Alexander
80	4425	Parliamentary office	020 7219 8290	jo.stevens.mp@parliament.uk	House of Commons
81	4425	Constituency office	02921 329736	\N	116 Albany Road
82	4425	Website	\N	\N	http://www.jostevens.co.uk/
83	4425	X (formerly Twitter)	\N	\N	https://twitter.com/jostevenslabour
167	4082	Website	\N	\N	https://lisanandy.laboursites.org
84	529	Parliamentary office	020 7219 3000	alan.campbell.mp@parliament.uk	House of Commons
85	529	Constituency office	0191 257 1927	\N	Suite 1:11
86	529	Website	\N	\N	http://www.alancampbellmp.co.uk
87	529	X (formerly Twitter)	\N	\N	https://twitter.com/alancampbellmp
88	4170	Parliamentary office	020 7219 5353	contactholmember@parliament.uk 	House of Lords
89	4119	Parliamentary office	\N	jonathan.reynolds.mp@parliament.uk	House of Commons
90	4119	Constituency office	0161 367 8077		Hyde Town Hall
91	4119	Website	\N	\N	http://www.jonathanreynolds.org.uk
92	4119	X (formerly Twitter)	\N	\N	https://twitter.com/jreynoldsMP
93	4797	Parliamentary office	020 7219 3931	james.murray.mp@parliament.uk	House of Commons
94	4797	Website	\N	\N	https://www.jamesmurray.org/
95	4797	Facebook	\N	\N	https://www.facebook.com/james4ealing
96	4797	X (formerly Twitter)	\N	\N	https://twitter.com/jamesmurray_ldn
97	5365	Parliamentary office	020 7219 5353	contactholmember@parliament.uk	House of Lords
98	4449	Parliamentary office	\N	anna.turley.mp@parliament.uk	House of Commons
99	4449	Constituency office	01642 929159	\N	The Palace Hub
100	4449	Website	\N	\N	https://www.annaturley.org/
101	4449	Facebook	\N	\N	https://www.facebook.com/Anna4Redcar/
102	4449	LinkedIn	\N	\N	https://www.linkedin.com/in/anna-turley-8b666519b/
103	4449	X (formerly Twitter)	\N	\N	https://x.com/annaturley
104	3972	Parliamentary office	020 7219 5353	contactholmember@parliament.uk	House of Lords
105	3972	X (formerly Twitter)	\N	\N	https://twitter.com/JennyChapman
106	4514	Prime Minister's office	\N	\N	https://contact.no10.gov.uk/
107	4514	Parliamentary office	\N	keir.starmer.mp@parliament.uk	House of Commons
108	4514	Constituency office	\N	keir.starmer.constituency@parliament.uk	Constituency Office
109	4514	Website	\N	\N	http://www.keirstarmer.com/
110	4514	X (formerly Twitter)	\N	\N	https://twitter.com/keir_starmer
111	206	Parliamentary office	\N	david.lammy.mp@parliament.uk 	House of Commons
112	206	Website	\N	\N	http://www.davidlammy.co.uk
113	206	X (formerly Twitter)	\N	\N	https://twitter.com/DavidLammy
114	4268	Parliamentary office	020 7219 7297	steve.reed.mp@parliament.uk	House of Commons
115	4268	Website	\N	\N	http://www.stevereedmp.co.uk/
116	4268	X (formerly Twitter)	\N	\N	https://twitter.com/SteveReedMP
117	4031	Chancellor of the Exchequer's office	\N	public.enquiries@hmtreasury.gov.uk	Ministerial office
118	4031	Parliamentary office	020 7219 7097	rachel.reeves.mp@parliament.uk	House of Commons
119	4031	Constituency office	0113 255 2311	leedswestandpudsey@parliament.uk	Unit 8A
120	4031	Website	\N	\N	https://www.rachelreevesmp.co.uk/
121	4031	X (formerly Twitter)	\N	\N	https://twitter.com/RachelReevesMP
122	4621	Parliamentary office	0207 219 5225	darren.jones.mp@parliament.uk	House of Commons
123	4621	Constituency office	0117 959 6545	\N	Constituency Office
124	4621	Website	\N	\N	http://www.darren-jones.co.uk/
125	4621	Facebook	\N	\N	https://www.facebook.com/darrenjonesmp
126	4621	X (formerly Twitter)	\N	\N	https://twitter.com/darrenpjones
127	420	Parliamentary office	020 7219 5080	coopery@parliament.uk	House of Commons
128	420	Constituency office	01977 553388	coopery@parliament.uk	Queen's Mill
129	420	Website	\N	\N	http://www.yvettecooper.com
130	420	Facebook	\N	\N	https://www.facebook.com/YvetteCooperMP
131	420	X (formerly Twitter)	\N	\N	https://twitter.com/YvetteCooperMP
132	3914	Parliamentary office	0121 661 9440	shabana.mahmood.mp@parliament.uk	House of Commons
133	3914	Website	\N	\N	https://www.shabanamahmood.org
134	3914	X (formerly Twitter)	\N	\N	https://twitter.com/ShabanaMahmood
135	400	Parliamentary office	020 7219 4031	john.healey.mp@parliament.uk	House of Commons
136	400	Constituency office	01709 875943	john.healey.mp@parliament.uk	79 High Street
137	400	Website	\N	\N	http://www.johnhealeymp.co.uk
138	400	X (formerly Twitter)	\N	\N	https://twitter.com/JohnHealey_MP
139	4797	Parliamentary office	020 7219 3000	james.murray.mp@parliament.uk	House of Commons
140	4797	Website	\N	\N	https://www.jamesmurray.org/
141	4797	Facebook	\N	\N	https://www.facebook.com/james4ealing
142	4797	X (formerly Twitter)	\N	\N	https://twitter.com/jamesmurray_ldn
143	4046	Parliamentary office	020 7219 7087	bridget.phillipson.mp@parliament.uk	House of Commons
144	4046	Constituency office	0191 584 4317	\N	106 Newbottle Street
145	4046	Website	\N	\N	http://www.BridgetPhillipson.com
146	4046	Facebook	\N	\N	https://www.facebook.com/bridgetphillipson
147	4046	X (formerly Twitter)	\N	\N	https://twitter.com/bphillipsonMP
148	1510	Parliamentary office	020 7219 7318	ed.miliband.mp@parliament.uk	House of Commons
149	1510	Constituency office	01302875462	\N	Constituency office
150	1510	Facebook	\N	\N	https://www.facebook.com/edmiliband
151	1510	X (formerly Twitter)	\N	\N	https://twitter.com/Ed_Miliband
152	1587	Parliamentary office	020 7219 4036	mcfaddenp@parliament.uk	House of Commons
153	1587	Constituency office	01902 405762		Crescent House
154	1587	Website	\N	\N	http://www.patmcfadden.com
155	1587	X (formerly Twitter)	\N	\N	https://twitter.com/patmcfaddenmp
156	4505	Parliamentary office	020 7219 1897	peter.kyle.mp@parliament.uk	House of Commons
157	4505	Constituency office	01273 933 380	hove.portslade@parliament.uk	99 Church Road
158	4505	Website	\N	\N	http://www.peterkyle.co.uk/
159	4505	Facebook	\N	\N	https://www.facebook.com/hoveandportslade
160	4505	X (formerly Twitter)	\N	\N	https://twitter.com/peterkyle
161	4026	Parliamentary office	020 7219 3000	liz.kendall.mp@parliament.uk	House of Commons
162	4026	Government department	\N	correspondence@dsit.gov.uk	Department for Science, Innovation and Technology
163	4026	Website	\N	\N	https://www.lizkendall.org
164	4026	X (formerly Twitter)	\N	\N	https://twitter.com/leicesterliz
165	4082	Parliamentary office	020 7219 3000	lisa.nandy.mp@parliament.uk	House of Commons
166	4082	Constituency office	01942 242 047	\N	2nd Floor
168	4082	X (formerly Twitter)	\N	\N	https://twitter.com/lisanandy
169	4077	Parliamentary office	020 7219 3000	emma.reynolds.mp@parliament.uk	House of Commons
170	4077	Website	\N	\N	www.emmaforwycombe.org.uk
171	4077	X (formerly Twitter)	\N	\N	https://x.com/emmaforwycombe
172	4038	Parliamentary office	\N	heidi.alexander.mp@parliament.uk	House of Commons
173	4038	Website	\N	\N	https://www.heidialexander.org.uk
174	4038	Facebook	\N	\N	https://facebook.com/heidialexanderswindon
175	4038	Instagram	\N	\N	https://instagram.com/heidi_labour
176	4038	X (formerly Twitter)	\N	\N	https://twitter.com/heidi_labour
177	413	Parliamentary office	020 7219 5770	bennh@parliament.uk	House of Commons
178	413	Constituency office	0113 244 1097	boxj@parliament.uk	Suite 7
179	413	Website	\N	\N	http://www.hilarybennmp.com/
180	413	X (formerly Twitter)	\N	\N	https://twitter.com/hilarybennmp
181	632	Parliamentary office	\N	douglas.alexander.mp@parliament.uk	House of Commons
182	632	Website	\N	\N	https://douglasalexandermp.com
183	632	Facebook	\N	\N	https://www.facebook.com/douglas4eastlothian
184	632	X (formerly Twitter)	\N	\N	https://x.com/D_G_Alexander
185	4425	Parliamentary office	020 7219 8290	jo.stevens.mp@parliament.uk	House of Commons
186	4425	Constituency office	02921 329736	\N	116 Albany Road
187	4425	Website	\N	\N	http://www.jostevens.co.uk/
188	4425	X (formerly Twitter)	\N	\N	https://twitter.com/jostevenslabour
189	529	Parliamentary office	020 7219 3000	alan.campbell.mp@parliament.uk	House of Commons
190	529	Constituency office	0191 257 1927	\N	Suite 1:11
191	529	Website	\N	\N	http://www.alancampbellmp.co.uk
192	529	X (formerly Twitter)	\N	\N	https://twitter.com/alancampbellmp
193	4170	Parliamentary office	020 7219 5353	contactholmember@parliament.uk 	House of Lords
194	4119	Parliamentary office	\N	jonathan.reynolds.mp@parliament.uk	House of Commons
195	4119	Constituency office	0161 367 8077		Hyde Town Hall
196	4119	Website	\N	\N	http://www.jonathanreynolds.org.uk
197	4119	X (formerly Twitter)	\N	\N	https://twitter.com/jreynoldsMP
198	5333	Parliamentary office	0207 219 7605	lucy.rigby.mp@parliament.uk	House of Commons
199	5333	Constituency office	01604 915131	lucy.rigby.casework@parliament.uk	Constituency office
200	5365	Parliamentary office	020 7219 5353	contactholmember@parliament.uk	House of Lords
201	4449	Parliamentary office	\N	anna.turley.mp@parliament.uk	House of Commons
202	4449	Constituency office	01642 929159	\N	The Palace Hub
203	4449	Website	\N	\N	https://www.annaturley.org/
204	4449	Facebook	\N	\N	https://www.facebook.com/Anna4Redcar/
205	4449	LinkedIn	\N	\N	https://www.linkedin.com/in/anna-turley-8b666519b/
206	4449	X (formerly Twitter)	\N	\N	https://x.com/annaturley
207	3972	Parliamentary office	020 7219 5353	contactholmember@parliament.uk	House of Lords
208	3972	X (formerly Twitter)	\N	\N	https://twitter.com/JennyChapman
209	4514	Prime Minister's office	\N	\N	https://contact.no10.gov.uk/
210	4514	Parliamentary office	\N	keir.starmer.mp@parliament.uk	House of Commons
211	4514	Constituency office	\N	keir.starmer.constituency@parliament.uk	Constituency Office
212	4514	Website	\N	\N	http://www.keirstarmer.com/
213	4514	X (formerly Twitter)	\N	\N	https://twitter.com/keir_starmer
214	206	Parliamentary office	\N	david.lammy.mp@parliament.uk 	House of Commons
215	206	Website	\N	\N	http://www.davidlammy.co.uk
216	206	X (formerly Twitter)	\N	\N	https://twitter.com/DavidLammy
217	4268	Parliamentary office	020 7219 7297	steve.reed.mp@parliament.uk	House of Commons
218	4268	Website	\N	\N	http://www.stevereedmp.co.uk/
219	4268	X (formerly Twitter)	\N	\N	https://twitter.com/SteveReedMP
220	4031	Chancellor of the Exchequer's office	\N	public.enquiries@hmtreasury.gov.uk	Ministerial office
221	4031	Parliamentary office	020 7219 7097	rachel.reeves.mp@parliament.uk	House of Commons
222	4031	Constituency office	0113 255 2311	leedswestandpudsey@parliament.uk	Unit 8A
223	4031	Website	\N	\N	https://www.rachelreevesmp.co.uk/
224	4031	X (formerly Twitter)	\N	\N	https://twitter.com/RachelReevesMP
225	4621	Parliamentary office	0207 219 5225	darren.jones.mp@parliament.uk	House of Commons
226	4621	Constituency office	0117 959 6545	\N	Constituency Office
227	4621	Website	\N	\N	http://www.darren-jones.co.uk/
228	4621	Facebook	\N	\N	https://www.facebook.com/darrenjonesmp
229	4621	X (formerly Twitter)	\N	\N	https://twitter.com/darrenpjones
230	420	Parliamentary office	020 7219 5080	coopery@parliament.uk	House of Commons
231	420	Constituency office	01977 553388	coopery@parliament.uk	Queen's Mill
232	420	Website	\N	\N	http://www.yvettecooper.com
233	420	Facebook	\N	\N	https://www.facebook.com/YvetteCooperMP
234	420	X (formerly Twitter)	\N	\N	https://twitter.com/YvetteCooperMP
235	3914	Parliamentary office	0121 661 9440	shabana.mahmood.mp@parliament.uk	House of Commons
236	3914	Website	\N	\N	https://www.shabanamahmood.org
237	3914	X (formerly Twitter)	\N	\N	https://twitter.com/ShabanaMahmood
238	4243	Parliamentary office	0207 219 1082	dan.jarvis.mp@parliament.uk	House of Commons
239	4243	Constituency office	01226 787893	dan.jarvis.mp@parliament.uk	Corporate Mail Room
240	4243	Website	\N	\N	https://www.danjarvis.org
241	4243	Facebook	\N	\N	https://www.facebook.com/DanJarvisMBE
242	4243	Instagram	\N	\N	https://www.instagram.com/danjarvis_mp/
243	4243	X (formerly Twitter)	\N	\N	https://twitter.com/DanJarvisMBE
244	4797	Parliamentary office	020 7219 3000	james.murray.mp@parliament.uk	House of Commons
245	4797	Website	\N	\N	https://www.jamesmurray.org/
246	4797	Facebook	\N	\N	https://www.facebook.com/james4ealing
247	4797	X (formerly Twitter)	\N	\N	https://twitter.com/jamesmurray_ldn
248	4046	Parliamentary office	020 7219 7087	bridget.phillipson.mp@parliament.uk	House of Commons
249	4046	Constituency office	0191 584 4317	\N	106 Newbottle Street
250	4046	Website	\N	\N	http://www.BridgetPhillipson.com
251	4046	Facebook	\N	\N	https://www.facebook.com/bridgetphillipson
252	4046	X (formerly Twitter)	\N	\N	https://twitter.com/bphillipsonMP
253	1510	Parliamentary office	020 7219 7318	ed.miliband.mp@parliament.uk	House of Commons
254	1510	Constituency office	01302875462	\N	Constituency office
255	1510	Facebook	\N	\N	https://www.facebook.com/edmiliband
256	1510	X (formerly Twitter)	\N	\N	https://twitter.com/Ed_Miliband
257	1587	Parliamentary office	020 7219 4036	mcfaddenp@parliament.uk	House of Commons
258	1587	Constituency office	01902 405762		Crescent House
259	1587	Website	\N	\N	http://www.patmcfadden.com
260	1587	X (formerly Twitter)	\N	\N	https://twitter.com/patmcfaddenmp
261	4505	Parliamentary office	020 7219 1897	peter.kyle.mp@parliament.uk	House of Commons
262	4505	Constituency office	01273 933 380	hove.portslade@parliament.uk	99 Church Road
263	4505	Website	\N	\N	http://www.peterkyle.co.uk/
264	4505	Facebook	\N	\N	https://www.facebook.com/hoveandportslade
265	4505	X (formerly Twitter)	\N	\N	https://twitter.com/peterkyle
266	4026	Parliamentary office	020 7219 3000	liz.kendall.mp@parliament.uk	House of Commons
267	4026	Government department	\N	correspondence@dsit.gov.uk	Department for Science, Innovation and Technology
268	4026	Website	\N	\N	https://www.lizkendall.org
269	4026	X (formerly Twitter)	\N	\N	https://twitter.com/leicesterliz
270	4082	Parliamentary office	020 7219 3000	lisa.nandy.mp@parliament.uk	House of Commons
271	4082	Constituency office	01942 242 047	\N	2nd Floor
272	4082	Website	\N	\N	https://lisanandy.laboursites.org
273	4082	X (formerly Twitter)	\N	\N	https://twitter.com/lisanandy
274	4077	Parliamentary office	020 7219 3000	emma.reynolds.mp@parliament.uk	House of Commons
275	4077	Website	\N	\N	www.emmaforwycombe.org.uk
276	4077	X (formerly Twitter)	\N	\N	https://x.com/emmaforwycombe
277	4038	Parliamentary office	\N	heidi.alexander.mp@parliament.uk	House of Commons
278	4038	Website	\N	\N	https://www.heidialexander.org.uk
279	4038	Facebook	\N	\N	https://facebook.com/heidialexanderswindon
280	4038	Instagram	\N	\N	https://instagram.com/heidi_labour
281	4038	X (formerly Twitter)	\N	\N	https://twitter.com/heidi_labour
282	413	Parliamentary office	020 7219 5770	bennh@parliament.uk	House of Commons
283	413	Constituency office	0113 244 1097	boxj@parliament.uk	Suite 7
284	413	Website	\N	\N	http://www.hilarybennmp.com/
285	413	X (formerly Twitter)	\N	\N	https://twitter.com/hilarybennmp
286	632	Parliamentary office	\N	douglas.alexander.mp@parliament.uk	House of Commons
287	632	Website	\N	\N	https://douglasalexandermp.com
288	632	Facebook	\N	\N	https://www.facebook.com/douglas4eastlothian
289	632	X (formerly Twitter)	\N	\N	https://x.com/D_G_Alexander
290	4425	Parliamentary office	020 7219 8290	jo.stevens.mp@parliament.uk	House of Commons
291	4425	Constituency office	02921 329736	\N	116 Albany Road
292	4425	Website	\N	\N	http://www.jostevens.co.uk/
293	4425	X (formerly Twitter)	\N	\N	https://twitter.com/jostevenslabour
294	4170	Parliamentary office	020 7219 5353	contactholmember@parliament.uk 	House of Lords
295	529	Parliamentary office	020 7219 3000	alan.campbell.mp@parliament.uk	House of Commons
296	529	Constituency office	0191 257 1927	\N	Suite 1:11
297	529	Website	\N	\N	http://www.alancampbellmp.co.uk
298	529	X (formerly Twitter)	\N	\N	https://twitter.com/alancampbellmp
299	4119	Parliamentary office	\N	jonathan.reynolds.mp@parliament.uk	House of Commons
300	4119	Constituency office	0161 367 8077		Hyde Town Hall
301	4119	Website	\N	\N	http://www.jonathanreynolds.org.uk
302	4119	X (formerly Twitter)	\N	\N	https://twitter.com/jreynoldsMP
303	5333	Parliamentary office	0207 219 7605	lucy.rigby.mp@parliament.uk	House of Commons
304	5333	Constituency office	01604 915131	lucy.rigby.casework@parliament.uk	Constituency office
305	5365	Parliamentary office	020 7219 5353	contactholmember@parliament.uk	House of Lords
306	4449	Parliamentary office	\N	anna.turley.mp@parliament.uk	House of Commons
307	4449	Constituency office	01642 929159	\N	The Palace Hub
308	4449	Website	\N	\N	https://www.annaturley.org/
309	4449	Facebook	\N	\N	https://www.facebook.com/Anna4Redcar/
310	4449	LinkedIn	\N	\N	https://www.linkedin.com/in/anna-turley-8b666519b/
311	4449	X (formerly Twitter)	\N	\N	https://x.com/annaturley
312	3972	Parliamentary office	020 7219 5353	contactholmember@parliament.uk	House of Lords
313	3972	X (formerly Twitter)	\N	\N	https://twitter.com/JennyChapman
314	4514	Prime Minister's office	\N	\N	https://contact.no10.gov.uk/
315	4514	Parliamentary office	\N	keir.starmer.mp@parliament.uk	House of Commons
316	4514	Constituency office	\N	keir.starmer.constituency@parliament.uk	Constituency Office
317	4514	Website	\N	\N	http://www.keirstarmer.com/
318	4514	X (formerly Twitter)	\N	\N	https://twitter.com/keir_starmer
319	206	Parliamentary office	\N	david.lammy.mp@parliament.uk 	House of Commons
320	206	Website	\N	\N	http://www.davidlammy.co.uk
321	206	X (formerly Twitter)	\N	\N	https://twitter.com/DavidLammy
322	4268	Parliamentary office	020 7219 7297	steve.reed.mp@parliament.uk	House of Commons
323	4268	Website	\N	\N	http://www.stevereedmp.co.uk/
324	4268	X (formerly Twitter)	\N	\N	https://twitter.com/SteveReedMP
325	4031	Chancellor of the Exchequer's office	\N	public.enquiries@hmtreasury.gov.uk	Ministerial office
326	4031	Parliamentary office	020 7219 7097	rachel.reeves.mp@parliament.uk	House of Commons
327	4031	Constituency office	0113 255 2311	leedswestandpudsey@parliament.uk	Unit 8A
328	4031	Website	\N	\N	https://www.rachelreevesmp.co.uk/
329	4031	X (formerly Twitter)	\N	\N	https://twitter.com/RachelReevesMP
330	4621	Parliamentary office	0207 219 5225	darren.jones.mp@parliament.uk	House of Commons
331	4621	Constituency office	0117 959 6545	\N	Constituency Office
332	4621	Website	\N	\N	http://www.darren-jones.co.uk/
333	4621	Facebook	\N	\N	https://www.facebook.com/darrenjonesmp
334	4621	X (formerly Twitter)	\N	\N	https://twitter.com/darrenpjones
335	420	Parliamentary office	020 7219 5080	coopery@parliament.uk	House of Commons
336	420	Constituency office	01977 553388	coopery@parliament.uk	Queen's Mill
337	420	Website	\N	\N	http://www.yvettecooper.com
338	420	Facebook	\N	\N	https://www.facebook.com/YvetteCooperMP
339	420	X (formerly Twitter)	\N	\N	https://twitter.com/YvetteCooperMP
340	3914	Parliamentary office	0121 661 9440	shabana.mahmood.mp@parliament.uk	House of Commons
341	3914	Website	\N	\N	https://www.shabanamahmood.org
342	3914	X (formerly Twitter)	\N	\N	https://twitter.com/ShabanaMahmood
343	4243	Parliamentary office	0207 219 1082	dan.jarvis.mp@parliament.uk	House of Commons
344	4243	Constituency office	01226 787893	dan.jarvis.mp@parliament.uk	Corporate Mail Room
345	4243	Website	\N	\N	https://www.danjarvis.org
346	4243	Facebook	\N	\N	https://www.facebook.com/DanJarvisMBE
347	4243	Instagram	\N	\N	https://www.instagram.com/danjarvis_mp/
348	4243	X (formerly Twitter)	\N	\N	https://twitter.com/DanJarvisMBE
349	4797	Parliamentary office	020 7219 3000	james.murray.mp@parliament.uk	House of Commons
350	4797	Website	\N	\N	https://www.jamesmurray.org/
351	4797	Facebook	\N	\N	https://www.facebook.com/james4ealing
352	4797	X (formerly Twitter)	\N	\N	https://twitter.com/jamesmurray_ldn
353	4046	Parliamentary office	020 7219 7087	bridget.phillipson.mp@parliament.uk	House of Commons
354	4046	Constituency office	0191 584 4317	\N	106 Newbottle Street
355	4046	Website	\N	\N	http://www.BridgetPhillipson.com
356	4046	Facebook	\N	\N	https://www.facebook.com/bridgetphillipson
357	4046	X (formerly Twitter)	\N	\N	https://twitter.com/bphillipsonMP
358	1510	Parliamentary office	020 7219 7318	ed.miliband.mp@parliament.uk	House of Commons
359	1510	Constituency office	01302875462	\N	Constituency office
360	1510	Facebook	\N	\N	https://www.facebook.com/edmiliband
361	1510	X (formerly Twitter)	\N	\N	https://twitter.com/Ed_Miliband
362	1587	Parliamentary office	020 7219 4036	mcfaddenp@parliament.uk	House of Commons
363	1587	Constituency office	01902 405762		Crescent House
364	1587	Website	\N	\N	http://www.patmcfadden.com
365	1587	X (formerly Twitter)	\N	\N	https://twitter.com/patmcfaddenmp
366	4505	Parliamentary office	020 7219 1897	peter.kyle.mp@parliament.uk	House of Commons
367	4505	Constituency office	01273 933 380	hove.portslade@parliament.uk	99 Church Road
368	4505	Website	\N	\N	http://www.peterkyle.co.uk/
369	4505	Facebook	\N	\N	https://www.facebook.com/hoveandportslade
370	4505	X (formerly Twitter)	\N	\N	https://twitter.com/peterkyle
371	4026	Parliamentary office	020 7219 3000	liz.kendall.mp@parliament.uk	House of Commons
372	4026	Government department	\N	correspondence@dsit.gov.uk	Department for Science, Innovation and Technology
373	4026	Website	\N	\N	https://www.lizkendall.org
374	4026	X (formerly Twitter)	\N	\N	https://twitter.com/leicesterliz
375	4082	Parliamentary office	020 7219 3000	lisa.nandy.mp@parliament.uk	House of Commons
376	4082	Constituency office	01942 242 047	\N	2nd Floor
377	4082	Website	\N	\N	https://lisanandy.laboursites.org
378	4082	X (formerly Twitter)	\N	\N	https://twitter.com/lisanandy
379	4077	Parliamentary office	020 7219 3000	emma.reynolds.mp@parliament.uk	House of Commons
380	4077	Website	\N	\N	www.emmaforwycombe.org.uk
381	4077	X (formerly Twitter)	\N	\N	https://x.com/emmaforwycombe
382	4038	Parliamentary office	\N	heidi.alexander.mp@parliament.uk	House of Commons
383	4038	Website	\N	\N	https://www.heidialexander.org.uk
384	4038	Facebook	\N	\N	https://facebook.com/heidialexanderswindon
385	4038	Instagram	\N	\N	https://instagram.com/heidi_labour
386	4038	X (formerly Twitter)	\N	\N	https://twitter.com/heidi_labour
387	413	Parliamentary office	020 7219 5770	bennh@parliament.uk	House of Commons
388	413	Constituency office	0113 244 1097	boxj@parliament.uk	Suite 7
389	413	Website	\N	\N	http://www.hilarybennmp.com/
390	413	X (formerly Twitter)	\N	\N	https://twitter.com/hilarybennmp
391	632	Parliamentary office	\N	douglas.alexander.mp@parliament.uk	House of Commons
392	632	Website	\N	\N	https://douglasalexandermp.com
393	632	Facebook	\N	\N	https://www.facebook.com/douglas4eastlothian
394	632	X (formerly Twitter)	\N	\N	https://x.com/D_G_Alexander
395	4425	Parliamentary office	020 7219 8290	jo.stevens.mp@parliament.uk	House of Commons
396	4425	Constituency office	02921 329736	\N	116 Albany Road
397	4425	Website	\N	\N	http://www.jostevens.co.uk/
398	4425	X (formerly Twitter)	\N	\N	https://twitter.com/jostevenslabour
399	4170	Parliamentary office	020 7219 5353	contactholmember@parliament.uk 	House of Lords
400	529	Parliamentary office	020 7219 3000	alan.campbell.mp@parliament.uk	House of Commons
401	529	Constituency office	0191 257 1927	\N	Suite 1:11
402	529	Website	\N	\N	http://www.alancampbellmp.co.uk
403	529	X (formerly Twitter)	\N	\N	https://twitter.com/alancampbellmp
404	4119	Parliamentary office	\N	jonathan.reynolds.mp@parliament.uk	House of Commons
405	4119	Constituency office	0161 367 8077		Hyde Town Hall
406	4119	Website	\N	\N	http://www.jonathanreynolds.org.uk
407	4119	X (formerly Twitter)	\N	\N	https://twitter.com/jreynoldsMP
408	5333	Parliamentary office	0207 219 7605	lucy.rigby.mp@parliament.uk	House of Commons
409	5333	Constituency office	01604 915131	lucy.rigby.casework@parliament.uk	Constituency office
410	5365	Parliamentary office	020 7219 5353	contactholmember@parliament.uk	House of Lords
411	4449	Parliamentary office	\N	anna.turley.mp@parliament.uk	House of Commons
412	4449	Constituency office	01642 929159	\N	The Palace Hub
413	4449	Website	\N	\N	https://www.annaturley.org/
414	4449	Facebook	\N	\N	https://www.facebook.com/Anna4Redcar/
415	4449	LinkedIn	\N	\N	https://www.linkedin.com/in/anna-turley-8b666519b/
416	4449	X (formerly Twitter)	\N	\N	https://x.com/annaturley
417	3972	Parliamentary office	020 7219 5353	contactholmember@parliament.uk	House of Lords
418	3972	X (formerly Twitter)	\N	\N	https://twitter.com/JennyChapman
\.


--
-- TOC entry 3846 (class 0 OID 16616)
-- Dependencies: 219
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.members (member_id, name_display_as, name_full_title, gender, latest_party) FROM stdin;
4504	Wes Streeting	Rt Hon Wes Streeting MP	M	Labour
4514	Sir Keir Starmer	Rt Hon Sir Keir Starmer MP	M	Labour
4268	Steve Reed	Rt Hon Steve Reed MP	M	Labour (Co-op)
400	John Healey	Rt Hon John Healey MP	M	Labour
4031	Rachel Reeves	Rt Hon Rachel Reeves MP	F	Labour
420	Yvette Cooper	Rt Hon Yvette Cooper MP	F	Labour
3914	Shabana Mahmood	Rt Hon Shabana Mahmood KC MP	F	Labour
4243	Dan Jarvis	Rt Hon Dan Jarvis MP	M	Labour
206	Mr David Lammy	Rt Hon David Lammy MP	M	Labour
4797	James Murray	Rt Hon James Murray MP	M	Labour (Co-op)
4046	Bridget Phillipson	Rt Hon Bridget Phillipson MP	F	Labour
1510	Ed Miliband	Rt Hon Ed Miliband MP	M	Labour
1587	Pat McFadden	Rt Hon Pat McFadden MP	M	Labour
4505	Peter Kyle	Rt Hon Peter Kyle MP	M	Labour
4026	Liz Kendall	Rt Hon Liz Kendall MP	F	Labour
4082	Lisa Nandy	Rt Hon Lisa Nandy MP	F	Labour
4077	Emma Reynolds	Rt Hon Emma Reynolds MP	F	Labour
4038	Heidi Alexander	Rt Hon Heidi Alexander MP	F	Labour
413	Hilary Benn	Rt Hon Hilary Benn MP	M	Labour
632	Mr Douglas Alexander	Rt Hon Douglas Alexander MP	M	Labour (Co-op)
4425	Jo Stevens	Rt Hon Jo Stevens MP	F	Labour
4170	Baroness Smith of Basildon	The Rt Hon. the Baroness Smith of Basildon	F	Labour
529	Sir Alan Campbell	Rt Hon Sir Alan Campbell MP	M	Labour
4119	Jonathan Reynolds	Rt Hon Jonathan Reynolds MP	M	Labour (Co-op)
4621	Darren Jones	Rt Hon Darren Jones MP	M	Labour
5333	Lucy  Rigby	Rt Hon Lucy  Rigby KC MP	F	Labour
5365	Lord Hermer	The Rt Hon. the Lord Hermer KC	M	Labour
4449	Anna Turley	Rt Hon Anna Turley MP	F	Labour (Co-op)
3972	Baroness Chapman of Darlington	The Rt Hon. the Baroness Chapman of Darlington	F	Labour
\.


--
-- TOC entry 3848 (class 0 OID 16632)
-- Dependencies: 221
-- Data for Name: post_holders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.post_holders (post_id, member_id, start_date, end_date, laying_minister_name) FROM stdin;
1267	4514	2024-07-05	\N	The Prime Minister
1244	206	2025-09-05	\N	Secretary David Lammy
1213	4268	2025-09-05	\N	Secretary Steve Reed
34	4031	2024-07-05	\N	The Chancellor of the Exchequer
1306	4621	2025-09-06	\N	Darren Jones
1189	4621	2025-09-05	\N	Darren Jones
1245	420	2025-09-05	\N	Secretary Yvette Cooper
74	3914	2025-09-05	\N	Secretary Shabana Mahmood
691	400	2024-07-05	\N	Secretary John Healey
718	206	2025-09-05	\N	Secretary David Lammy
1210	4504	2024-07-05	\N	Secretary Wes Streeting
829	4046	2024-07-05	\N	Secretary Bridget Phillipson
1299	4046	2024-07-08	\N	Secretary Bridget Philipson
1274	1510	2024-07-05	\N	Secretary Ed Miliband
744	1587	2025-09-05	\N	Secretary Pat McFadden
1286	4505	2025-09-05	\N	Secretary Peter Kyle
1288	4505	2025-09-05	\N	Secretary Peter Kyle
1275	4026	2025-09-05	\N	Secretary Liz Kendall
689	4082	2024-07-05	\N	Secretary Lisa Nandy
704	4077	2025-09-05	\N	Secretary Emma Reynolds
739	4038	2024-11-29	\N	Secretary Heidi Alexander
721	413	2024-07-05	\N	Secretary Hilary Benn
726	632	2025-09-05	\N	Secretary Douglas Alexander
743	4425	2024-07-05	\N	Secretary Jo Stevens
1142	529	2025-09-05	\N	Sir Alan Campbell
1137	4170	2024-07-05	\N	The Lord Privy Seal
523	4119	2025-09-05	\N	\N
1307	4621	2025-09-01	\N	\N
36	4797	2025-09-01	\N	James Murray
22	5365	2024-07-05	\N	Lord Hermer
1108	4449	2025-09-06	\N	Anna Turley
1302	3972	2025-02-28	\N	Baroness Chapman of Darlington
1210	4797	2026-05-14	\N	Secretary James Murray
36	5333	2026-05-14	\N	Lucy Rigby
691	4243	2026-06-11	\N	Secretary Dan Jarvis
\.


--
-- TOC entry 3857 (class 0 OID 0)
-- Dependencies: 222
-- Name: member_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.member_contacts_id_seq', 418, true);


--
-- TOC entry 3690 (class 2606 OID 16631)
-- Name: government_posts government_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.government_posts
    ADD CONSTRAINT government_posts_pkey PRIMARY KEY (post_id);


--
-- TOC entry 3694 (class 2606 OID 16661)
-- Name: member_contacts member_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member_contacts
    ADD CONSTRAINT member_contacts_pkey PRIMARY KEY (id);


--
-- TOC entry 3688 (class 2606 OID 16623)
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (member_id);


--
-- TOC entry 3692 (class 2606 OID 16641)
-- Name: post_holders post_holders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_holders
    ADD CONSTRAINT post_holders_pkey PRIMARY KEY (post_id, member_id, start_date);


--
-- TOC entry 3697 (class 2606 OID 16662)
-- Name: member_contacts member_contacts_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member_contacts
    ADD CONSTRAINT member_contacts_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id);


--
-- TOC entry 3695 (class 2606 OID 16647)
-- Name: post_holders post_holders_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_holders
    ADD CONSTRAINT post_holders_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id);


--
-- TOC entry 3696 (class 2606 OID 16642)
-- Name: post_holders post_holders_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_holders
    ADD CONSTRAINT post_holders_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.government_posts(post_id);


-- Completed on 2026-10-23 15:35:55 BST

--
-- PostgreSQL database dump complete
--

\unrestrict pYkPoI7U7lalnMsTUS4uW4n6b4scdNeVKmYhpzUhTri0EirnS2RyzCT8pcu6MIT

