--
-- PostgreSQL database dump
--

\restrict Gk86WA1PabrFL0YRfalAtRMnahYYkE5MCiPHJq3yKvaqlmeZiZKJcw2eNpQIUgu

-- Dumped from database version 18.6 (Postgres.app)
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-23 12:35:42 BST

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

--
-- TOC entry 2 (class 3079 OID 16493)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 303 (class 1255 OID 16945)
-- Name: get_contact_latest_activity(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_contact_latest_activity(p_contact_id uuid) RETURNS TABLE(source text, value text, created_at timestamp without time zone)
    LANGUAGE sql STABLE
    AS $$
    SELECT *
    FROM (
        SELECT 'Notes' AS source, comment AS value, created_at
        FROM public.contact_anex_notes
        WHERE contact_id = p_contact_id
        ORDER BY created_at DESC
        LIMIT 1
    ) t1

    UNION ALL

    SELECT *
    FROM (
        SELECT 'Documents', filename, created_at
        FROM public.contact_documents
        WHERE contact_id = p_contact_id
        ORDER BY created_at DESC
        LIMIT 1
    ) t2

    UNION ALL

    SELECT *
    FROM (
        SELECT 'Links', label, created_at
        FROM public.contact_links
        WHERE contact_id = p_contact_id
        ORDER BY created_at DESC
        LIMIT 1
    ) t3

    UNION ALL

    SELECT *
    FROM (
        SELECT 'Meetings', concat(meeting_date::text, ' ', title), created_at
        FROM public.contact_meetings
        WHERE contact_id = p_contact_id
        ORDER BY created_at DESC
        LIMIT 1
    ) t4

    UNION ALL

    SELECT *
    FROM (
        SELECT 'PoC', details, created_at
        FROM public.contact_poc
        WHERE contact_id = p_contact_id
        ORDER BY created_at DESC
        LIMIT 1
    ) t5

    ORDER BY created_at DESC;
$$;


--
-- TOC entry 290 (class 1255 OID 17319)
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$;


--
-- TOC entry 287 (class 1255 OID 17193)
-- Name: update_meeting_groups_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_meeting_groups_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


--
-- TOC entry 286 (class 1255 OID 17133)
-- Name: update_minister_meetings_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_minister_meetings_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


--
-- TOC entry 291 (class 1255 OID 16825)
-- Name: update_teams_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_teams_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 16964)
-- Name: areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.areas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    area character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 17034)
-- Name: communities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.communities (
    community_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    created_by character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 17052)
-- Name: community_contact_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_contact_tags (
    tag_id uuid DEFAULT gen_random_uuid() NOT NULL,
    community_id uuid NOT NULL,
    contact_id uuid NOT NULL,
    tagged_by character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 17295)
-- Name: community_headlines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_headlines (
    headline_id uuid DEFAULT gen_random_uuid() NOT NULL,
    community_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    body text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 242 (class 1259 OID 17195)
-- Name: community_meeting_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_meeting_tags (
    tag_id uuid DEFAULT gen_random_uuid() NOT NULL,
    community_id uuid NOT NULL,
    meeting_id uuid NOT NULL,
    tagged_by character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 17072)
-- Name: community_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_members (
    member_id uuid DEFAULT gen_random_uuid() NOT NULL,
    community_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    added_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 17272)
-- Name: community_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_notes (
    note_id uuid DEFAULT gen_random_uuid() NOT NULL,
    community_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 17253)
-- Name: community_poc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_poc (
    poc_id uuid DEFAULT gen_random_uuid() NOT NULL,
    community_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16769)
-- Name: contact_anex_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_anex_notes (
    note_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    outcome_id integer,
    sub_outcome_id integer,
    CONSTRAINT chk_contact_anex_notes_sub_needs_outcome CHECK (((sub_outcome_id IS NULL) OR (outcome_id IS NOT NULL)))
);


--
-- TOC entry 231 (class 1259 OID 16946)
-- Name: contact_areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_areas (
    area_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    area character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16737)
-- Name: contact_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_documents (
    document_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    mime_type character varying(127) NOT NULL,
    file_size integer NOT NULL,
    file_data bytea NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    category character varying(100) DEFAULT ''::character varying NOT NULL,
    outcome_id integer,
    sub_outcome_id integer,
    CONSTRAINT chk_contact_documents_sub_needs_outcome CHECK (((sub_outcome_id IS NULL) OR (outcome_id IS NOT NULL)))
);


--
-- TOC entry 233 (class 1259 OID 16976)
-- Name: contact_highlight_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_highlight_notes (
    note_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16667)
-- Name: contact_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_links (
    link_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    reference character varying(255) NOT NULL,
    label character varying(255) DEFAULT ''::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    outcome_id integer,
    sub_outcome_id integer,
    CONSTRAINT chk_contact_links_sub_needs_outcome CHECK (((sub_outcome_id IS NULL) OR (outcome_id IS NOT NULL)))
);


--
-- TOC entry 225 (class 1259 OID 16720)
-- Name: contact_meeting_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_meeting_links (
    meeting_link_id uuid DEFAULT gen_random_uuid() NOT NULL,
    meeting_id uuid NOT NULL,
    reference character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 16687)
-- Name: contact_meetings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_meetings (
    meeting_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    meeting_date date NOT NULL,
    notes text DEFAULT ''::text NOT NULL,
    score1 smallint DEFAULT 0 NOT NULL,
    score2 smallint DEFAULT 0 NOT NULL,
    score3 smallint DEFAULT 0 NOT NULL,
    score4 smallint DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    outcome_id integer,
    sub_outcome_id integer,
    assess_purposes text[] DEFAULT '{}'::text[] NOT NULL,
    assess_outcome character varying(50),
    assess_significant text[] DEFAULT '{}'::text[] NOT NULL,
    CONSTRAINT chk_assess_max_purposes CHECK ((cardinality(assess_purposes) <= 2)),
    CONSTRAINT chk_assess_outcome_needs_purpose CHECK (((assess_outcome IS NULL) OR (cardinality(assess_purposes) > 0))),
    CONSTRAINT chk_assess_significant_needs_outcome CHECK (((cardinality(assess_significant) = 0) OR (assess_outcome IS NOT NULL))),
    CONSTRAINT chk_contact_meetings_sub_needs_outcome CHECK (((sub_outcome_id IS NULL) OR (outcome_id IS NOT NULL))),
    CONSTRAINT contact_meetings_score1_check CHECK (((score1 >= 0) AND (score1 <= 5))),
    CONSTRAINT contact_meetings_score2_check CHECK (((score2 >= 0) AND (score2 <= 5))),
    CONSTRAINT contact_meetings_score3_check CHECK (((score3 >= 0) AND (score3 <= 5))),
    CONSTRAINT contact_meetings_score4_check CHECK (((score4 >= 0) AND (score4 <= 5)))
);


--
-- TOC entry 220 (class 1259 OID 16531)
-- Name: contact_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_notes (
    note_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 16547)
-- Name: contact_poc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_poc (
    poc_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    details character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 16598)
-- Name: contact_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_tag (
    tag_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    tag character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 240 (class 1259 OID 17151)
-- Name: meeting_group_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_group_members (
    group_member_id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    role character varying(10) DEFAULT 'viewer'::character varying NOT NULL,
    added_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT meeting_group_members_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'viewer'::character varying])::text[])))
);


--
-- TOC entry 241 (class 1259 OID 17174)
-- Name: meeting_group_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_group_tags (
    tag_id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_id uuid NOT NULL,
    meeting_id uuid NOT NULL,
    tagged_by character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 239 (class 1259 OID 17135)
-- Name: meeting_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_groups (
    group_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    created_by character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    community_id uuid NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 17112)
-- Name: minister_meetings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.minister_meetings (
    meeting_id uuid DEFAULT gen_random_uuid() NOT NULL,
    minister_id integer NOT NULL,
    username character varying(255) NOT NULL,
    meeting_date date NOT NULL,
    title character varying(255) NOT NULL,
    comments text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 237 (class 1259 OID 17092)
-- Name: ministers_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ministers_notes (
    note_id uuid DEFAULT gen_random_uuid() NOT NULL,
    member_id integer CONSTRAINT ministers_notes_id_not_null NOT NULL,
    username character varying(255) NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 248 (class 1259 OID 17335)
-- Name: outcomes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.outcomes (
    outcome_id integer NOT NULL,
    code character varying(50) NOT NULL,
    label character varying(255) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 17334)
-- Name: outcomes_outcome_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.outcomes_outcome_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 247
-- Name: outcomes_outcome_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.outcomes_outcome_id_seq OWNED BY public.outcomes.outcome_id;


--
-- TOC entry 250 (class 1259 OID 17351)
-- Name: sub_outcomes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sub_outcomes (
    sub_outcome_id integer NOT NULL,
    outcome_id integer NOT NULL,
    code character varying(50) NOT NULL,
    label character varying(255) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- TOC entry 249 (class 1259 OID 17350)
-- Name: sub_outcomes_sub_outcome_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sub_outcomes_sub_outcome_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 249
-- Name: sub_outcomes_sub_outcome_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sub_outcomes_sub_outcome_id_seq OWNED BY public.sub_outcomes.sub_outcome_id;


--
-- TOC entry 230 (class 1259 OID 16929)
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tag character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 16785)
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    team_id uuid DEFAULT gen_random_uuid() NOT NULL,
    team_name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    description text,
    intranet_url character varying(500) DEFAULT ''::character varying NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- TOC entry 246 (class 1259 OID 17322)
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_profiles (
    username character varying(255) NOT NULL,
    about_me text DEFAULT ''::text NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 16797)
-- Name: user_teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_teams (
    user_team_id uuid DEFAULT gen_random_uuid() NOT NULL,
    username character varying(255) NOT NULL,
    team_id uuid NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 3908 (class 2604 OID 17338)
-- Name: outcomes outcome_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outcomes ALTER COLUMN outcome_id SET DEFAULT nextval('public.outcomes_outcome_id_seq'::regclass);


--
-- TOC entry 3911 (class 2604 OID 17354)
-- Name: sub_outcomes sub_outcome_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_outcomes ALTER COLUMN sub_outcome_id SET DEFAULT nextval('public.sub_outcomes_sub_outcome_id_seq'::regclass);


--
-- TOC entry 3979 (class 2606 OID 16975)
-- Name: areas areas_area_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_area_key UNIQUE (area);


--
-- TOC entry 3981 (class 2606 OID 16973)
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- TOC entry 3987 (class 2606 OID 17048)
-- Name: communities communities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_pkey PRIMARY KEY (community_id);


--
-- TOC entry 3990 (class 2606 OID 17063)
-- Name: community_contact_tags community_contact_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_contact_tags
    ADD CONSTRAINT community_contact_tags_pkey PRIMARY KEY (tag_id);


--
-- TOC entry 4038 (class 2606 OID 17312)
-- Name: community_headlines community_headlines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_headlines
    ADD CONSTRAINT community_headlines_pkey PRIMARY KEY (headline_id);


--
-- TOC entry 4023 (class 2606 OID 17206)
-- Name: community_meeting_tags community_meeting_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_meeting_tags
    ADD CONSTRAINT community_meeting_tags_pkey PRIMARY KEY (tag_id);


--
-- TOC entry 3995 (class 2606 OID 17082)
-- Name: community_members community_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_members
    ADD CONSTRAINT community_members_pkey PRIMARY KEY (member_id);


--
-- TOC entry 4034 (class 2606 OID 17287)
-- Name: community_notes community_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_notes
    ADD CONSTRAINT community_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 4029 (class 2606 OID 17263)
-- Name: community_poc community_poc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_poc
    ADD CONSTRAINT community_poc_pkey PRIMARY KEY (poc_id);


--
-- TOC entry 3956 (class 2606 OID 16782)
-- Name: contact_anex_notes contact_anex_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_anex_notes
    ADD CONSTRAINT contact_anex_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 3974 (class 2606 OID 16959)
-- Name: contact_areas contact_area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_areas
    ADD CONSTRAINT contact_area_pkey PRIMARY KEY (area_id);


--
-- TOC entry 3952 (class 2606 OID 16753)
-- Name: contact_documents contact_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_documents
    ADD CONSTRAINT contact_documents_pkey PRIMARY KEY (document_id);


--
-- TOC entry 3983 (class 2606 OID 16989)
-- Name: contact_highlight_notes contact_highlight_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_highlight_notes
    ADD CONSTRAINT contact_highlight_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 3940 (class 2606 OID 16684)
-- Name: contact_links contact_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_links
    ADD CONSTRAINT contact_links_pkey PRIMARY KEY (link_id);


--
-- TOC entry 3949 (class 2606 OID 16730)
-- Name: contact_meeting_links contact_meeting_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_meeting_links
    ADD CONSTRAINT contact_meeting_links_pkey PRIMARY KEY (meeting_link_id);


--
-- TOC entry 3944 (class 2606 OID 16716)
-- Name: contact_meetings contact_meetings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_meetings
    ADD CONSTRAINT contact_meetings_pkey PRIMARY KEY (meeting_id);


--
-- TOC entry 4001 (class 2606 OID 17105)
-- Name: ministers_notes contact_ministers_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ministers_notes
    ADD CONSTRAINT contact_ministers_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 3927 (class 2606 OID 16544)
-- Name: contact_notes contact_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_notes
    ADD CONSTRAINT contact_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 3931 (class 2606 OID 16560)
-- Name: contact_poc contact_poc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_poc
    ADD CONSTRAINT contact_poc_pkey PRIMARY KEY (poc_id);


--
-- TOC entry 3935 (class 2606 OID 16611)
-- Name: contact_tag contact_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_tag
    ADD CONSTRAINT contact_tag_pkey PRIMARY KEY (tag_id);


--
-- TOC entry 4015 (class 2606 OID 17164)
-- Name: meeting_group_members meeting_group_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_group_members
    ADD CONSTRAINT meeting_group_members_pkey PRIMARY KEY (group_member_id);


--
-- TOC entry 4021 (class 2606 OID 17185)
-- Name: meeting_group_tags meeting_group_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_group_tags
    ADD CONSTRAINT meeting_group_tags_pkey PRIMARY KEY (tag_id);


--
-- TOC entry 4010 (class 2606 OID 17149)
-- Name: meeting_groups meeting_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_groups
    ADD CONSTRAINT meeting_groups_pkey PRIMARY KEY (group_id);


--
-- TOC entry 4007 (class 2606 OID 17130)
-- Name: minister_meetings minister_meetings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.minister_meetings
    ADD CONSTRAINT minister_meetings_pkey PRIMARY KEY (meeting_id);


--
-- TOC entry 4043 (class 2606 OID 17349)
-- Name: outcomes outcomes_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outcomes
    ADD CONSTRAINT outcomes_code_key UNIQUE (code);


--
-- TOC entry 4045 (class 2606 OID 17347)
-- Name: outcomes outcomes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outcomes
    ADD CONSTRAINT outcomes_pkey PRIMARY KEY (outcome_id);


--
-- TOC entry 4048 (class 2606 OID 17366)
-- Name: sub_outcomes sub_outcomes_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_outcomes
    ADD CONSTRAINT sub_outcomes_code_key UNIQUE (code);


--
-- TOC entry 4050 (class 2606 OID 17364)
-- Name: sub_outcomes sub_outcomes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_outcomes
    ADD CONSTRAINT sub_outcomes_pkey PRIMARY KEY (sub_outcome_id);


--
-- TOC entry 3970 (class 2606 OID 16938)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 3972 (class 2606 OID 16940)
-- Name: tags tags_tag_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_key UNIQUE (tag);


--
-- TOC entry 3960 (class 2606 OID 16794)
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- TOC entry 3962 (class 2606 OID 16796)
-- Name: teams teams_team_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_team_name_key UNIQUE (team_name);


--
-- TOC entry 4027 (class 2606 OID 17208)
-- Name: community_meeting_tags uq_community_meeting; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_meeting_tags
    ADD CONSTRAINT uq_community_meeting UNIQUE (community_id, meeting_id);


--
-- TOC entry 4036 (class 2606 OID 17289)
-- Name: community_notes uq_community_note_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_notes
    ADD CONSTRAINT uq_community_note_user UNIQUE (community_id, username);


--
-- TOC entry 4032 (class 2606 OID 17265)
-- Name: community_poc uq_community_poc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_poc
    ADD CONSTRAINT uq_community_poc UNIQUE (community_id, username);


--
-- TOC entry 3999 (class 2606 OID 17084)
-- Name: community_members uq_community_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_members
    ADD CONSTRAINT uq_community_user UNIQUE (community_id, username);


--
-- TOC entry 4017 (class 2606 OID 17166)
-- Name: meeting_group_members uq_group_member; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_group_members
    ADD CONSTRAINT uq_group_member UNIQUE (group_id, username);


--
-- TOC entry 4052 (class 2606 OID 17368)
-- Name: sub_outcomes uq_sub_outcome_parent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_outcomes
    ADD CONSTRAINT uq_sub_outcome_parent UNIQUE (sub_outcome_id, outcome_id);


--
-- TOC entry 3966 (class 2606 OID 16811)
-- Name: user_teams uq_user_team; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_teams
    ADD CONSTRAINT uq_user_team UNIQUE (username, team_id);


--
-- TOC entry 4041 (class 2606 OID 17333)
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (username);


--
-- TOC entry 3968 (class 2606 OID 16809)
-- Name: user_teams user_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_teams
    ADD CONSTRAINT user_teams_pkey PRIMARY KEY (user_team_id);


--
-- TOC entry 3957 (class 1259 OID 16783)
-- Name: idx_anex_notes_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_anex_notes_contact_id ON public.contact_anex_notes USING btree (contact_id);


--
-- TOC entry 3958 (class 1259 OID 16784)
-- Name: idx_anex_notes_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_anex_notes_created_at ON public.contact_anex_notes USING btree (created_at DESC);


--
-- TOC entry 3975 (class 1259 OID 16962)
-- Name: idx_areax_area; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_areax_area ON public.contact_areas USING btree (area);


--
-- TOC entry 3976 (class 1259 OID 16960)
-- Name: idx_areax_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_areax_contact_id ON public.contact_areas USING btree (contact_id);


--
-- TOC entry 3977 (class 1259 OID 16961)
-- Name: idx_areax_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_areax_created_at ON public.contact_areas USING btree (created_at DESC);


--
-- TOC entry 4024 (class 1259 OID 17220)
-- Name: idx_cmt_community_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cmt_community_id ON public.community_meeting_tags USING btree (community_id);


--
-- TOC entry 4025 (class 1259 OID 17219)
-- Name: idx_cmt_meeting_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cmt_meeting_id ON public.community_meeting_tags USING btree (meeting_id);


--
-- TOC entry 3988 (class 1259 OID 17049)
-- Name: idx_communities_created_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_communities_created_by ON public.communities USING btree (created_by);


--
-- TOC entry 4039 (class 1259 OID 17318)
-- Name: idx_community_headlines_community; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_community_headlines_community ON public.community_headlines USING btree (community_id, created_at DESC);


--
-- TOC entry 3996 (class 1259 OID 17091)
-- Name: idx_community_members_community_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_community_members_community_id ON public.community_members USING btree (community_id);


--
-- TOC entry 3997 (class 1259 OID 17090)
-- Name: idx_community_members_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_community_members_username ON public.community_members USING btree (username);


--
-- TOC entry 4030 (class 1259 OID 17271)
-- Name: idx_community_poc_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_community_poc_username ON public.community_poc USING btree (username);


--
-- TOC entry 3953 (class 1259 OID 16754)
-- Name: idx_documents_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_contact_id ON public.contact_documents USING btree (contact_id);


--
-- TOC entry 3954 (class 1259 OID 16755)
-- Name: idx_documents_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_created_at ON public.contact_documents USING btree (created_at DESC);


--
-- TOC entry 4012 (class 1259 OID 17173)
-- Name: idx_group_members_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_members_group_id ON public.meeting_group_members USING btree (group_id);


--
-- TOC entry 4013 (class 1259 OID 17172)
-- Name: idx_group_members_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_members_username ON public.meeting_group_members USING btree (username);


--
-- TOC entry 4018 (class 1259 OID 17192)
-- Name: idx_group_tags_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_tags_group_id ON public.meeting_group_tags USING btree (group_id);


--
-- TOC entry 4019 (class 1259 OID 17191)
-- Name: idx_group_tags_meeting_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_tags_meeting_id ON public.meeting_group_tags USING btree (meeting_id);


--
-- TOC entry 3984 (class 1259 OID 16990)
-- Name: idx_highlight_notes_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_highlight_notes_contact_id ON public.contact_highlight_notes USING btree (contact_id);


--
-- TOC entry 3985 (class 1259 OID 16991)
-- Name: idx_highlight_notes_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_highlight_notes_created_at ON public.contact_highlight_notes USING btree (created_at DESC);


--
-- TOC entry 3941 (class 1259 OID 16685)
-- Name: idx_links_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_links_contact_id ON public.contact_links USING btree (contact_id);


--
-- TOC entry 3942 (class 1259 OID 16686)
-- Name: idx_links_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_links_created_at ON public.contact_links USING btree (created_at DESC);


--
-- TOC entry 4008 (class 1259 OID 17150)
-- Name: idx_meeting_groups_created_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_meeting_groups_created_by ON public.meeting_groups USING btree (created_by);


--
-- TOC entry 3950 (class 1259 OID 16736)
-- Name: idx_meeting_links_meeting_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_meeting_links_meeting_id ON public.contact_meeting_links USING btree (meeting_id);


--
-- TOC entry 3945 (class 1259 OID 16717)
-- Name: idx_meetings_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_meetings_contact_id ON public.contact_meetings USING btree (contact_id);


--
-- TOC entry 3946 (class 1259 OID 16718)
-- Name: idx_meetings_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_meetings_created_at ON public.contact_meetings USING btree (created_at DESC);


--
-- TOC entry 3947 (class 1259 OID 16719)
-- Name: idx_meetings_meeting_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_meetings_meeting_date ON public.contact_meetings USING btree (meeting_date DESC);


--
-- TOC entry 4004 (class 1259 OID 17132)
-- Name: idx_minister_meetings_meeting_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_minister_meetings_meeting_date ON public.minister_meetings USING btree (meeting_date DESC);


--
-- TOC entry 4005 (class 1259 OID 17131)
-- Name: idx_minister_meetings_minister_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_minister_meetings_minister_id ON public.minister_meetings USING btree (minister_id);


--
-- TOC entry 4002 (class 1259 OID 17107)
-- Name: idx_ministers_notes_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ministers_notes_created_at ON public.ministers_notes USING btree (created_at DESC);


--
-- TOC entry 4003 (class 1259 OID 17106)
-- Name: idx_ministers_notes_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ministers_notes_id ON public.ministers_notes USING btree (member_id);


--
-- TOC entry 3928 (class 1259 OID 16545)
-- Name: idx_notes_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notes_contact_id ON public.contact_notes USING btree (contact_id);


--
-- TOC entry 3929 (class 1259 OID 16546)
-- Name: idx_notes_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notes_created_at ON public.contact_notes USING btree (created_at DESC);


--
-- TOC entry 3932 (class 1259 OID 16561)
-- Name: idx_poc_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_poc_contact_id ON public.contact_poc USING btree (contact_id);


--
-- TOC entry 3933 (class 1259 OID 16562)
-- Name: idx_poc_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_poc_created_at ON public.contact_poc USING btree (created_at DESC);


--
-- TOC entry 4046 (class 1259 OID 17374)
-- Name: idx_sub_outcomes_outcome; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sub_outcomes_outcome ON public.sub_outcomes USING btree (outcome_id);


--
-- TOC entry 3991 (class 1259 OID 17070)
-- Name: idx_tags_community_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tags_community_id ON public.community_contact_tags USING btree (community_id);


--
-- TOC entry 3992 (class 1259 OID 17069)
-- Name: idx_tags_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tags_contact_id ON public.community_contact_tags USING btree (contact_id);


--
-- TOC entry 3993 (class 1259 OID 17071)
-- Name: idx_tags_tagged_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tags_tagged_by ON public.community_contact_tags USING btree (tagged_by);


--
-- TOC entry 3936 (class 1259 OID 16612)
-- Name: idx_tagx_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tagx_contact_id ON public.contact_tag USING btree (contact_id);


--
-- TOC entry 3937 (class 1259 OID 16613)
-- Name: idx_tagx_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tagx_created_at ON public.contact_tag USING btree (created_at DESC);


--
-- TOC entry 3938 (class 1259 OID 16614)
-- Name: idx_tagx_tag; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tagx_tag ON public.contact_tag USING btree (tag);


--
-- TOC entry 3963 (class 1259 OID 16818)
-- Name: idx_user_teams_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_teams_team_id ON public.user_teams USING btree (team_id);


--
-- TOC entry 3964 (class 1259 OID 16817)
-- Name: idx_user_teams_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_teams_username ON public.user_teams USING btree (username);


--
-- TOC entry 4011 (class 1259 OID 17252)
-- Name: uq_meeting_groups_community; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_meeting_groups_community ON public.meeting_groups USING btree (community_id);


--
-- TOC entry 4076 (class 2620 OID 17194)
-- Name: meeting_groups set_meeting_groups_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_meeting_groups_updated_at BEFORE UPDATE ON public.meeting_groups FOR EACH ROW EXECUTE FUNCTION public.update_meeting_groups_updated_at();


--
-- TOC entry 4075 (class 2620 OID 17134)
-- Name: minister_meetings set_minister_meetings_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_minister_meetings_updated_at BEFORE UPDATE ON public.minister_meetings FOR EACH ROW EXECUTE FUNCTION public.update_minister_meetings_updated_at();


--
-- TOC entry 4074 (class 2620 OID 16826)
-- Name: teams set_teams_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_teams_updated_at BEFORE UPDATE ON public.teams FOR EACH ROW EXECUTE FUNCTION public.update_teams_updated_at();


--
-- TOC entry 4078 (class 2620 OID 17321)
-- Name: community_headlines trg_community_headlines_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_community_headlines_updated BEFORE UPDATE ON public.community_headlines FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 4077 (class 2620 OID 17320)
-- Name: community_notes trg_community_notes_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_community_notes_updated BEFORE UPDATE ON public.community_notes FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 4063 (class 2606 OID 17064)
-- Name: community_contact_tags community_contact_tags_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_contact_tags
    ADD CONSTRAINT community_contact_tags_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.communities(community_id) ON DELETE CASCADE;


--
-- TOC entry 4072 (class 2606 OID 17313)
-- Name: community_headlines community_headlines_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_headlines
    ADD CONSTRAINT community_headlines_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.communities(community_id) ON DELETE CASCADE;


--
-- TOC entry 4068 (class 2606 OID 17209)
-- Name: community_meeting_tags community_meeting_tags_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_meeting_tags
    ADD CONSTRAINT community_meeting_tags_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.communities(community_id) ON DELETE CASCADE;


--
-- TOC entry 4069 (class 2606 OID 17214)
-- Name: community_meeting_tags community_meeting_tags_meeting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_meeting_tags
    ADD CONSTRAINT community_meeting_tags_meeting_id_fkey FOREIGN KEY (meeting_id) REFERENCES public.contact_meetings(meeting_id) ON DELETE CASCADE;


--
-- TOC entry 4064 (class 2606 OID 17085)
-- Name: community_members community_members_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_members
    ADD CONSTRAINT community_members_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.communities(community_id) ON DELETE CASCADE;


--
-- TOC entry 4071 (class 2606 OID 17290)
-- Name: community_notes community_notes_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_notes
    ADD CONSTRAINT community_notes_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.communities(community_id) ON DELETE CASCADE;


--
-- TOC entry 4070 (class 2606 OID 17266)
-- Name: community_poc community_poc_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_poc
    ADD CONSTRAINT community_poc_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.communities(community_id) ON DELETE CASCADE;


--
-- TOC entry 4060 (class 2606 OID 17375)
-- Name: contact_anex_notes contact_anex_notes_outcome_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_anex_notes
    ADD CONSTRAINT contact_anex_notes_outcome_id_fkey FOREIGN KEY (outcome_id) REFERENCES public.outcomes(outcome_id);


--
-- TOC entry 4058 (class 2606 OID 17408)
-- Name: contact_documents contact_documents_outcome_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_documents
    ADD CONSTRAINT contact_documents_outcome_id_fkey FOREIGN KEY (outcome_id) REFERENCES public.outcomes(outcome_id);


--
-- TOC entry 4053 (class 2606 OID 17386)
-- Name: contact_links contact_links_outcome_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_links
    ADD CONSTRAINT contact_links_outcome_id_fkey FOREIGN KEY (outcome_id) REFERENCES public.outcomes(outcome_id);


--
-- TOC entry 4057 (class 2606 OID 16731)
-- Name: contact_meeting_links contact_meeting_links_meeting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_meeting_links
    ADD CONSTRAINT contact_meeting_links_meeting_id_fkey FOREIGN KEY (meeting_id) REFERENCES public.contact_meetings(meeting_id) ON DELETE CASCADE;


--
-- TOC entry 4055 (class 2606 OID 17397)
-- Name: contact_meetings contact_meetings_outcome_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_meetings
    ADD CONSTRAINT contact_meetings_outcome_id_fkey FOREIGN KEY (outcome_id) REFERENCES public.outcomes(outcome_id);


--
-- TOC entry 4061 (class 2606 OID 17381)
-- Name: contact_anex_notes fk_contact_anex_notes_sub_outcome; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_anex_notes
    ADD CONSTRAINT fk_contact_anex_notes_sub_outcome FOREIGN KEY (sub_outcome_id, outcome_id) REFERENCES public.sub_outcomes(sub_outcome_id, outcome_id);


--
-- TOC entry 4059 (class 2606 OID 17414)
-- Name: contact_documents fk_contact_documents_sub_outcome; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_documents
    ADD CONSTRAINT fk_contact_documents_sub_outcome FOREIGN KEY (sub_outcome_id, outcome_id) REFERENCES public.sub_outcomes(sub_outcome_id, outcome_id);


--
-- TOC entry 4054 (class 2606 OID 17392)
-- Name: contact_links fk_contact_links_sub_outcome; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_links
    ADD CONSTRAINT fk_contact_links_sub_outcome FOREIGN KEY (sub_outcome_id, outcome_id) REFERENCES public.sub_outcomes(sub_outcome_id, outcome_id);


--
-- TOC entry 4056 (class 2606 OID 17403)
-- Name: contact_meetings fk_contact_meetings_sub_outcome; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_meetings
    ADD CONSTRAINT fk_contact_meetings_sub_outcome FOREIGN KEY (sub_outcome_id, outcome_id) REFERENCES public.sub_outcomes(sub_outcome_id, outcome_id);


--
-- TOC entry 4066 (class 2606 OID 17167)
-- Name: meeting_group_members meeting_group_members_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_group_members
    ADD CONSTRAINT meeting_group_members_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.meeting_groups(group_id) ON DELETE CASCADE;


--
-- TOC entry 4067 (class 2606 OID 17186)
-- Name: meeting_group_tags meeting_group_tags_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_group_tags
    ADD CONSTRAINT meeting_group_tags_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.meeting_groups(group_id) ON DELETE CASCADE;


--
-- TOC entry 4065 (class 2606 OID 17246)
-- Name: meeting_groups meeting_groups_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_groups
    ADD CONSTRAINT meeting_groups_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.communities(community_id) ON DELETE CASCADE;


--
-- TOC entry 4073 (class 2606 OID 17369)
-- Name: sub_outcomes sub_outcomes_outcome_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_outcomes
    ADD CONSTRAINT sub_outcomes_outcome_id_fkey FOREIGN KEY (outcome_id) REFERENCES public.outcomes(outcome_id);


--
-- TOC entry 4062 (class 2606 OID 16812)
-- Name: user_teams user_teams_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_teams
    ADD CONSTRAINT user_teams_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id) ON DELETE CASCADE;


-- Completed on 2026-10-23 12:35:42 BST

--
-- PostgreSQL database dump complete
--

\unrestrict Gk86WA1PabrFL0YRfalAtRMnahYYkE5MCiPHJq3yKvaqlmeZiZKJcw2eNpQIUgu

