--
-- PostgreSQL database dump
--

\restrict rhzHLISiYwuaBeldrYJfLpPYPy0hsp3hwAjaAKxV2BRNKOhJ4QKU4Z3LLyHVacA

-- Dumped from database version 18.4 (Postgres.app)
-- Dumped by pg_dump version 18.3

-- Started on 2026-06-16 16:14:53 BST

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
-- TOC entry 4019 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 283 (class 1255 OID 16945)
-- Name: get_contact_latest_activity(uuid); Type: FUNCTION; Schema: public; Owner: postgres
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
        SELECT 'Meetings', meeting_date::text, created_at
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


ALTER FUNCTION public.get_contact_latest_activity(p_contact_id uuid) OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 16825)
-- Name: update_teams_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_teams_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_teams_updated_at() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 16964)
-- Name: areas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.areas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    area character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.areas OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16769)
-- Name: contact_anex_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_anex_notes (
    note_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_anex_notes OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16946)
-- Name: contact_areas; Type: TABLE; Schema: public; Owner: db_access_1
--

CREATE TABLE public.contact_areas (
    area_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    area character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_areas OWNER TO db_access_1;

--
-- TOC entry 226 (class 1259 OID 16737)
-- Name: contact_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_documents (
    document_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    mime_type character varying(127) NOT NULL,
    file_size integer NOT NULL,
    file_data bytea NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_documents OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16976)
-- Name: contact_highlight_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_highlight_notes (
    note_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_highlight_notes OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16667)
-- Name: contact_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_links (
    link_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    reference character varying(255) NOT NULL,
    label character varying(255) DEFAULT ''::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_links OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16720)
-- Name: contact_meeting_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_meeting_links (
    meeting_link_id uuid DEFAULT gen_random_uuid() NOT NULL,
    meeting_id uuid NOT NULL,
    reference character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_meeting_links OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16687)
-- Name: contact_meetings; Type: TABLE; Schema: public; Owner: postgres
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
    CONSTRAINT contact_meetings_score1_check CHECK (((score1 >= 0) AND (score1 <= 5))),
    CONSTRAINT contact_meetings_score2_check CHECK (((score2 >= 0) AND (score2 <= 5))),
    CONSTRAINT contact_meetings_score3_check CHECK (((score3 >= 0) AND (score3 <= 5))),
    CONSTRAINT contact_meetings_score4_check CHECK (((score4 >= 0) AND (score4 <= 5)))
);


ALTER TABLE public.contact_meetings OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16531)
-- Name: contact_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_notes (
    note_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_notes OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16547)
-- Name: contact_poc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_poc (
    poc_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    details character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_poc OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16598)
-- Name: contact_tag; Type: TABLE; Schema: public; Owner: db_access_1
--

CREATE TABLE public.contact_tag (
    tag_id uuid DEFAULT gen_random_uuid() NOT NULL,
    contact_id uuid NOT NULL,
    username character varying(255) NOT NULL,
    tag character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_tag OWNER TO db_access_1;

--
-- TOC entry 230 (class 1259 OID 16929)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tag character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16785)
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    team_id uuid DEFAULT gen_random_uuid() NOT NULL,
    team_name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    description text,
    intranet_url character varying(500) DEFAULT ''::character varying NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16797)
-- Name: user_teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_teams (
    user_team_id uuid DEFAULT gen_random_uuid() NOT NULL,
    username character varying(255) NOT NULL,
    team_id uuid NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_teams OWNER TO postgres;

--
-- TOC entry 3857 (class 2606 OID 16975)
-- Name: areas areas_area_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_area_key UNIQUE (area);


--
-- TOC entry 3859 (class 2606 OID 16973)
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- TOC entry 3834 (class 2606 OID 16782)
-- Name: contact_anex_notes contact_anex_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_anex_notes
    ADD CONSTRAINT contact_anex_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 3852 (class 2606 OID 16959)
-- Name: contact_areas contact_area_pkey; Type: CONSTRAINT; Schema: public; Owner: db_access_1
--

ALTER TABLE ONLY public.contact_areas
    ADD CONSTRAINT contact_area_pkey PRIMARY KEY (area_id);


--
-- TOC entry 3830 (class 2606 OID 16753)
-- Name: contact_documents contact_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_documents
    ADD CONSTRAINT contact_documents_pkey PRIMARY KEY (document_id);


--
-- TOC entry 3861 (class 2606 OID 16989)
-- Name: contact_highlight_notes contact_highlight_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_highlight_notes
    ADD CONSTRAINT contact_highlight_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 3818 (class 2606 OID 16684)
-- Name: contact_links contact_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_links
    ADD CONSTRAINT contact_links_pkey PRIMARY KEY (link_id);


--
-- TOC entry 3827 (class 2606 OID 16730)
-- Name: contact_meeting_links contact_meeting_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_meeting_links
    ADD CONSTRAINT contact_meeting_links_pkey PRIMARY KEY (meeting_link_id);


--
-- TOC entry 3822 (class 2606 OID 16716)
-- Name: contact_meetings contact_meetings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_meetings
    ADD CONSTRAINT contact_meetings_pkey PRIMARY KEY (meeting_id);


--
-- TOC entry 3805 (class 2606 OID 16544)
-- Name: contact_notes contact_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_notes
    ADD CONSTRAINT contact_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 3809 (class 2606 OID 16560)
-- Name: contact_poc contact_poc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_poc
    ADD CONSTRAINT contact_poc_pkey PRIMARY KEY (poc_id);


--
-- TOC entry 3813 (class 2606 OID 16611)
-- Name: contact_tag contact_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: db_access_1
--

ALTER TABLE ONLY public.contact_tag
    ADD CONSTRAINT contact_tag_pkey PRIMARY KEY (tag_id);


--
-- TOC entry 3848 (class 2606 OID 16938)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 3850 (class 2606 OID 16940)
-- Name: tags tags_tag_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_key UNIQUE (tag);


--
-- TOC entry 3838 (class 2606 OID 16794)
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- TOC entry 3840 (class 2606 OID 16796)
-- Name: teams teams_team_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_team_name_key UNIQUE (team_name);


--
-- TOC entry 3844 (class 2606 OID 16811)
-- Name: user_teams uq_user_team; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_teams
    ADD CONSTRAINT uq_user_team UNIQUE (username, team_id);


--
-- TOC entry 3846 (class 2606 OID 16809)
-- Name: user_teams user_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_teams
    ADD CONSTRAINT user_teams_pkey PRIMARY KEY (user_team_id);


--
-- TOC entry 3835 (class 1259 OID 16783)
-- Name: idx_anex_notes_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_anex_notes_contact_id ON public.contact_anex_notes USING btree (contact_id);


--
-- TOC entry 3836 (class 1259 OID 16784)
-- Name: idx_anex_notes_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_anex_notes_created_at ON public.contact_anex_notes USING btree (created_at DESC);


--
-- TOC entry 3853 (class 1259 OID 16962)
-- Name: idx_areax_area; Type: INDEX; Schema: public; Owner: db_access_1
--

CREATE INDEX idx_areax_area ON public.contact_areas USING btree (area);


--
-- TOC entry 3854 (class 1259 OID 16960)
-- Name: idx_areax_contact_id; Type: INDEX; Schema: public; Owner: db_access_1
--

CREATE INDEX idx_areax_contact_id ON public.contact_areas USING btree (contact_id);


--
-- TOC entry 3855 (class 1259 OID 16961)
-- Name: idx_areax_created_at; Type: INDEX; Schema: public; Owner: db_access_1
--

CREATE INDEX idx_areax_created_at ON public.contact_areas USING btree (created_at DESC);


--
-- TOC entry 3831 (class 1259 OID 16754)
-- Name: idx_documents_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_documents_contact_id ON public.contact_documents USING btree (contact_id);


--
-- TOC entry 3832 (class 1259 OID 16755)
-- Name: idx_documents_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_documents_created_at ON public.contact_documents USING btree (created_at DESC);


--
-- TOC entry 3862 (class 1259 OID 16990)
-- Name: idx_highlight_notes_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_highlight_notes_contact_id ON public.contact_highlight_notes USING btree (contact_id);


--
-- TOC entry 3863 (class 1259 OID 16991)
-- Name: idx_highlight_notes_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_highlight_notes_created_at ON public.contact_highlight_notes USING btree (created_at DESC);


--
-- TOC entry 3819 (class 1259 OID 16685)
-- Name: idx_links_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_links_contact_id ON public.contact_links USING btree (contact_id);


--
-- TOC entry 3820 (class 1259 OID 16686)
-- Name: idx_links_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_links_created_at ON public.contact_links USING btree (created_at DESC);


--
-- TOC entry 3828 (class 1259 OID 16736)
-- Name: idx_meeting_links_meeting_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_meeting_links_meeting_id ON public.contact_meeting_links USING btree (meeting_id);


--
-- TOC entry 3823 (class 1259 OID 16717)
-- Name: idx_meetings_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_meetings_contact_id ON public.contact_meetings USING btree (contact_id);


--
-- TOC entry 3824 (class 1259 OID 16718)
-- Name: idx_meetings_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_meetings_created_at ON public.contact_meetings USING btree (created_at DESC);


--
-- TOC entry 3825 (class 1259 OID 16719)
-- Name: idx_meetings_meeting_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_meetings_meeting_date ON public.contact_meetings USING btree (meeting_date DESC);


--
-- TOC entry 3806 (class 1259 OID 16545)
-- Name: idx_notes_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notes_contact_id ON public.contact_notes USING btree (contact_id);


--
-- TOC entry 3807 (class 1259 OID 16546)
-- Name: idx_notes_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notes_created_at ON public.contact_notes USING btree (created_at DESC);


--
-- TOC entry 3810 (class 1259 OID 16561)
-- Name: idx_poc_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_poc_contact_id ON public.contact_poc USING btree (contact_id);


--
-- TOC entry 3811 (class 1259 OID 16562)
-- Name: idx_poc_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_poc_created_at ON public.contact_poc USING btree (created_at DESC);


--
-- TOC entry 3814 (class 1259 OID 16612)
-- Name: idx_tagx_contact_id; Type: INDEX; Schema: public; Owner: db_access_1
--

CREATE INDEX idx_tagx_contact_id ON public.contact_tag USING btree (contact_id);


--
-- TOC entry 3815 (class 1259 OID 16613)
-- Name: idx_tagx_created_at; Type: INDEX; Schema: public; Owner: db_access_1
--

CREATE INDEX idx_tagx_created_at ON public.contact_tag USING btree (created_at DESC);


--
-- TOC entry 3816 (class 1259 OID 16614)
-- Name: idx_tagx_tag; Type: INDEX; Schema: public; Owner: db_access_1
--

CREATE INDEX idx_tagx_tag ON public.contact_tag USING btree (tag);


--
-- TOC entry 3841 (class 1259 OID 16818)
-- Name: idx_user_teams_team_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_teams_team_id ON public.user_teams USING btree (team_id);


--
-- TOC entry 3842 (class 1259 OID 16817)
-- Name: idx_user_teams_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_teams_username ON public.user_teams USING btree (username);


--
-- TOC entry 3866 (class 2620 OID 16826)
-- Name: teams set_teams_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_teams_updated_at BEFORE UPDATE ON public.teams FOR EACH ROW EXECUTE FUNCTION public.update_teams_updated_at();


--
-- TOC entry 3864 (class 2606 OID 16731)
-- Name: contact_meeting_links contact_meeting_links_meeting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_meeting_links
    ADD CONSTRAINT contact_meeting_links_meeting_id_fkey FOREIGN KEY (meeting_id) REFERENCES public.contact_meetings(meeting_id) ON DELETE CASCADE;


--
-- TOC entry 3865 (class 2606 OID 16812)
-- Name: user_teams user_teams_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_teams
    ADD CONSTRAINT user_teams_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id) ON DELETE CASCADE;


-- Completed on 2026-06-16 16:14:55 BST

--
-- PostgreSQL database dump complete
--

\unrestrict rhzHLISiYwuaBeldrYJfLpPYPy0hsp3hwAjaAKxV2BRNKOhJ4QKU4Z3LLyHVacA

