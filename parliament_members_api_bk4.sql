--
-- PostgreSQL database dump
--

\restrict H0OJtDuASasWCczlBdWWhyEwVz71qkYzNTTJqCjVFXzWEDwazfe4EzRbAlBPb0e

-- Dumped from database version 18.4 (Postgres.app)
-- Dumped by pg_dump version 18.3

-- Started on 2026-06-16 15:33:53 BST

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
-- TOC entry 2 (class 3079 OID 16391)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 3895 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 260 (class 1255 OID 16457)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16460)
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
-- TOC entry 222 (class 1259 OID 16476)
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
-- TOC entry 220 (class 1259 OID 16429)
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    person_id uuid DEFAULT gen_random_uuid() NOT NULL,
    full_name character varying(255) NOT NULL,
    organisation character varying(255) DEFAULT ''::character varying NOT NULL,
    role character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(320) DEFAULT ''::character varying NOT NULL,
    work_phone character varying(50) DEFAULT ''::character varying NOT NULL,
    home_phone character varying(50) DEFAULT ''::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- TOC entry 3735 (class 2606 OID 16473)
-- Name: contact_notes contact_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_notes
    ADD CONSTRAINT contact_notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 3739 (class 2606 OID 16489)
-- Name: contact_poc contact_poc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_poc
    ADD CONSTRAINT contact_poc_pkey PRIMARY KEY (poc_id);


--
-- TOC entry 3729 (class 2606 OID 16452)
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (person_id);


--
-- TOC entry 3730 (class 1259 OID 16455)
-- Name: idx_contacts_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_email ON public.contacts USING btree (lower((email)::text));


--
-- TOC entry 3731 (class 1259 OID 16456)
-- Name: idx_contacts_fts; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_fts ON public.contacts USING gin (to_tsvector('english'::regconfig, (((((((COALESCE(full_name, ''::character varying))::text || ' '::text) || (COALESCE(organisation, ''::character varying))::text) || ' '::text) || (COALESCE(role, ''::character varying))::text) || ' '::text) || (COALESCE(email, ''::character varying))::text)));


--
-- TOC entry 3732 (class 1259 OID 16453)
-- Name: idx_contacts_full_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_full_name ON public.contacts USING btree (lower((full_name)::text));


--
-- TOC entry 3733 (class 1259 OID 16454)
-- Name: idx_contacts_organisation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_organisation ON public.contacts USING btree (lower((organisation)::text));


--
-- TOC entry 3736 (class 1259 OID 16474)
-- Name: idx_notes_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notes_contact_id ON public.contact_notes USING btree (contact_id);


--
-- TOC entry 3737 (class 1259 OID 16475)
-- Name: idx_notes_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notes_created_at ON public.contact_notes USING btree (created_at DESC);


--
-- TOC entry 3740 (class 1259 OID 16490)
-- Name: idx_poc_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_poc_contact_id ON public.contact_poc USING btree (contact_id);


--
-- TOC entry 3741 (class 1259 OID 16491)
-- Name: idx_poc_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_poc_created_at ON public.contact_poc USING btree (created_at DESC);


--
-- TOC entry 3742 (class 2620 OID 16458)
-- Name: contacts set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.contacts FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


-- Completed on 2026-06-16 15:33:54 BST

--
-- PostgreSQL database dump complete
--

\unrestrict H0OJtDuASasWCczlBdWWhyEwVz71qkYzNTTJqCjVFXzWEDwazfe4EzRbAlBPb0e

