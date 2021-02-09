--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: assetindexdata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assetindexdata (
    id integer NOT NULL,
    "sessionId" character varying(36) DEFAULT ''::character varying NOT NULL,
    "volumeId" integer NOT NULL,
    uri text,
    size bigint,
    "timestamp" timestamp(0) without time zone,
    "recordId" integer,
    "inProgress" boolean DEFAULT false,
    completed boolean DEFAULT false,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.assetindexdata OWNER TO postgres;

--
-- Name: assetindexdata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assetindexdata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assetindexdata_id_seq OWNER TO postgres;

--
-- Name: assetindexdata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assetindexdata_id_seq OWNED BY public.assetindexdata.id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    "volumeId" integer,
    "folderId" integer NOT NULL,
    "uploaderId" integer,
    filename character varying(255) NOT NULL,
    kind character varying(50) DEFAULT 'unknown'::character varying NOT NULL,
    width integer,
    height integer,
    size bigint,
    "focalPoint" character varying(13) DEFAULT NULL::character varying,
    "deletedWithVolume" boolean,
    "keptFile" boolean,
    "dateModified" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.assets OWNER TO postgres;

--
-- Name: assettransformindex; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assettransformindex (
    id integer NOT NULL,
    "assetId" integer NOT NULL,
    filename character varying(255),
    format character varying(255),
    location character varying(255) NOT NULL,
    "volumeId" integer,
    "fileExists" boolean DEFAULT false NOT NULL,
    "inProgress" boolean DEFAULT false NOT NULL,
    error boolean DEFAULT false NOT NULL,
    "dateIndexed" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.assettransformindex OWNER TO postgres;

--
-- Name: assettransformindex_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assettransformindex_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assettransformindex_id_seq OWNER TO postgres;

--
-- Name: assettransformindex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assettransformindex_id_seq OWNED BY public.assettransformindex.id;


--
-- Name: assettransforms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assettransforms (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    mode character varying(255) DEFAULT 'crop'::character varying NOT NULL,
    "position" character varying(255) DEFAULT 'center-center'::character varying NOT NULL,
    width integer,
    height integer,
    format character varying(255),
    quality integer,
    interlace character varying(255) DEFAULT 'none'::character varying NOT NULL,
    "dimensionChangeTime" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    CONSTRAINT assettransforms_interlace_check CHECK (((interlace)::text = ANY ((ARRAY['none'::character varying, 'line'::character varying, 'plane'::character varying, 'partition'::character varying])::text[]))),
    CONSTRAINT assettransforms_mode_check CHECK (((mode)::text = ANY ((ARRAY['stretch'::character varying, 'fit'::character varying, 'crop'::character varying])::text[]))),
    CONSTRAINT assettransforms_position_check CHECK ((("position")::text = ANY ((ARRAY['top-left'::character varying, 'top-center'::character varying, 'top-right'::character varying, 'center-left'::character varying, 'center-center'::character varying, 'center-right'::character varying, 'bottom-left'::character varying, 'bottom-center'::character varying, 'bottom-right'::character varying])::text[])))
);


ALTER TABLE public.assettransforms OWNER TO postgres;

--
-- Name: assettransforms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assettransforms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assettransforms_id_seq OWNER TO postgres;

--
-- Name: assettransforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assettransforms_id_seq OWNED BY public.assettransforms.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "parentId" integer,
    "deletedWithGroup" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categorygroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorygroups (
    id integer NOT NULL,
    "structureId" integer NOT NULL,
    "fieldLayoutId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.categorygroups OWNER TO postgres;

--
-- Name: categorygroups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorygroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorygroups_id_seq OWNER TO postgres;

--
-- Name: categorygroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorygroups_id_seq OWNED BY public.categorygroups.id;


--
-- Name: categorygroups_sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorygroups_sites (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "siteId" integer NOT NULL,
    "hasUrls" boolean DEFAULT true NOT NULL,
    "uriFormat" text,
    template character varying(500),
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.categorygroups_sites OWNER TO postgres;

--
-- Name: categorygroups_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorygroups_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorygroups_sites_id_seq OWNER TO postgres;

--
-- Name: categorygroups_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorygroups_sites_id_seq OWNED BY public.categorygroups_sites.id;


--
-- Name: changedattributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.changedattributes (
    "elementId" integer NOT NULL,
    "siteId" integer NOT NULL,
    attribute character varying(255) NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    propagated boolean NOT NULL,
    "userId" integer
);


ALTER TABLE public.changedattributes OWNER TO postgres;

--
-- Name: changedfields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.changedfields (
    "elementId" integer NOT NULL,
    "siteId" integer NOT NULL,
    "fieldId" integer NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    propagated boolean NOT NULL,
    "userId" integer
);


ALTER TABLE public.changedfields OWNER TO postgres;

--
-- Name: content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content (
    id integer NOT NULL,
    "elementId" integer NOT NULL,
    "siteId" integer NOT NULL,
    title character varying(255),
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    field_body text,
    field_excerpt character varying(1600),
    field_videohtml text,
    field_faq text,
    field_meta_titel character varying(280),
    field_meta_description character varying(640),
    field_person_firstname text,
    field_person_lastname text,
    field_person_salutation character varying(255),
    field_person_position character varying(255),
    field_email text,
    field_phone text,
    field_facebook text,
    field_twitter text,
    field_xing text,
    field_linkedin text,
    field_person_title text,
    field_article_date_old time(0) without time zone,
    field_event_date_old time(0) without time zone,
    field_hall smallint,
    field_booth text,
    field_event_date timestamp(0) without time zone,
    field_article_date timestamp(0) without time zone,
    field_address_name text,
    field_address_street text,
    field_address_postalcode text,
    field_address_city text,
    field_address_country character varying(8),
    field_website text,
    field_fax text,
    field_person_email text,
    field_instagram text,
    field_youtube text,
    field_industryarena text,
    field_vdw_id text,
    field_vdw_auftrag text,
    field_event_year smallint,
    field_sektor_id text,
    field_body_raw text
);


ALTER TABLE public.content OWNER TO postgres;

--
-- Name: content_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_id_seq OWNER TO postgres;

--
-- Name: content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.content_id_seq OWNED BY public.content.id;


--
-- Name: craftidtokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.craftidtokens (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "accessToken" text NOT NULL,
    "expiryDate" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.craftidtokens OWNER TO postgres;

--
-- Name: craftidtokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.craftidtokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.craftidtokens_id_seq OWNER TO postgres;

--
-- Name: craftidtokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.craftidtokens_id_seq OWNED BY public.craftidtokens.id;


--
-- Name: deprecationerrors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deprecationerrors (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    fingerprint character varying(255) NOT NULL,
    "lastOccurrence" timestamp(0) without time zone NOT NULL,
    file character varying(255) NOT NULL,
    line smallint,
    message text,
    traces text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.deprecationerrors OWNER TO postgres;

--
-- Name: deprecationerrors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deprecationerrors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deprecationerrors_id_seq OWNER TO postgres;

--
-- Name: deprecationerrors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deprecationerrors_id_seq OWNED BY public.deprecationerrors.id;


--
-- Name: drafts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drafts (
    id integer NOT NULL,
    "sourceId" integer,
    "creatorId" integer,
    name character varying(255) NOT NULL,
    notes text,
    "trackChanges" boolean DEFAULT false NOT NULL,
    "dateLastMerged" timestamp(0) without time zone
);


ALTER TABLE public.drafts OWNER TO postgres;

--
-- Name: drafts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.drafts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drafts_id_seq OWNER TO postgres;

--
-- Name: drafts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.drafts_id_seq OWNED BY public.drafts.id;


--
-- Name: elementindexsettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.elementindexsettings (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    settings text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.elementindexsettings OWNER TO postgres;

--
-- Name: elementindexsettings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.elementindexsettings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elementindexsettings_id_seq OWNER TO postgres;

--
-- Name: elementindexsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.elementindexsettings_id_seq OWNED BY public.elementindexsettings.id;


--
-- Name: elements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.elements (
    id integer NOT NULL,
    "draftId" integer,
    "revisionId" integer,
    "fieldLayoutId" integer,
    type character varying(255) NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.elements OWNER TO postgres;

--
-- Name: elements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.elements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elements_id_seq OWNER TO postgres;

--
-- Name: elements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.elements_id_seq OWNED BY public.elements.id;


--
-- Name: elements_sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.elements_sites (
    id integer NOT NULL,
    "elementId" integer NOT NULL,
    "siteId" integer NOT NULL,
    slug character varying(255),
    uri character varying(255),
    enabled boolean DEFAULT true NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.elements_sites OWNER TO postgres;

--
-- Name: elements_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.elements_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elements_sites_id_seq OWNER TO postgres;

--
-- Name: elements_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.elements_sites_id_seq OWNED BY public.elements_sites.id;


--
-- Name: entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entries (
    id integer NOT NULL,
    "sectionId" integer NOT NULL,
    "parentId" integer,
    "typeId" integer NOT NULL,
    "authorId" integer,
    "postDate" timestamp(0) without time zone,
    "expiryDate" timestamp(0) without time zone,
    "deletedWithEntryType" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.entries OWNER TO postgres;

--
-- Name: entrytypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrytypes (
    id integer NOT NULL,
    "sectionId" integer NOT NULL,
    "fieldLayoutId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "hasTitleField" boolean DEFAULT true NOT NULL,
    "titleTranslationMethod" character varying(255) DEFAULT 'site'::character varying NOT NULL,
    "titleTranslationKeyFormat" text,
    "titleFormat" character varying(255),
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.entrytypes OWNER TO postgres;

--
-- Name: entrytypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entrytypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entrytypes_id_seq OWNER TO postgres;

--
-- Name: entrytypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entrytypes_id_seq OWNED BY public.entrytypes.id;


--
-- Name: fieldgroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fieldgroups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fieldgroups OWNER TO postgres;

--
-- Name: fieldgroups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fieldgroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fieldgroups_id_seq OWNER TO postgres;

--
-- Name: fieldgroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fieldgroups_id_seq OWNED BY public.fieldgroups.id;


--
-- Name: fieldlayoutfields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fieldlayoutfields (
    id integer NOT NULL,
    "layoutId" integer NOT NULL,
    "tabId" integer NOT NULL,
    "fieldId" integer NOT NULL,
    required boolean DEFAULT false NOT NULL,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fieldlayoutfields OWNER TO postgres;

--
-- Name: fieldlayoutfields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fieldlayoutfields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fieldlayoutfields_id_seq OWNER TO postgres;

--
-- Name: fieldlayoutfields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fieldlayoutfields_id_seq OWNED BY public.fieldlayoutfields.id;


--
-- Name: fieldlayouts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fieldlayouts (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fieldlayouts OWNER TO postgres;

--
-- Name: fieldlayouts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fieldlayouts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fieldlayouts_id_seq OWNER TO postgres;

--
-- Name: fieldlayouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fieldlayouts_id_seq OWNED BY public.fieldlayouts.id;


--
-- Name: fieldlayouttabs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fieldlayouttabs (
    id integer NOT NULL,
    "layoutId" integer NOT NULL,
    name character varying(255) NOT NULL,
    elements text,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fieldlayouttabs OWNER TO postgres;

--
-- Name: fieldlayouttabs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fieldlayouttabs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fieldlayouttabs_id_seq OWNER TO postgres;

--
-- Name: fieldlayouttabs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fieldlayouttabs_id_seq OWNED BY public.fieldlayouttabs.id;


--
-- Name: fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fields (
    id integer NOT NULL,
    "groupId" integer,
    name character varying(255) NOT NULL,
    handle character varying(64) NOT NULL,
    context character varying(255) DEFAULT 'global'::character varying NOT NULL,
    instructions text,
    searchable boolean DEFAULT true NOT NULL,
    "translationMethod" character varying(255) DEFAULT 'none'::character varying NOT NULL,
    "translationKeyFormat" text,
    type character varying(255) NOT NULL,
    settings text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fields OWNER TO postgres;

--
-- Name: fields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fields_id_seq OWNER TO postgres;

--
-- Name: fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fields_id_seq OWNED BY public.fields.id;


--
-- Name: globalsets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.globalsets (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "fieldLayoutId" integer,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.globalsets OWNER TO postgres;

--
-- Name: globalsets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.globalsets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.globalsets_id_seq OWNER TO postgres;

--
-- Name: globalsets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.globalsets_id_seq OWNED BY public.globalsets.id;


--
-- Name: gqlschemas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gqlschemas (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    scope text,
    "isPublic" boolean DEFAULT false NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.gqlschemas OWNER TO postgres;

--
-- Name: gqlschemas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gqlschemas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gqlschemas_id_seq OWNER TO postgres;

--
-- Name: gqlschemas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gqlschemas_id_seq OWNED BY public.gqlschemas.id;


--
-- Name: gqltokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gqltokens (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "accessToken" character varying(255) NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    "expiryDate" timestamp(0) without time zone,
    "lastUsed" timestamp(0) without time zone,
    "schemaId" integer,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.gqltokens OWNER TO postgres;

--
-- Name: gqltokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gqltokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gqltokens_id_seq OWNER TO postgres;

--
-- Name: gqltokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gqltokens_id_seq OWNED BY public.gqltokens.id;


--
-- Name: info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.info (
    id integer NOT NULL,
    version character varying(50) NOT NULL,
    "schemaVersion" character varying(15) NOT NULL,
    maintenance boolean DEFAULT false NOT NULL,
    "configVersion" character(12) DEFAULT '000000000000'::bpchar NOT NULL,
    "fieldVersion" character(12) DEFAULT '000000000000'::bpchar NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.info OWNER TO postgres;

--
-- Name: info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.info_id_seq OWNER TO postgres;

--
-- Name: info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.info_id_seq OWNED BY public.info.id;


--
-- Name: matrixblocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.matrixblocks (
    id integer NOT NULL,
    "ownerId" integer NOT NULL,
    "fieldId" integer NOT NULL,
    "typeId" integer NOT NULL,
    "sortOrder" smallint,
    "deletedWithOwner" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.matrixblocks OWNER TO postgres;

--
-- Name: matrixblocktypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.matrixblocktypes (
    id integer NOT NULL,
    "fieldId" integer NOT NULL,
    "fieldLayoutId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.matrixblocktypes OWNER TO postgres;

--
-- Name: matrixblocktypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.matrixblocktypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.matrixblocktypes_id_seq OWNER TO postgres;

--
-- Name: matrixblocktypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.matrixblocktypes_id_seq OWNED BY public.matrixblocktypes.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    track character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "applyTime" timestamp(0) without time zone NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: plugins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plugins (
    id integer NOT NULL,
    handle character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    "schemaVersion" character varying(255) NOT NULL,
    "licenseKeyStatus" character varying(255) DEFAULT 'unknown'::character varying NOT NULL,
    "licensedEdition" character varying(255),
    "installDate" timestamp(0) without time zone NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    CONSTRAINT "plugins_licenseKeyStatus_check" CHECK ((("licenseKeyStatus")::text = ANY ((ARRAY['valid'::character varying, 'trial'::character varying, 'invalid'::character varying, 'mismatched'::character varying, 'astray'::character varying, 'unknown'::character varying])::text[])))
);


ALTER TABLE public.plugins OWNER TO postgres;

--
-- Name: plugins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plugins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plugins_id_seq OWNER TO postgres;

--
-- Name: plugins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plugins_id_seq OWNED BY public.plugins.id;


--
-- Name: projectconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectconfig (
    path character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.projectconfig OWNER TO postgres;

--
-- Name: queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.queue (
    id integer NOT NULL,
    channel character varying(255) DEFAULT 'queue'::character varying NOT NULL,
    job bytea NOT NULL,
    description text,
    "timePushed" integer NOT NULL,
    ttr integer NOT NULL,
    delay integer DEFAULT 0 NOT NULL,
    priority integer DEFAULT 1024 NOT NULL,
    "dateReserved" timestamp(0) without time zone,
    "timeUpdated" integer,
    progress smallint DEFAULT 0 NOT NULL,
    "progressLabel" character varying(255),
    attempt integer,
    fail boolean DEFAULT false,
    "dateFailed" timestamp(0) without time zone,
    error text
);


ALTER TABLE public.queue OWNER TO postgres;

--
-- Name: queue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.queue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queue_id_seq OWNER TO postgres;

--
-- Name: queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.queue_id_seq OWNED BY public.queue.id;


--
-- Name: relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relations (
    id integer NOT NULL,
    "fieldId" integer NOT NULL,
    "sourceId" integer NOT NULL,
    "sourceSiteId" integer,
    "targetId" integer NOT NULL,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.relations OWNER TO postgres;

--
-- Name: relations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relations_id_seq OWNER TO postgres;

--
-- Name: relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.relations_id_seq OWNED BY public.relations.id;


--
-- Name: resourcepaths; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resourcepaths (
    hash character varying(255) NOT NULL,
    path character varying(255) NOT NULL
);


ALTER TABLE public.resourcepaths OWNER TO postgres;

--
-- Name: revisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revisions (
    id integer NOT NULL,
    "sourceId" integer NOT NULL,
    "creatorId" integer,
    num integer NOT NULL,
    notes text
);


ALTER TABLE public.revisions OWNER TO postgres;

--
-- Name: revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.revisions_id_seq OWNER TO postgres;

--
-- Name: revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.revisions_id_seq OWNED BY public.revisions.id;


--
-- Name: searchindex; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.searchindex (
    "elementId" integer NOT NULL,
    attribute character varying(25) NOT NULL,
    "fieldId" integer NOT NULL,
    "siteId" integer NOT NULL,
    keywords text NOT NULL,
    keywords_vector tsvector NOT NULL
);


ALTER TABLE public.searchindex OWNER TO postgres;

--
-- Name: sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sections (
    id integer NOT NULL,
    "structureId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    type character varying(255) DEFAULT 'channel'::character varying NOT NULL,
    "enableVersioning" boolean DEFAULT false NOT NULL,
    "propagationMethod" character varying(255) DEFAULT 'all'::character varying NOT NULL,
    "previewTargets" text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    CONSTRAINT sections_type_check CHECK (((type)::text = ANY ((ARRAY['single'::character varying, 'channel'::character varying, 'structure'::character varying])::text[])))
);


ALTER TABLE public.sections OWNER TO postgres;

--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_id_seq OWNER TO postgres;

--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;


--
-- Name: sections_sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sections_sites (
    id integer NOT NULL,
    "sectionId" integer NOT NULL,
    "siteId" integer NOT NULL,
    "hasUrls" boolean DEFAULT true NOT NULL,
    "uriFormat" text,
    template character varying(500),
    "enabledByDefault" boolean DEFAULT true NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.sections_sites OWNER TO postgres;

--
-- Name: sections_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sections_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_sites_id_seq OWNER TO postgres;

--
-- Name: sections_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sections_sites_id_seq OWNED BY public.sections_sites.id;


--
-- Name: sequences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sequences (
    name character varying(255) NOT NULL,
    next integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.sequences OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    token character(100) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: shunnedmessages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shunnedmessages (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    message character varying(255) NOT NULL,
    "expiryDate" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.shunnedmessages OWNER TO postgres;

--
-- Name: shunnedmessages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shunnedmessages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shunnedmessages_id_seq OWNER TO postgres;

--
-- Name: shunnedmessages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shunnedmessages_id_seq OWNED BY public.shunnedmessages.id;


--
-- Name: sitegroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sitegroups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.sitegroups OWNER TO postgres;

--
-- Name: sitegroups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sitegroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sitegroups_id_seq OWNER TO postgres;

--
-- Name: sitegroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sitegroups_id_seq OWNED BY public.sitegroups.id;


--
-- Name: sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sites (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "primary" boolean NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    language character varying(12) NOT NULL,
    "hasUrls" boolean DEFAULT false NOT NULL,
    "baseUrl" character varying(255),
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.sites OWNER TO postgres;

--
-- Name: sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sites_id_seq OWNER TO postgres;

--
-- Name: sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sites_id_seq OWNED BY public.sites.id;


--
-- Name: structureelements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.structureelements (
    id integer NOT NULL,
    "structureId" integer NOT NULL,
    "elementId" integer,
    root integer,
    lft integer NOT NULL,
    rgt integer NOT NULL,
    level smallint NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.structureelements OWNER TO postgres;

--
-- Name: structureelements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.structureelements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.structureelements_id_seq OWNER TO postgres;

--
-- Name: structureelements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.structureelements_id_seq OWNED BY public.structureelements.id;


--
-- Name: structures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.structures (
    id integer NOT NULL,
    "maxLevels" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.structures OWNER TO postgres;

--
-- Name: structures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.structures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.structures_id_seq OWNER TO postgres;

--
-- Name: structures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.structures_id_seq OWNED BY public.structures.id;


--
-- Name: systemmessages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.systemmessages (
    id integer NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    subject text NOT NULL,
    body text NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.systemmessages OWNER TO postgres;

--
-- Name: systemmessages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.systemmessages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.systemmessages_id_seq OWNER TO postgres;

--
-- Name: systemmessages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.systemmessages_id_seq OWNED BY public.systemmessages.id;


--
-- Name: taggroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taggroups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "fieldLayoutId" integer,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.taggroups OWNER TO postgres;

--
-- Name: taggroups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taggroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggroups_id_seq OWNER TO postgres;

--
-- Name: taggroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taggroups_id_seq OWNED BY public.taggroups.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "deletedWithGroup" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: templatecacheelements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.templatecacheelements (
    id integer NOT NULL,
    "cacheId" integer NOT NULL,
    "elementId" integer NOT NULL
);


ALTER TABLE public.templatecacheelements OWNER TO postgres;

--
-- Name: templatecacheelements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.templatecacheelements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templatecacheelements_id_seq OWNER TO postgres;

--
-- Name: templatecacheelements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.templatecacheelements_id_seq OWNED BY public.templatecacheelements.id;


--
-- Name: templatecachequeries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.templatecachequeries (
    id integer NOT NULL,
    "cacheId" integer NOT NULL,
    type character varying(255) NOT NULL,
    query text NOT NULL
);


ALTER TABLE public.templatecachequeries OWNER TO postgres;

--
-- Name: templatecachequeries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.templatecachequeries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templatecachequeries_id_seq OWNER TO postgres;

--
-- Name: templatecachequeries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.templatecachequeries_id_seq OWNED BY public.templatecachequeries.id;


--
-- Name: templatecaches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.templatecaches (
    id integer NOT NULL,
    "siteId" integer NOT NULL,
    "cacheKey" character varying(255) NOT NULL,
    path character varying(255),
    "expiryDate" timestamp(0) without time zone NOT NULL,
    body text NOT NULL
);


ALTER TABLE public.templatecaches OWNER TO postgres;

--
-- Name: templatecaches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.templatecaches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templatecaches_id_seq OWNER TO postgres;

--
-- Name: templatecaches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.templatecaches_id_seq OWNED BY public.templatecaches.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tokens (
    id integer NOT NULL,
    token character(32) NOT NULL,
    route text,
    "usageLimit" smallint,
    "usageCount" smallint,
    "expiryDate" timestamp(0) without time zone NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.tokens OWNER TO postgres;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO postgres;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: usergroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usergroups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    description text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.usergroups OWNER TO postgres;

--
-- Name: usergroups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usergroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usergroups_id_seq OWNER TO postgres;

--
-- Name: usergroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usergroups_id_seq OWNED BY public.usergroups.id;


--
-- Name: usergroups_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usergroups_users (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "userId" integer NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.usergroups_users OWNER TO postgres;

--
-- Name: usergroups_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usergroups_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usergroups_users_id_seq OWNER TO postgres;

--
-- Name: usergroups_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usergroups_users_id_seq OWNED BY public.usergroups_users.id;


--
-- Name: userpermissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userpermissions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.userpermissions OWNER TO postgres;

--
-- Name: userpermissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userpermissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userpermissions_id_seq OWNER TO postgres;

--
-- Name: userpermissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userpermissions_id_seq OWNED BY public.userpermissions.id;


--
-- Name: userpermissions_usergroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userpermissions_usergroups (
    id integer NOT NULL,
    "permissionId" integer NOT NULL,
    "groupId" integer NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.userpermissions_usergroups OWNER TO postgres;

--
-- Name: userpermissions_usergroups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userpermissions_usergroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userpermissions_usergroups_id_seq OWNER TO postgres;

--
-- Name: userpermissions_usergroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userpermissions_usergroups_id_seq OWNED BY public.userpermissions_usergroups.id;


--
-- Name: userpermissions_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userpermissions_users (
    id integer NOT NULL,
    "permissionId" integer NOT NULL,
    "userId" integer NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.userpermissions_users OWNER TO postgres;

--
-- Name: userpermissions_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userpermissions_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userpermissions_users_id_seq OWNER TO postgres;

--
-- Name: userpermissions_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userpermissions_users_id_seq OWNED BY public.userpermissions_users.id;


--
-- Name: userpreferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userpreferences (
    "userId" integer NOT NULL,
    preferences text
);


ALTER TABLE public.userpreferences OWNER TO postgres;

--
-- Name: userpreferences_userId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."userpreferences_userId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userpreferences_userId_seq" OWNER TO postgres;

--
-- Name: userpreferences_userId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."userpreferences_userId_seq" OWNED BY public.userpreferences."userId";


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    "photoId" integer,
    "firstName" character varying(100),
    "lastName" character varying(100),
    email character varying(255) NOT NULL,
    password character varying(255),
    admin boolean DEFAULT false NOT NULL,
    locked boolean DEFAULT false NOT NULL,
    suspended boolean DEFAULT false NOT NULL,
    pending boolean DEFAULT false NOT NULL,
    "lastLoginDate" timestamp(0) without time zone,
    "lastLoginAttemptIp" character varying(45),
    "invalidLoginWindowStart" timestamp(0) without time zone,
    "invalidLoginCount" smallint,
    "lastInvalidLoginDate" timestamp(0) without time zone,
    "lockoutDate" timestamp(0) without time zone,
    "hasDashboard" boolean DEFAULT false NOT NULL,
    "verificationCode" character varying(255),
    "verificationCodeIssuedDate" timestamp(0) without time zone,
    "unverifiedEmail" character varying(255),
    "passwordResetRequired" boolean DEFAULT false NOT NULL,
    "lastPasswordChangeDate" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: volumefolders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volumefolders (
    id integer NOT NULL,
    "parentId" integer,
    "volumeId" integer,
    name character varying(255) NOT NULL,
    path character varying(255),
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.volumefolders OWNER TO postgres;

--
-- Name: volumefolders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.volumefolders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volumefolders_id_seq OWNER TO postgres;

--
-- Name: volumefolders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.volumefolders_id_seq OWNED BY public.volumefolders.id;


--
-- Name: volumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volumes (
    id integer NOT NULL,
    "fieldLayoutId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    "hasUrls" boolean DEFAULT true NOT NULL,
    url character varying(255),
    settings text,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    "titleTranslationMethod" character varying(255) DEFAULT 'site'::character varying NOT NULL,
    "titleTranslationKeyFormat" text
);


ALTER TABLE public.volumes OWNER TO postgres;

--
-- Name: volumes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.volumes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volumes_id_seq OWNER TO postgres;

--
-- Name: volumes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.volumes_id_seq OWNED BY public.volumes.id;


--
-- Name: widgets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.widgets (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    type character varying(255) NOT NULL,
    "sortOrder" smallint,
    colspan smallint,
    settings text,
    enabled boolean DEFAULT true NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.widgets OWNER TO postgres;

--
-- Name: widgets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.widgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.widgets_id_seq OWNER TO postgres;

--
-- Name: widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.widgets_id_seq OWNED BY public.widgets.id;


--
-- Name: assetindexdata id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assetindexdata ALTER COLUMN id SET DEFAULT nextval('public.assetindexdata_id_seq'::regclass);


--
-- Name: assettransformindex id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assettransformindex ALTER COLUMN id SET DEFAULT nextval('public.assettransformindex_id_seq'::regclass);


--
-- Name: assettransforms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assettransforms ALTER COLUMN id SET DEFAULT nextval('public.assettransforms_id_seq'::regclass);


--
-- Name: categorygroups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorygroups ALTER COLUMN id SET DEFAULT nextval('public.categorygroups_id_seq'::regclass);


--
-- Name: categorygroups_sites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorygroups_sites ALTER COLUMN id SET DEFAULT nextval('public.categorygroups_sites_id_seq'::regclass);


--
-- Name: content id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content ALTER COLUMN id SET DEFAULT nextval('public.content_id_seq'::regclass);


--
-- Name: craftidtokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.craftidtokens ALTER COLUMN id SET DEFAULT nextval('public.craftidtokens_id_seq'::regclass);


--
-- Name: deprecationerrors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deprecationerrors ALTER COLUMN id SET DEFAULT nextval('public.deprecationerrors_id_seq'::regclass);


--
-- Name: drafts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drafts ALTER COLUMN id SET DEFAULT nextval('public.drafts_id_seq'::regclass);


--
-- Name: elementindexsettings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elementindexsettings ALTER COLUMN id SET DEFAULT nextval('public.elementindexsettings_id_seq'::regclass);


--
-- Name: elements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements ALTER COLUMN id SET DEFAULT nextval('public.elements_id_seq'::regclass);


--
-- Name: elements_sites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements_sites ALTER COLUMN id SET DEFAULT nextval('public.elements_sites_id_seq'::regclass);


--
-- Name: entrytypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrytypes ALTER COLUMN id SET DEFAULT nextval('public.entrytypes_id_seq'::regclass);


--
-- Name: fieldgroups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldgroups ALTER COLUMN id SET DEFAULT nextval('public.fieldgroups_id_seq'::regclass);


--
-- Name: fieldlayoutfields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayoutfields ALTER COLUMN id SET DEFAULT nextval('public.fieldlayoutfields_id_seq'::regclass);


--
-- Name: fieldlayouts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayouts ALTER COLUMN id SET DEFAULT nextval('public.fieldlayouts_id_seq'::regclass);


--
-- Name: fieldlayouttabs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayouttabs ALTER COLUMN id SET DEFAULT nextval('public.fieldlayouttabs_id_seq'::regclass);


--
-- Name: fields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fields ALTER COLUMN id SET DEFAULT nextval('public.fields_id_seq'::regclass);


--
-- Name: globalsets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.globalsets ALTER COLUMN id SET DEFAULT nextval('public.globalsets_id_seq'::regclass);


--
-- Name: gqlschemas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gqlschemas ALTER COLUMN id SET DEFAULT nextval('public.gqlschemas_id_seq'::regclass);


--
-- Name: gqltokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gqltokens ALTER COLUMN id SET DEFAULT nextval('public.gqltokens_id_seq'::regclass);


--
-- Name: info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info ALTER COLUMN id SET DEFAULT nextval('public.info_id_seq'::regclass);


--
-- Name: matrixblocktypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matrixblocktypes ALTER COLUMN id SET DEFAULT nextval('public.matrixblocktypes_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: plugins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plugins ALTER COLUMN id SET DEFAULT nextval('public.plugins_id_seq'::regclass);


--
-- Name: queue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.queue ALTER COLUMN id SET DEFAULT nextval('public.queue_id_seq'::regclass);


--
-- Name: relations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relations ALTER COLUMN id SET DEFAULT nextval('public.relations_id_seq'::regclass);


--
-- Name: revisions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revisions ALTER COLUMN id SET DEFAULT nextval('public.revisions_id_seq'::regclass);


--
-- Name: sections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);


--
-- Name: sections_sites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections_sites ALTER COLUMN id SET DEFAULT nextval('public.sections_sites_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: shunnedmessages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shunnedmessages ALTER COLUMN id SET DEFAULT nextval('public.shunnedmessages_id_seq'::regclass);


--
-- Name: sitegroups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sitegroups ALTER COLUMN id SET DEFAULT nextval('public.sitegroups_id_seq'::regclass);


--
-- Name: sites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites ALTER COLUMN id SET DEFAULT nextval('public.sites_id_seq'::regclass);


--
-- Name: structureelements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structureelements ALTER COLUMN id SET DEFAULT nextval('public.structureelements_id_seq'::regclass);


--
-- Name: structures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structures ALTER COLUMN id SET DEFAULT nextval('public.structures_id_seq'::regclass);


--
-- Name: systemmessages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systemmessages ALTER COLUMN id SET DEFAULT nextval('public.systemmessages_id_seq'::regclass);


--
-- Name: taggroups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taggroups ALTER COLUMN id SET DEFAULT nextval('public.taggroups_id_seq'::regclass);


--
-- Name: templatecacheelements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecacheelements ALTER COLUMN id SET DEFAULT nextval('public.templatecacheelements_id_seq'::regclass);


--
-- Name: templatecachequeries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecachequeries ALTER COLUMN id SET DEFAULT nextval('public.templatecachequeries_id_seq'::regclass);


--
-- Name: templatecaches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecaches ALTER COLUMN id SET DEFAULT nextval('public.templatecaches_id_seq'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: usergroups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroups ALTER COLUMN id SET DEFAULT nextval('public.usergroups_id_seq'::regclass);


--
-- Name: usergroups_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroups_users ALTER COLUMN id SET DEFAULT nextval('public.usergroups_users_id_seq'::regclass);


--
-- Name: userpermissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions ALTER COLUMN id SET DEFAULT nextval('public.userpermissions_id_seq'::regclass);


--
-- Name: userpermissions_usergroups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions_usergroups ALTER COLUMN id SET DEFAULT nextval('public.userpermissions_usergroups_id_seq'::regclass);


--
-- Name: userpermissions_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions_users ALTER COLUMN id SET DEFAULT nextval('public.userpermissions_users_id_seq'::regclass);


--
-- Name: userpreferences userId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpreferences ALTER COLUMN "userId" SET DEFAULT nextval('public."userpreferences_userId_seq"'::regclass);


--
-- Name: volumefolders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volumefolders ALTER COLUMN id SET DEFAULT nextval('public.volumefolders_id_seq'::regclass);


--
-- Name: volumes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volumes ALTER COLUMN id SET DEFAULT nextval('public.volumes_id_seq'::regclass);


--
-- Name: widgets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.widgets ALTER COLUMN id SET DEFAULT nextval('public.widgets_id_seq'::regclass);


--
-- Data for Name: assetindexdata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assetindexdata (id, "sessionId", "volumeId", uri, size, "timestamp", "recordId", "inProgress", completed, "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assets (id, "volumeId", "folderId", "uploaderId", filename, kind, width, height, size, "focalPoint", "deletedWithVolume", "keptFile", "dateModified", "dateCreated", "dateUpdated", uid) FROM stdin;
200	1	1	16	9.jpg	image	128	128	5517	\N	\N	\N	2021-01-27 16:20:44	2021-01-27 16:20:44	2021-01-27 16:20:44	cd638235-544c-40a8-a3dc-3f48e7944f21
201	1	1	16	20.jpg	image	128	128	5898	\N	\N	\N	2021-01-27 16:20:44	2021-01-27 16:20:44	2021-01-27 16:20:44	a3c13960-9006-4878-aa0c-4291f5330ed8
202	1	1	16	44.jpg	image	128	128	3539	\N	\N	\N	2021-01-27 16:20:45	2021-01-27 16:20:45	2021-01-27 16:20:45	a927c27e-ba16-4fc8-9633-9939580fe7e1
203	1	1	16	56.jpg	image	128	128	5160	\N	\N	\N	2021-01-27 16:20:46	2021-01-27 16:20:46	2021-01-27 16:20:46	5c646487-fa45-4092-b175-be190d59f94f
204	1	1	16	89.jpg	image	128	128	5586	\N	\N	\N	2021-01-27 16:20:47	2021-01-27 16:20:47	2021-01-27 16:20:47	4bef772d-008b-40f9-835e-c51c9ab69b71
\.


--
-- Data for Name: assettransformindex; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assettransformindex (id, "assetId", filename, format, location, "volumeId", "fileExists", "inProgress", error, "dateIndexed", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: assettransforms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assettransforms (id, name, handle, mode, "position", width, height, format, quality, interlace, "dimensionChangeTime", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, "groupId", "parentId", "deletedWithGroup", "dateCreated", "dateUpdated", uid) FROM stdin;
138	1	\N	\N	2021-01-22 14:35:35	2021-01-22 14:35:35	48969189-0d6f-4621-9fcc-ef4330204727
139	1	\N	\N	2021-01-22 14:36:57	2021-01-22 14:36:57	1146bd39-fc6d-404c-9342-0ee00b507385
140	1	\N	\N	2021-01-22 14:37:31	2021-01-22 14:37:31	82d9ed08-2e1b-4543-9113-615075324a84
141	1	\N	\N	2021-01-22 14:37:36	2021-01-22 14:37:36	9ff95a15-8c65-45d6-ac4a-a2fdd76c7b41
142	1	\N	\N	2021-01-22 14:37:42	2021-01-22 14:37:42	f8252052-aac3-4015-af1a-6df02a529137
143	1	\N	\N	2021-01-22 14:37:51	2021-01-22 14:37:51	311755f1-fedd-4e9c-884f-7fd114599a2b
144	1	\N	\N	2021-01-22 14:37:54	2021-01-22 14:37:54	8bfa534a-f53e-46ae-ab0e-e8e4da39bada
145	1	\N	\N	2021-01-22 14:37:57	2021-01-22 14:37:57	9dfc2e32-eaaa-4c73-9fa5-44cd3cbc60a8
146	1	\N	\N	2021-01-22 14:38:01	2021-01-22 14:38:01	2583ad0c-f1b8-4464-87fa-4fa168963b0a
163	1	\N	\N	2021-01-25 14:32:37	2021-01-25 14:32:37	bb288948-4bd1-45bc-9663-c1434aa61252
164	1	\N	\N	2021-01-25 14:32:52	2021-01-25 14:32:52	4c0b6fcb-ba94-45f0-a530-12228b852859
165	1	\N	\N	2021-01-25 14:32:55	2021-01-25 14:32:55	d00ce9bf-7fca-438d-921a-83ac463579d7
166	1	\N	\N	2021-01-25 14:32:59	2021-01-25 14:32:59	c0599cac-aede-45c6-bc65-1172a71ff441
167	1	\N	\N	2021-01-25 14:33:02	2021-01-25 14:33:02	8778e1ea-6bf8-40d5-8e8b-516fa7605402
168	1	\N	\N	2021-01-25 14:33:18	2021-01-25 14:33:18	953fe4bc-3151-4c07-9ef6-cca64f9ea9df
169	1	\N	\N	2021-01-25 14:33:21	2021-01-25 14:33:21	5d3f8941-7d81-4e65-a07f-1f977d9be9c3
170	1	\N	\N	2021-01-25 14:33:25	2021-01-25 14:33:25	de59f63f-cac7-469f-aff6-18bb22c1e733
171	1	\N	\N	2021-01-25 14:33:28	2021-01-25 14:33:28	ac48cae8-a8a6-42b4-8a34-a58a50a18f86
172	1	\N	\N	2021-01-25 14:33:30	2021-01-25 14:33:30	bcc93fe2-650c-40d1-9e8d-175def45e062
173	1	\N	\N	2021-01-25 14:33:33	2021-01-25 14:33:33	e17f388d-d954-4d30-a2eb-14479b2af343
174	2	\N	\N	2021-01-25 14:34:47	2021-01-25 14:34:47	f62a3be4-5691-4f06-9c9d-26e3cb23caaa
175	2	\N	\N	2021-01-25 14:34:50	2021-01-25 14:34:50	b254b0ce-4969-47c6-b63f-a065d6831ebb
176	2	\N	\N	2021-01-25 14:34:52	2021-01-25 14:34:52	a80b9089-aaea-4df3-b7be-44b18d412e2b
177	2	\N	\N	2021-01-25 14:34:55	2021-01-25 14:34:55	c46dc580-cbc2-4e3a-b91d-709ae257198b
178	2	\N	\N	2021-01-25 14:34:58	2021-01-25 14:34:58	c908dd0d-0c06-4f7d-940d-2a3f0a062261
179	2	\N	\N	2021-01-25 14:35:01	2021-01-25 14:35:01	6a061209-ded0-4dff-88de-0a850b7408c7
180	2	\N	\N	2021-01-25 14:35:03	2021-01-25 14:35:03	c5b806fa-0dff-4082-aa33-11ed23af9da8
181	2	\N	\N	2021-01-25 14:35:08	2021-01-25 14:35:08	448a047b-1ef5-4824-9155-bad9c218c2f7
197	3	\N	\N	2021-01-27 15:42:26	2021-01-27 15:42:26	d15523f1-8e33-434d-92db-0c95ab2e998f
\.


--
-- Data for Name: categorygroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorygroups (id, "structureId", "fieldLayoutId", name, handle, "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
1	1	8	Kategorie	categories	2021-01-22 14:35:05	2021-01-22 14:35:05	\N	61b9cdf6-219a-4096-b35b-538d624e1ba9
2	2	13	Tags	tags	2021-01-25 14:34:23	2021-01-25 14:38:57	\N	68aee50b-ea3a-4325-aed3-211fef3f4db3
3	3	22	VDW Nomenklatur	product_categories	2021-01-27 15:40:44	2021-01-27 15:40:44	\N	c01c0c86-571a-4af8-a30b-622e93d627d3
\.


--
-- Data for Name: categorygroups_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorygroups_sites (id, "groupId", "siteId", "hasUrls", "uriFormat", template, "dateCreated", "dateUpdated", uid) FROM stdin;
2	1	2	t	kategorie/{slug}	\N	2021-01-22 14:35:05	2021-01-22 14:35:05	232d7c29-68e1-43cb-bf2a-f516c119fc09
3	1	1	t	kategorie/{slug}	\N	2021-01-22 14:35:05	2021-01-22 14:35:05	9fa2b6c4-59c4-40a5-a47b-eb4147ee0d87
4	2	2	t	tags/{slug}	\N	2021-01-25 14:34:23	2021-01-25 14:34:23	2ecab644-b3c4-4bd0-b26d-09253f124bf7
5	2	1	t	tags/{slug}	\N	2021-01-25 14:34:23	2021-01-25 14:34:23	c5728183-47e9-4991-a8a7-98e76218a867
6	3	2	t	nomenclature/{slug}	\N	2021-01-27 15:40:44	2021-01-27 15:40:44	2b941cc7-d204-4f73-900d-fd459506bad3
7	3	1	t	nomenklatur/{slug}	\N	2021-01-27 15:40:44	2021-01-27 15:40:44	4bcf4656-c34b-4276-83b7-2e650406e344
\.


--
-- Data for Name: changedattributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.changedattributes ("elementId", "siteId", attribute, "dateUpdated", propagated, "userId") FROM stdin;
211	2	title	2021-02-01 16:00:58	t	16
211	1	title	2021-02-01 16:00:58	f	16
\.


--
-- Data for Name: changedfields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.changedfields ("elementId", "siteId", "fieldId", "dateUpdated", propagated, "userId") FROM stdin;
\.


--
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content (id, "elementId", "siteId", title, "dateCreated", "dateUpdated", uid, field_body, field_excerpt, field_videohtml, field_faq, field_meta_titel, field_meta_description, field_person_firstname, field_person_lastname, field_person_salutation, field_person_position, field_email, field_phone, field_facebook, field_twitter, field_xing, field_linkedin, field_person_title, field_article_date_old, field_event_date_old, field_hall, field_booth, field_event_date, field_article_date, field_address_name, field_address_street, field_address_postalcode, field_address_city, field_address_country, field_website, field_fax, field_person_email, field_instagram, field_youtube, field_industryarena, field_vdw_id, field_vdw_auftrag, field_event_year, field_sektor_id, field_body_raw) FROM stdin;
280	200	1	9	2021-01-27 16:20:43	2021-01-27 16:40:12	564dc782-205b-42f8-9d92-031e673a6721	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
281	200	2	9	2021-01-27 16:20:44	2021-01-27 16:40:12	e7269969-cbde-4814-9926-f1c1db06c8a1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
290	205	1	\N	2021-01-27 17:12:06	2021-01-27 17:12:06	7c0e2d65-d040-4991-a84e-5147e1d10d03	\N	\N	\N	\N	\N	\N	\N	\N	mr	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019	\N	\N
291	205	2	\N	2021-01-27 17:12:06	2021-01-27 17:12:06	ebf0117f-b704-46ab-b444-49494b98ec75	\N	\N	\N	\N	\N	\N	\N	\N	mr	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019	\N	\N
298	210	1	aaaaa	2021-02-01 15:49:53	2021-02-01 15:49:53	d0703e64-f463-4367-a5c4-0c0ea7e14028	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
299	210	2	aaaaa	2021-02-01 15:49:53	2021-02-01 15:49:53	58cecb1f-797d-403e-a8d2-0b7facfd6f4c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
158	139	1	Journalisten	2021-01-22 14:36:57	2021-01-22 14:36:57	cd9081fe-7943-4867-b5cc-007511164fb2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
25	25	1	\N	2020-11-25 12:17:58	2020-11-25 12:17:58	1e00ca07-3698-4801-a277-de3815ba03ac	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
159	139	2	Journalisten	2021-01-22 14:36:57	2021-01-22 14:36:57	434c7788-4ca0-4a4d-9f17-40b83e1e8d7b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
16	16	1	\N	2020-11-25 10:51:51	2021-01-18 15:01:55	885cf513-a748-4be2-830b-cf064188da0c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	1	1	\N	2020-11-25 10:32:44	2020-12-11 15:04:23	359e9bc3-34ba-4c19-81c6-050ec0814f4d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
170	143	1	Veranstaltungsart	2021-01-22 14:37:51	2021-01-22 14:37:51	58f9f557-261b-4a73-bd88-be35fae05287	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
171	143	2	Veranstaltungsart	2021-01-22 14:37:51	2021-01-22 14:37:51	8a20c3cd-9d94-4e7c-9967-6a5fe7421686	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
161	140	1	Besucher	2021-01-22 14:37:31	2021-01-22 14:37:31	1f0304ac-f8f7-4bb0-98d2-a49e60898d1e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
162	140	2	Besucher	2021-01-22 14:37:31	2021-01-22 14:37:31	af670a92-477b-4eb7-9d1a-d36f66d63788	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
282	201	1	20	2021-01-27 16:20:44	2021-01-27 16:40:10	bd5fcb35-ba2d-4d11-a0f8-1ef6f598f382	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
176	145	1	Foren	2021-01-22 14:37:57	2021-01-22 14:37:57	59527709-6b01-4245-a2ba-05d45d66252f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
177	145	2	Foren	2021-01-22 14:37:57	2021-01-22 14:37:57	87ce2cb4-59c3-4b55-960d-d1164f5cf0f7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
283	201	2	20	2021-01-27 16:20:44	2021-01-27 16:40:10	f733afee-8eba-49ed-b9ce-81ce0d9178b4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
292	206	1	\N	2021-01-29 13:25:13	2021-01-29 13:25:13	9300342e-b2a5-4e74-803e-91f35db30140	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
300	211	1	asdsa_updated	2021-02-01 15:55:26	2021-02-01 16:00:58	d58a6b77-b423-4851-81b0-d9c703ccbf22	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
301	211	2	asdsa_updated	2021-02-01 15:55:26	2021-02-01 16:00:58	53fc0dee-2ceb-464e-bd1b-954f1ba7641f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
195	153	1	\N	2021-01-22 15:08:41	2021-01-22 15:08:41	e45692b1-07f7-4909-8435-79f79e280577	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
191	151	2	\N	2021-01-22 14:57:13	2021-01-22 14:57:44	3b63d12b-0749-4a5a-873d-f993d142698e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
192	151	1	\N	2021-01-22 14:57:13	2021-01-22 14:57:44	eea22622-6e0f-461d-bf92-29d5e5882d54	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
284	202	1	44	2021-01-27 16:20:45	2021-01-27 16:40:11	5f1cd4a3-5d00-442d-9fe4-ac4411c76623	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
285	202	2	44	2021-01-27 16:20:45	2021-01-27 16:40:11	dd212c63-96ea-4858-8227-21da779145c0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
293	207	1	\N	2021-01-29 13:25:49	2021-01-29 13:25:49	83ca4acd-f4b7-4cff-9cdd-52b9fd8a79cb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
302	212	1	asdsa_updated	2021-02-01 16:02:06	2021-02-01 16:02:06	997426f7-9603-4b35-82be-28d9ee7c1d08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
303	212	2	asdsa_updated	2021-02-01 16:02:07	2021-02-01 16:02:07	281eaeec-a073-4c3d-ad19-f6483d7cbb3c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
164	141	1	Aussteller	2021-01-22 14:37:36	2021-01-22 14:37:36	f3509a68-325b-49ab-b6f8-56180a3b4fb1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
165	141	2	Aussteller	2021-01-22 14:37:36	2021-01-22 14:37:36	8a61bfee-a718-4bd2-a827-fcf223aa1aee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
173	144	1	Konferrenz	2021-01-22 14:37:54	2021-01-22 14:37:54	7ac15216-20c9-4fe5-b6d1-2cb3ace0d7ec	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
174	144	2	Konferrenz	2021-01-22 14:37:54	2021-01-22 14:37:54	10e47d6b-4e46-474d-8d96-21dff8d52726	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
156	138	2	Target groups	2021-01-22 14:35:35	2021-01-22 14:36:16	041574f5-4824-40bd-ac38-d6dbcc8da8f5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
155	138	1	Zielgruppen	2021-01-22 14:35:35	2021-01-22 14:36:16	3b2d6a98-61f6-498e-91dd-5385361119b7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	142	1	Dienstleister	2021-01-22 14:37:42	2021-01-22 14:37:42	e3034dd8-8f71-4a96-898f-262de10fd615	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
168	142	2	Dienstleister	2021-01-22 14:37:42	2021-01-22 14:37:42	a7065fac-29d0-4a45-9432-2ca0a7ed2e25	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	146	1	Sonderschau	2021-01-22 14:38:01	2021-01-22 14:38:01	4f233b8d-9913-4908-9052-4c1ba54eb90f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
180	146	2	Sonderschau	2021-01-22 14:38:01	2021-01-22 14:38:01	ffd0dff9-0ab5-47b2-bef6-c282727d9f7f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
286	203	1	56	2021-01-27 16:20:46	2021-01-27 16:40:11	06205ba1-6d8a-463b-980a-ad2c623c13df	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
287	203	2	56	2021-01-27 16:20:46	2021-01-27 16:40:11	6927f58b-a9f0-4153-848d-0bc587644c96	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
294	208	1	\N	2021-01-29 15:14:25	2021-01-29 15:14:25	db81c287-20d4-4a8d-8f53-cbaf255addaa	\N	\N	\N	\N	\N	\N	\N	\N	mr	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019	\N	\N
295	208	2	\N	2021-01-29 15:14:25	2021-01-29 15:14:25	5e0d5312-4689-48c8-b4de-f6b6867a3a13	\N	\N	\N	\N	\N	\N	\N	\N	mr	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019	\N	\N
151	136	1	\N	2021-01-22 14:24:09	2021-01-22 14:24:09	024a8c1a-8691-41e9-82e0-f5a644a05933	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
152	137	1	\N	2021-01-22 14:26:15	2021-01-22 14:26:15	2e4871d5-67fd-4d32-b0e7-abee2f0cd49f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
153	137	2	\N	2021-01-22 14:26:15	2021-01-22 14:26:15	5c5175a7-ffcf-489b-98fe-28049426eaca	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
220	168	2	Persona	2021-01-25 14:33:18	2021-01-25 14:33:18	0a3feb47-8c13-4c9c-8365-538d40c83b93	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
221	169	1	Moderator	2021-01-25 14:33:21	2021-01-25 14:33:21	54f3332f-8b1b-4e61-af71-724525f8b64b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
222	169	2	Moderator	2021-01-25 14:33:22	2021-01-25 14:33:22	998ded97-6434-4c0c-ae21-cd835920f94d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
223	170	1	Speaker	2021-01-25 14:33:25	2021-01-25 14:33:25	88ece581-b052-43f8-a15c-38be8f287532	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
224	170	2	Speaker	2021-01-25 14:33:25	2021-01-25 14:33:25	c4b6f5e0-3831-4236-b2b1-cf4c27dfb3d8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
225	171	1	Anprechpartner	2021-01-25 14:33:28	2021-01-25 14:33:28	3c1d36a3-b828-4032-9440-e7f251fce443	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
226	171	2	Anprechpartner	2021-01-25 14:33:28	2021-01-25 14:33:28	6cd1b760-388d-48b2-a8d6-55aa8a8dbb39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
197	155	1	\N	2021-01-22 15:31:12	2021-01-22 15:50:27	bf44852d-e869-49f9-8ce0-d45bcb63ce01	\N	\N	\N	[]	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
227	172	1	Redakteur	2021-01-25 14:33:30	2021-01-25 14:33:30	35fd77d0-0bac-4a75-b131-fbc88fd001e0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
228	172	2	Redakteur	2021-01-25 14:33:30	2021-01-25 14:33:30	a2bc6e0c-97ed-4fa0-b212-a5c6d0754823	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
229	173	1	Messe-Team	2021-01-25 14:33:33	2021-01-25 14:33:33	d8dc7913-3fb8-4ec3-aa8e-32cd5a0ad7d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
230	173	2	Messe-Team	2021-01-25 14:33:33	2021-01-25 14:33:33	49285aed-4661-4f65-973d-844cbeb622f1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
231	174	1	Software	2021-01-25 14:34:47	2021-01-25 14:34:47	48aedc5e-4a38-4f41-9003-244b90b6b766	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
232	174	2	Software	2021-01-25 14:34:48	2021-01-25 14:34:48	ec686e2a-2957-41e2-86cc-22b58e035a15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
233	175	1	Intern	2021-01-25 14:34:50	2021-01-25 14:34:50	f5e60219-718b-4348-8feb-f8fea16725e4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
234	175	2	Intern	2021-01-25 14:34:50	2021-01-25 14:34:50	bb6ccbfe-1b79-4a4f-b3e2-6dfb645582ee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
235	176	1	Highlight	2021-01-25 14:34:52	2021-01-25 14:34:52	cf946efd-fb22-4ec1-aea9-45029b33ad00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
236	176	2	Highlight	2021-01-25 14:34:53	2021-01-25 14:34:53	7374b51b-f983-4c6e-a208-bc1e01fde053	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
237	177	1	Presse	2021-01-25 14:34:55	2021-01-25 14:34:55	724d12a4-ca69-45cb-91d3-383cd25ba7ee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
206	160	1	\N	2021-01-22 15:57:12	2021-01-22 16:05:04	d9e4d5d9-928f-43d6-aad1-de8d227b77e9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
238	177	2	Presse	2021-01-25 14:34:56	2021-01-25 14:34:56	fc4dcf7e-3541-433e-900c-241627d2e0d1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
239	178	1	Milano	2021-01-25 14:34:58	2021-01-25 14:34:58	c209321b-2629-4e56-81cf-ddf27634d6ec	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
240	178	2	Milano	2021-01-25 14:34:58	2021-01-25 14:34:58	744e1118-f54a-4b2c-a29f-fa5c78d12fee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
241	179	1	Zerspanung	2021-01-25 14:35:01	2021-01-25 14:35:01	c78ee610-37eb-42a9-b2c2-b731ad537039	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
242	179	2	Zerspanung	2021-01-25 14:35:01	2021-01-25 14:35:01	e1487a4c-4235-49c9-990c-f4c9ddd869c6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
243	180	1	Schieblehre	2021-01-25 14:35:03	2021-01-25 14:35:03	fd5d388b-bf11-4bd6-b4e9-6d89617c4f9f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
244	180	2	Schieblehre	2021-01-25 14:35:03	2021-01-25 14:35:03	290c62d1-5743-49a3-9579-1bca85947955	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
207	161	1	\N	2021-01-22 16:27:22	2021-01-22 16:28:26	766f1d0e-273a-44a2-a52a-3e3e2c725b26	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
208	162	1	\N	2021-01-22 16:41:40	2021-01-22 16:41:40	7360e735-d6c9-4209-a1cd-3b85bc4b297d	\N	\N	\N	[]	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
209	163	1	Themengebiete	2021-01-25 14:32:37	2021-01-25 14:32:37	10e5a556-390f-41c6-a87b-4ea0a1dccdee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
210	163	2	Themengebiete	2021-01-25 14:32:38	2021-01-25 14:32:38	ed0bd1d7-1e75-4cd6-b881-5efa064cc952	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
211	164	1	Elektrotechnik und Elektronik	2021-01-25 14:32:52	2021-01-25 14:32:52	e0b3ddd4-4c77-4b0d-9fc8-11a6bb46c079	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
212	164	2	Elektrotechnik und Elektronik	2021-01-25 14:32:52	2021-01-25 14:32:52	b174b472-a340-41e3-83dd-1302c77de848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
213	165	1	Automobilindustrie und Zulieferer	2021-01-25 14:32:55	2021-01-25 14:32:55	84ed348d-4ced-4567-9739-54404f82cee4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
214	165	2	Automobilindustrie und Zulieferer	2021-01-25 14:32:55	2021-01-25 14:32:55	c6a48bf2-c2ba-4e2f-9042-95b79059814e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
215	166	1	Bearbeitung und Verarbeitung neuer Werkstoffe	2021-01-25 14:32:59	2021-01-25 14:32:59	08b31729-5b5d-4380-9e52-ee384c6fcee7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
216	166	2	Bearbeitung und Verarbeitung neuer Werkstoffe	2021-01-25 14:32:59	2021-01-25 14:32:59	977181c3-3dda-40ca-a69d-996e174c9432	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
217	167	1	Feinmechanik und Optik	2021-01-25 14:33:02	2021-01-25 14:33:02	c1d38bdc-7af4-4f45-8965-6799cd48dd64	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
218	167	2	Feinmechanik und Optik	2021-01-25 14:33:02	2021-01-25 14:33:02	79f61d8d-755d-4c06-92c8-6bd4df5eeeeb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
219	168	1	Persona	2021-01-25 14:33:18	2021-01-25 14:33:18	b33fe77c-196e-4beb-b97c-1dca49cf50da	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
245	181	1	EMO News	2021-01-25 14:35:08	2021-01-25 14:35:08	34c71f43-1955-4678-a82f-d06ee8a51798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
246	181	2	EMO News	2021-01-25 14:35:09	2021-01-25 14:35:09	05542b4d-e2f5-4dd4-90e1-8730dd3ab414	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
247	182	1	\N	2021-01-25 14:39:06	2021-01-25 14:39:26	555efff7-8656-4d44-81b0-d73c46184dbb	\N	\N	\N	[]	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
248	183	1	\N	2021-01-25 15:12:17	2021-01-25 15:12:17	8f43cd5c-c4e0-41c3-ae86-84838cbbf071	\N	\N	\N	[]	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
249	184	1	\N	2021-01-25 15:13:22	2021-01-25 15:13:22	36b9c667-f690-4dd6-9302-97514aae8c21	\N	\N	\N	[]	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
196	154	1	\N	2021-01-22 15:25:58	2021-01-22 15:26:30	66b9ac98-cb3a-4c99-931d-661d640941fd	\N	\N	n neuen Eintrag erstellen Titel title Tags tag_title Tags werden genutzt, um Inhalte und Themen zu kategorisieren  Kategorie blog_categories Inhalt body Downloads downloads Mediengallerie mediengallerie Videoeinbettung videoeinbettungn neuen Eintrag erstellen Titel title Tags tag_title Tags werden genutzt, um Inhalte und Themen zu kategorisieren  Kategorie blog_categories Inhalt body Downloads downloads Mediengallerie mediengallerie Videoeinbettung videoeinbettungn neuen Eintrag erstellen Titel title Tags tag_title Tags werden genutzt, um Inhalte und Themen zu kategorisieren  Kategorie blog_categories Inhalt body Downloads downloads Mediengallerie mediengallerie Videoeinbettung videoeinbettungn neuen Eintrag erstellen Titel title Tags tag_title Tags werden genutzt, um Inhalte und Themen zu kategorisieren  Kategorie blog_categories Inhalt body Downloads downloads Mediengallerie mediengallerie Videoeinbettung videoeinbettungn neuen Eintrag erstellen Titel title Tags tag_title Tags werden genutzt, um Inhalte und Themen zu kategorisieren  Kategorie blog_categories Inhalt body Downloads downloads Mediengallerie mediengallerie Videoeinbettung videoeinbettung	[{"col1":"dfsfs","col2":"sdfsf"},{"col1":"fsdfdsf","col2":"sdfsdf"}]	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
258	189	1	189	2021-01-25 17:01:32	2021-01-27 09:15:03	22134dc3-9803-42c8-b5c2-1a26791a74c4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	00:30:00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
259	189	2	189	2021-01-25 17:01:32	2021-01-27 09:15:03	9f14ad9c-b0c1-46d8-b0fb-94ba085785b2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	00:30:00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
252	186	1	\N	2021-01-25 16:29:28	2021-01-25 16:29:28	079d733d-0cde-40f6-b1d9-703d75763522	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
253	186	2	\N	2021-01-25 16:29:28	2021-01-25 16:29:28	e396f105-1008-4fa9-bc5e-b8a3e21ee372	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
254	187	1	\N	2021-01-25 16:34:20	2021-01-25 16:34:20	8beb1f1c-4c14-4b12-9a9d-c7044cdcfda9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
255	187	2	\N	2021-01-25 16:34:20	2021-01-25 16:34:20	2f6cbc35-f0d1-4647-b3bf-a06d370a65bf	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
256	188	1	\N	2021-01-25 16:38:43	2021-01-25 16:38:43	9262a402-b69f-454d-a4b3-ee5d523b6b0d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
257	188	2	\N	2021-01-25 16:38:43	2021-01-25 16:38:43	cf4606f0-f96e-4380-b536-1bf36acfd774	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
288	204	1	89	2021-01-27 16:20:47	2021-01-27 16:40:12	aa0b1240-0ca2-4afe-b443-8bcb0ba16820	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
289	204	2	89	2021-01-27 16:20:47	2021-01-27 16:40:12	86936609-62c1-45af-b269-115ae6329ced	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
260	190	1	190	2021-01-25 17:03:55	2021-01-27 09:15:03	0c543733-46e8-4a11-a04a-7e851ff94fda	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
261	190	2	190	2021-01-25 17:03:55	2021-01-27 09:15:03	526c3bce-892d-4a9f-9d3e-76432688d1e9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
275	197	2	Drehmaschinen	2021-01-27 15:42:26	2021-01-27 15:42:26	22b09c4b-c1fd-4144-9b72-11c15fb461f7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
262	191	1	\N	2021-01-27 08:49:43	2021-01-27 08:50:12	71abaf9c-b4ab-477a-9e2f-7128edaabc85	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2021-01-28 18:00:00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
263	191	2	\N	2021-01-27 08:49:43	2021-01-27 08:50:12	424fadaa-70ed-4dab-b169-bc196a28b30e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2021-01-28 18:00:00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
266	193	1	\N	2021-01-27 13:28:18	2021-01-27 13:28:18	4c6e44dd-8778-48a0-9707-7e4fed7f05c0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
267	193	2	\N	2021-01-27 13:28:18	2021-01-27 13:28:18	9e822fbe-1f6b-4dc5-9ac3-3a61a66d424f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
268	194	1	\N	2021-01-27 15:27:35	2021-01-27 15:27:35	6b464657-2851-4d1d-9050-a5204fc5464b	\N	\N	\N	\N	\N	\N	\N	\N	mr	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019	\N	\N
272	196	1	\N	2021-01-27 15:42:08	2021-01-27 15:42:30	3246e2c2-a252-4a68-b7ea-8a37e54ae05c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
273	196	2	\N	2021-01-27 15:42:08	2021-01-27 15:42:30	22fbedb3-cb75-43fa-9544-4513e07bd56f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
250	185	1	_mr___mr___mr___mr___mr___mr__	2021-01-25 15:33:25	2021-01-27 09:15:01	21686551-c1d0-4b27-86f6-9fb40d9cdafe	\N	\N	\N	\N	\N	\N	\N	\N	mr	geschaeftsfuehrerVorstandsmitglied	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
251	185	2	_mr___mr___mr___mr___mr___mr___mr__	2021-01-25 15:33:25	2021-01-27 09:15:01	ab97cf86-2e55-41e5-8d18-21236cb14945	\N	\N	\N	\N	\N	\N	\N	\N	mr	geschaeftsfuehrerVorstandsmitglied	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
269	194	2	\N	2021-01-27 15:27:35	2021-01-27 15:27:35	d050889b-14fc-4066-a7d5-046023410788	\N	\N	\N	\N	\N	\N	\N	\N	mr	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019	\N	\N
270	195	1	\N	2021-01-27 15:28:46	2021-01-27 15:28:46	701539fd-ea88-4d90-8495-80d39a861ca6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
271	195	2	\N	2021-01-27 15:28:46	2021-01-27 15:28:46	0c3d7fc5-55e8-43c6-b4e5-7973cebb28d8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
274	197	1	Drehmaschinen	2021-01-27 15:42:26	2021-01-27 15:42:26	e8f94c99-2c9f-4f6c-a6c3-7f12af52338f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
276	198	1	\N	2021-01-27 15:51:04	2021-01-27 15:51:04	2de7f34d-78fe-4d62-808a-62d1f4b7ec1f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
277	198	2	\N	2021-01-27 15:51:04	2021-01-27 15:51:04	2036ff1c-10f5-44b9-8288-d409b302c4bf	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
278	199	1	\N	2021-01-27 15:51:07	2021-01-27 15:51:07	6308b041-4ff3-480a-984b-85454433bc31	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
279	199	2	\N	2021-01-27 15:51:07	2021-01-27 15:51:07	1a6b021b-ccd3-42e2-b716-e0f3972cee3e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: craftidtokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.craftidtokens (id, "userId", "accessToken", "expiryDate", "dateCreated", "dateUpdated", uid) FROM stdin;
1	16	eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjMxNzhmYjkzMWU2NTEwZGYwYmExOTQ3ZDQ5YWNhYWM2NjgyYTUyN2JhNDEwMGQyM2ZjYTI5Njk5MDQwMGZiMjBhMjBkMjYzYTVhMWZiNzBlIn0.eyJhdWQiOiI2RHZFcmE3ZXFSS0xZaWM5Zm92eUQyRldGall4UndabiIsImp0aSI6IjMxNzhmYjkzMWU2NTEwZGYwYmExOTQ3ZDQ5YWNhYWM2NjgyYTUyN2JhNDEwMGQyM2ZjYTI5Njk5MDQwMGZiMjBhMjBkMjYzYTVhMWZiNzBlIiwiaWF0IjoxNjExNzY1Njg3LCJuYmYiOjE2MTE3NjU2ODcsImV4cCI6MTYxNDM1NzY4Nywic3ViIjoiNDI3MDY2Iiwic2NvcGVzIjpbInB1cmNoYXNlUGx1Z2lucyIsImV4aXN0aW5nUGx1Z2lucyIsInRyYW5zZmVyUGx1Z2luTGljZW5zZSIsImRlYXNzb2NpYXRlUGx1Z2luTGljZW5zZSJdfQ.XNXGp8rb-gmbbo_65cGMLlSFyOE8yScPs9G8zsyA29c-C4hihr4Oozo_kI-FcJUqyU3fbvj6uDBoKIKgNf4yYqJWkZRx8AslIGSdUVrC0x6Dkhd4OC6LFgM3dcSLyY1y_cG8c11_I87yKhvoA733FHy_uN2pleTMTgLyALuujlQ	2021-02-26 16:41:29	2021-01-27 16:41:29	2021-01-27 16:41:29	45a04924-a08b-4083-80f9-5c31e5c2109f
\.


--
-- Data for Name: deprecationerrors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deprecationerrors (id, key, fingerprint, "lastOccurrence", file, line, message, traces, "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: drafts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drafts (id, "sourceId", "creatorId", name, notes, "trackChanges", "dateLastMerged") FROM stdin;
27	\N	16	Erster Entwurf	\N	f	\N
28	\N	16	Erster Entwurf	\N	f	\N
29	\N	16	Erster Entwurf	\N	f	\N
19	\N	16	Erster Entwurf	\N	f	\N
32	\N	16	Erster Entwurf	\N	f	\N
26	\N	16	Erster Entwurf	\N	f	\N
20	\N	16	Erster Entwurf	\N	f	\N
5	\N	16	Erster Entwurf	\N	f	\N
30	\N	16	Erster Entwurf	\N	f	\N
31	\N	16	Erster Entwurf	\N	f	\N
33	\N	16	Erster Entwurf	\N	f	\N
34	\N	16	Erster Entwurf	\N	f	\N
35	\N	16	Erster Entwurf	\N	f	\N
21	\N	16	Erster Entwurf	\N	f	\N
22	\N	16	Erster Entwurf	\N	f	\N
14	\N	16	Erster Entwurf	\N	f	\N
15	\N	16	Erster Entwurf	\N	f	\N
36	\N	16	Erster Entwurf	\N	f	\N
16	\N	16	Erster Entwurf	\N	f	\N
17	\N	16	Erster Entwurf	\N	f	\N
23	\N	16	Erster Entwurf	\N	f	\N
24	\N	16	Erster Entwurf	\N	f	\N
25	\N	16	Erster Entwurf	\N	f	\N
37	\N	16	Erster Entwurf	\N	f	\N
18	\N	16	Erster Entwurf	\N	f	\N
38	\N	16	Erster Entwurf	\N	f	\N
39	\N	16	Erster Entwurf	\N	f	\N
40	\N	16	Erster Entwurf	\N	f	\N
\.


--
-- Data for Name: elementindexsettings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.elementindexsettings (id, type, settings, "dateCreated", "dateUpdated", uid) FROM stdin;
1	craft\\elements\\User	{"sources":{"*":{"tableAttributes":{"1":"id","2":"fullName","3":"email","4":"dateCreated","5":"lastLoginDate","6":"preferredLanguage"}},"group:b3ebc429-1aaf-4077-9b55-732d13785f99":{"tableAttributes":{"1":"id","2":"fullName","3":"email","4":"dateCreated","5":"lastLoginDate"}}}}	2020-12-04 09:30:00	2020-12-04 09:30:00	878a7cbe-b2fe-45ba-94c7-8e2d1dcdb3c8
8	craft\\elements\\Category	{"sources":{"group:61b9cdf6-219a-4096-b35b-538d624e1ba9":{"tableAttributes":[]},"group:68aee50b-ea3a-4325-aed3-211fef3f4db3":{"tableAttributes":[]}}}	2021-01-25 15:11:07	2021-01-25 15:11:07	359b4428-8bb3-413e-8bfe-932dd83b075d
3	craft\\elements\\Entry	{"sources":{"*":{"tableAttributes":{"1":"section","2":"postDate","3":"expiryDate","4":"author","5":"link"}},"section:ea25caf0-a9ce-415f-91f4-7c047d9b1933":{"tableAttributes":{"1":"postDate","2":"expiryDate","3":"author","4":"link","5":"field:9","6":"field:14"}},"section:f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c":{"tableAttributes":{"1":"postDate","2":"expiryDate","3":"author","4":"link"}},"section:0daaa545-d1a0-4655-a507-2bac8b560f1d":{"tableAttributes":{"1":"postDate","2":"expiryDate","3":"author","4":"link"}},"section:2a038e37-6c48-4746-8b6d-b27fabf7972f":{"tableAttributes":{"1":"postDate","2":"expiryDate","3":"author","4":"link"}}},"sourceOrder":[["key","*"],["heading","Inhalt"],["key","section:9b5bd243-bb29-4fea-81a4-e597852129b7"],["key","section:ea25caf0-a9ce-415f-91f4-7c047d9b1933"],["heading","Sonstiges"],["key","section:f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c"],["key","section:0daaa545-d1a0-4655-a507-2bac8b560f1d"],["key","section:06745480-8d8c-4976-934e-dc80b2ab5632"],["key","section:1b0aae41-58ef-4c4b-8749-6e8a8c98221d"],["key","section:2a038e37-6c48-4746-8b6d-b27fabf7972f"]]}	2021-01-27 15:29:15	2021-01-27 15:29:15	be493dac-e388-489b-a0b1-2f72d4b01a7c
\.


--
-- Data for Name: elements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.elements (id, "draftId", "revisionId", "fieldLayoutId", type, enabled, archived, "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
183	24	\N	9	craft\\elements\\Entry	t	f	2021-01-25 15:12:17	2021-01-25 15:12:17	\N	7784e9b6-0ede-4df6-9f8f-e41c13db77a1
187	28	\N	16	craft\\elements\\Entry	t	f	2021-01-25 16:34:20	2021-01-25 16:34:20	\N	523bbc80-4474-4329-8122-f1c90a5e345d
204	\N	\N	2	craft\\elements\\Asset	t	f	2021-01-27 16:20:47	2021-01-27 16:40:12	\N	5f1849b5-4781-4989-bba8-3992047f9c81
200	\N	\N	2	craft\\elements\\Asset	t	f	2021-01-27 16:20:43	2021-01-27 16:40:12	\N	3c066f69-ad70-4116-9a6d-2955666ebf8a
1	\N	\N	\N	craft\\elements\\User	t	f	2020-11-25 10:32:44	2020-12-11 15:04:23	2021-01-29 13:21:50	1641c826-c3d9-4115-a69e-3767b9bf8b51
208	40	\N	20	craft\\elements\\Entry	t	f	2021-01-29 15:14:25	2021-01-29 15:14:25	\N	93aa4774-23db-413b-81c9-4ee7f3807e53
212	\N	\N	21	craft\\elements\\Entry	t	f	2021-02-01 16:02:06	2021-02-01 16:02:06	\N	93ab84a7-7a9b-4e47-adc8-b10a02ca1e16
191	32	\N	17	craft\\elements\\Entry	t	f	2021-01-27 08:49:43	2021-01-27 08:50:12	\N	a10362e2-e7c5-428a-8584-bff2c84b4571
195	35	\N	21	craft\\elements\\Entry	t	f	2021-01-27 15:28:46	2021-01-27 15:28:46	\N	9b105f6a-bca9-4ff6-a544-e9e5598823f6
198	37	\N	21	craft\\elements\\Entry	t	f	2021-01-27 15:51:04	2021-01-27 15:51:04	\N	5f15e368-7c39-4037-b142-a0f7b237b7d7
25	5	\N	\N	craft\\elements\\Entry	t	f	2020-11-25 12:17:58	2020-11-25 12:17:58	\N	b8e0e652-827c-4ab9-b2a6-78dc94069531
184	25	\N	9	craft\\elements\\Entry	t	f	2021-01-25 15:13:22	2021-01-25 15:13:22	\N	0c887b2e-d287-4629-aaeb-de8be4267507
188	29	\N	14	craft\\elements\\Entry	t	f	2021-01-25 16:38:43	2021-01-25 16:38:43	\N	29230dac-dbab-4b29-8f6e-ce2d6d8eb708
201	\N	\N	2	craft\\elements\\Asset	t	f	2021-01-27 16:20:44	2021-01-27 16:40:10	\N	cf3da541-0421-4629-b3ed-fb04e55c621f
205	39	\N	20	craft\\elements\\Entry	t	f	2021-01-27 17:12:06	2021-01-27 17:12:06	\N	9977fcd4-d12a-49d9-a89a-08042dadd799
196	36	\N	21	craft\\elements\\Entry	t	f	2021-01-27 15:42:08	2021-01-27 15:42:30	\N	45bf87aa-4411-4c94-9133-da5cabb852c4
199	38	\N	21	craft\\elements\\Entry	t	f	2021-01-27 15:51:07	2021-01-27 15:51:07	\N	d800908b-faba-49b1-b88e-01aa2a59d9f1
16	\N	\N	\N	craft\\elements\\User	t	f	2020-11-25 10:51:51	2021-01-18 15:01:55	\N	11973cb3-e047-4c36-831e-6c4d776dde28
193	33	\N	20	craft\\elements\\Entry	t	f	2021-01-27 13:28:18	2021-01-27 13:28:18	\N	043a8901-d995-4cdb-912e-176c02516998
202	\N	\N	2	craft\\elements\\Asset	t	f	2021-01-27 16:20:45	2021-01-27 16:40:11	\N	65ddbad2-0eea-4121-b6b0-45fea1441f1b
206	\N	\N	\N	craft\\elements\\User	t	f	2021-01-29 13:25:13	2021-01-29 13:25:13	\N	cedbadac-c847-453a-b57d-06ac797991b3
210	\N	\N	21	craft\\elements\\Entry	t	f	2021-02-01 15:49:53	2021-02-01 15:49:53	\N	30a53c9c-ebad-4c98-aaf1-463296ef53c6
185	26	\N	15	craft\\elements\\Entry	t	f	2021-01-25 15:33:25	2021-01-27 09:15:01	\N	adbdf4da-0e9a-4968-b536-678fcc0d8519
189	30	\N	17	craft\\elements\\Entry	t	f	2021-01-25 17:01:32	2021-01-27 09:15:03	\N	7d099584-b9b5-464e-807e-1dbe5f6672b5
136	14	\N	\N	craft\\elements\\Entry	t	f	2021-01-22 14:24:09	2021-01-22 14:24:09	\N	f9fa50fd-6a09-4d47-afce-2012c8e42a41
137	15	\N	\N	craft\\elements\\Entry	t	f	2021-01-22 14:26:15	2021-01-22 14:26:15	\N	db858b59-c4ef-462c-9df1-b8dec2c8c82b
151	16	\N	\N	craft\\elements\\Entry	t	f	2021-01-22 14:57:13	2021-01-22 14:57:44	\N	477a5654-2436-4b78-9169-8d3c084f7466
138	\N	\N	8	craft\\elements\\Category	t	f	2021-01-22 14:35:35	2021-01-22 14:36:16	\N	ae71d544-42f2-4d73-bed2-49e578fe264b
139	\N	\N	8	craft\\elements\\Category	t	f	2021-01-22 14:36:57	2021-01-22 14:36:57	\N	10c5e985-48b2-48ab-9126-2ef1e9a7e579
140	\N	\N	8	craft\\elements\\Category	t	f	2021-01-22 14:37:31	2021-01-22 14:37:31	\N	704407ab-fac2-4340-b96d-3b99921fc2df
141	\N	\N	8	craft\\elements\\Category	t	f	2021-01-22 14:37:36	2021-01-22 14:37:36	\N	d9252db9-5ba8-4c50-b927-625f4e989166
142	\N	\N	8	craft\\elements\\Category	t	f	2021-01-22 14:37:42	2021-01-22 14:37:42	\N	8f2ca7a2-1551-423b-826f-2ca3adc9d02b
143	\N	\N	8	craft\\elements\\Category	t	f	2021-01-22 14:37:51	2021-01-22 14:37:51	\N	26a2b594-5136-47b4-affb-015cc56dc3a7
144	\N	\N	8	craft\\elements\\Category	t	f	2021-01-22 14:37:54	2021-01-22 14:37:54	\N	b1d2ff7a-314b-45b9-8b37-7ee23be0e31e
145	\N	\N	8	craft\\elements\\Category	t	f	2021-01-22 14:37:57	2021-01-22 14:37:57	\N	4212edff-dba4-4046-aa7b-0dc4b6c17a7a
146	\N	\N	8	craft\\elements\\Category	t	f	2021-01-22 14:38:01	2021-01-22 14:38:01	\N	5264b664-2d6a-4707-8085-5d29d8b0a24e
153	17	\N	9	craft\\elements\\Entry	t	f	2021-01-22 15:08:41	2021-01-22 15:08:41	\N	7e4f40f2-688e-4141-996c-ab9f076cc7f2
154	18	\N	9	craft\\elements\\Entry	t	f	2021-01-22 15:25:58	2021-01-22 15:26:30	\N	4323fca9-707a-4ca6-a6b2-c3b6b9793043
167	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:33:02	2021-01-25 14:33:02	\N	3a53bf36-2442-49fc-a4cd-3433b169aae2
161	21	\N	9	craft\\elements\\Entry	t	f	2021-01-22 16:27:22	2021-01-22 16:28:26	\N	3b400f88-6abd-455b-bfce-34b0b8ffc285
160	20	\N	9	craft\\elements\\Entry	t	f	2021-01-22 15:57:12	2021-01-22 16:05:04	\N	93862a84-3b35-4a59-baf7-e89a48640585
162	22	\N	9	craft\\elements\\Entry	t	f	2021-01-22 16:41:40	2021-01-22 16:41:40	\N	9cb6dc0d-4b71-41de-8203-dd9ad408751c
163	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:32:37	2021-01-25 14:32:37	\N	ad72a179-98b0-465b-9e3c-385d6c053d63
168	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:33:18	2021-01-25 14:33:18	\N	7f0622c5-1e48-4a3b-ace7-07bc63569d55
155	19	\N	9	craft\\elements\\Entry	t	f	2021-01-22 15:31:12	2021-01-22 15:50:27	\N	a06323d5-f1db-4e91-8bc1-09008a305feb
164	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:32:52	2021-01-25 14:32:52	\N	90e11ca0-3d92-4676-8105-43491db93166
165	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:32:55	2021-01-25 14:32:55	\N	e3ff90fb-d805-4d70-a266-9306444f1fd1
169	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:33:21	2021-01-25 14:33:21	\N	b9740a0c-75e8-4e09-9e84-07c531e90a8c
166	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:32:59	2021-01-25 14:32:59	\N	4047383d-691a-4597-a409-e8b2159567cb
170	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:33:25	2021-01-25 14:33:25	\N	dc97c4a5-85f7-4a0c-a6dc-c505bffb155e
171	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:33:27	2021-01-25 14:33:27	\N	c1221b07-be57-46a6-b93e-05827f7a77f3
172	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:33:30	2021-01-25 14:33:30	\N	7735ff2a-c261-49bd-8582-9346aa59019b
173	\N	\N	8	craft\\elements\\Category	t	f	2021-01-25 14:33:33	2021-01-25 14:33:33	\N	9119b403-706d-4450-9f7b-c3a65fea1a6a
174	\N	\N	13	craft\\elements\\Category	t	f	2021-01-25 14:34:47	2021-01-25 14:34:47	\N	cd76c1d2-bdec-4d09-9323-9489d807a72d
175	\N	\N	13	craft\\elements\\Category	t	f	2021-01-25 14:34:50	2021-01-25 14:34:50	\N	bef5f177-4eb2-481e-a5c3-68f3c1ee4c52
176	\N	\N	13	craft\\elements\\Category	t	f	2021-01-25 14:34:52	2021-01-25 14:34:52	\N	78d49c07-ae3b-4d13-b6fa-d63a3f265a23
177	\N	\N	13	craft\\elements\\Category	t	f	2021-01-25 14:34:55	2021-01-25 14:34:55	\N	ab51bf08-007d-4404-8654-9f21bc79e765
178	\N	\N	13	craft\\elements\\Category	t	f	2021-01-25 14:34:58	2021-01-25 14:34:58	\N	8527b2a6-a709-45d4-a6a3-36be5859da97
179	\N	\N	13	craft\\elements\\Category	t	f	2021-01-25 14:35:01	2021-01-25 14:35:01	\N	76ec4b38-fe40-402c-97f7-f400989a663b
180	\N	\N	13	craft\\elements\\Category	t	f	2021-01-25 14:35:03	2021-01-25 14:35:03	\N	4cea8411-18f0-4eaa-9af6-3f9f3a3cc1a5
181	\N	\N	13	craft\\elements\\Category	t	f	2021-01-25 14:35:08	2021-01-25 14:35:08	\N	d0a76e12-556b-4c69-9edc-573b9c55fc63
186	27	\N	16	craft\\elements\\Entry	t	f	2021-01-25 16:29:28	2021-01-25 16:29:28	\N	c1206fa3-106f-42f1-a845-5a18c1d75c51
182	23	\N	9	craft\\elements\\Entry	t	f	2021-01-25 14:39:06	2021-01-25 14:39:26	\N	0760a742-f961-443f-b7b3-2897168d9129
203	\N	\N	2	craft\\elements\\Asset	t	f	2021-01-27 16:20:46	2021-01-27 16:40:11	\N	24c6ac52-f409-42b9-a9c5-91099388b31c
207	\N	\N	\N	craft\\elements\\User	t	f	2021-01-29 13:25:49	2021-01-29 13:25:49	\N	c41357be-6e27-4bf7-bda8-29d23f370b1a
211	\N	\N	21	craft\\elements\\Entry	t	f	2021-02-01 15:55:26	2021-02-01 16:00:58	\N	20a96b60-5e47-4d6b-a78e-7e2c3ec91825
190	31	\N	17	craft\\elements\\Entry	t	f	2021-01-25 17:03:55	2021-01-27 09:15:03	\N	923364ff-8e47-4058-8c1f-05f0bbfb6b73
194	34	\N	20	craft\\elements\\Entry	t	f	2021-01-27 15:27:35	2021-01-27 15:27:35	\N	aa21bd54-6330-4e78-8817-f4f6580f500e
197	\N	\N	22	craft\\elements\\Category	t	f	2021-01-27 15:42:26	2021-01-27 15:42:26	\N	594e0f92-e305-4475-9a55-f3288fc49b58
\.


--
-- Data for Name: elements_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.elements_sites (id, "elementId", "siteId", slug, uri, enabled, "dateCreated", "dateUpdated", uid) FROM stdin;
1	1	1	\N	\N	t	2020-11-25 10:32:44	2020-11-25 10:32:44	2b6143d8-7a2f-4e29-b7a6-0e0aeed250fc
342	200	1	\N	\N	t	2021-01-27 16:20:43	2021-01-27 16:20:43	36984618-6694-412c-98b6-cf56df33ad2b
343	200	2	\N	\N	t	2021-01-27 16:20:44	2021-01-27 16:20:44	116a1294-5d55-4877-9efd-9f9f18e9d282
354	206	1	\N	\N	t	2021-01-29 13:25:13	2021-01-29 13:25:13	c8ed4233-3d18-4f4f-921f-3a65d5c99954
364	212	1	craft-graphql-mutations-1	produkte/craft-graphql-mutations-1	t	2021-02-01 16:02:06	2021-02-01 16:02:06	5a45df54-9578-46ae-ad59-4cd7979305ce
365	212	2	craft-graphql-mutations-1	products/craft-graphql-mutations-1	t	2021-02-01 16:02:07	2021-02-01 16:02:07	f161605b-49f7-45f9-9d17-ca71ebae292e
16	16	1	\N	\N	t	2020-11-25 10:51:51	2020-11-25 10:51:51	cc61b6e0-f149-42e2-9375-94a232fc77ea
25	25	1	__temp_ilaxhlnbwwppqbhvibdgzcjzmezbpegndldm	blogs/__temp_ilaxhlnbwwppqbhvibdgzcjzmezbpegndldm	t	2020-11-25 12:17:58	2020-11-25 12:17:58	a5c527da-ecbd-4d6c-b017-c3db54a648ee
344	201	1	\N	\N	t	2021-01-27 16:20:44	2021-01-27 16:20:44	074daaa4-2752-4edb-9fcb-58c0e438d9b5
345	201	2	\N	\N	t	2021-01-27 16:20:44	2021-01-27 16:20:44	d7221ec7-0a24-4929-b354-0d3a18bafc6c
355	207	1	\N	\N	t	2021-01-29 13:25:49	2021-01-29 13:25:49	252ced1d-cc6e-49de-be35-8a9aa5a8d69b
346	202	1	\N	\N	t	2021-01-27 16:20:45	2021-01-27 16:20:45	42440984-7783-42a9-9895-ebdc76b70320
347	202	2	\N	\N	t	2021-01-27 16:20:45	2021-01-27 16:20:45	31332904-8beb-42d9-a187-760fb5117b69
356	208	1	__temp_arhqwoxeswypwifozpgfrhesbpgjzhyxcevn	aussteller/__temp_arhqwoxeswypwifozpgfrhesbpgjzhyxcevn	t	2021-01-29 15:14:25	2021-01-29 15:14:25	667c565e-a9b6-4441-88d1-c2b19c68f143
357	208	2	__temp_arhqwoxeswypwifozpgfrhesbpgjzhyxcevn	exhibitors/__temp_arhqwoxeswypwifozpgfrhesbpgjzhyxcevn	t	2021-01-29 15:14:25	2021-01-29 15:14:25	f2b7c0bf-3e6c-4c74-ad77-8bf4518e470e
213	136	1	__temp_fzqhhlgffvyokjtdscbeachnkjfeykxpridu	blog_categories/__temp_fzqhhlgffvyokjtdscbeachnkjfeykxpridu	t	2021-01-22 14:24:09	2021-01-22 14:24:09	2614d932-fd7f-4920-8fc3-8eb7fba6dec6
214	137	1	__temp_kntcwvtdubbdrahyyoxyzbcitzzlgzbwlpsw	blog/__temp_kntcwvtdubbdrahyyoxyzbcitzzlgzbwlpsw	f	2021-01-22 14:26:15	2021-01-22 14:26:15	bcb093c7-b223-472c-bee7-5fd391af5aa4
215	137	2	__temp_kntcwvtdubbdrahyyoxyzbcitzzlgzbwlpsw	eng_blog/__temp_kntcwvtdubbdrahyyoxyzbcitzzlgzbwlpsw	f	2021-01-22 14:26:15	2021-01-22 14:26:15	4ee8c432-7692-4356-b905-efe1fc975222
348	203	1	\N	\N	t	2021-01-27 16:20:46	2021-01-27 16:20:46	2c72064d-f728-4d34-8402-7ac06674a332
349	203	2	\N	\N	t	2021-01-27 16:20:46	2021-01-27 16:20:46	7ac5f534-77fb-4fd1-bc98-f51d188c80c1
350	204	1	\N	\N	t	2021-01-27 16:20:47	2021-01-27 16:20:47	28497ab6-80e8-4893-82b1-fa5f83e958f5
351	204	2	\N	\N	t	2021-01-27 16:20:47	2021-01-27 16:20:47	a820a321-416a-4ebd-9db0-4ed35d612bc1
217	138	1	zielgruppen	kategorie/zielgruppen	t	2021-01-22 14:35:35	2021-01-22 14:35:37	5d3f1f26-944e-4d41-93e8-500ab07a493c
360	210	1	bbb	produkte/bbb	t	2021-02-01 15:49:53	2021-02-01 15:49:53	22393239-4b12-40d1-acbc-c99bd8f5737a
361	210	2	bbb	products/bbb	t	2021-02-01 15:49:53	2021-02-01 15:49:53	52c99137-f490-4b9b-afc9-9969c387ac40
218	138	2	target-groups	kategorie/target-groups	t	2021-01-22 14:35:35	2021-01-22 14:36:16	5a6880d2-e357-4071-9d35-195274e64cae
220	139	1	journalisten	kategorie/journalisten	t	2021-01-22 14:36:57	2021-01-22 14:36:59	6661a18a-4cc2-497a-9767-3162918c62a0
221	139	2	journalisten	kategorie/journalisten	t	2021-01-22 14:36:57	2021-01-22 14:36:59	06efbb70-2224-4e65-9449-2fe0f3587d3a
253	151	2	__temp_enqdmvvehlclakbzkpsxsdonmbokjcbaltst	eng_blog/__temp_enqdmvvehlclakbzkpsxsdonmbokjcbaltst	f	2021-01-22 14:57:13	2021-01-22 14:57:13	d09f5393-134c-4dc1-9ffa-abdb7f43fe70
254	151	1	__temp_enqdmvvehlclakbzkpsxsdonmbokjcbaltst	blog/__temp_enqdmvvehlclakbzkpsxsdonmbokjcbaltst	f	2021-01-22 14:57:13	2021-01-22 14:57:13	6fc8bf27-3707-42c9-a373-d52c8dbc5c32
257	153	1	__temp_sjvaljmjugwmouojbtkanetznxmlgsioiidq	p/__temp_sjvaljmjugwmouojbtkanetznxmlgsioiidq	t	2021-01-22 15:08:41	2021-01-22 15:08:41	da5ca342-89ba-49ab-a2b4-f9f469234bad
258	154	1	__temp_cbpdgixhqhccanipskzffffdtevknjlpihyo	p/__temp_cbpdgixhqhccanipskzffffdtevknjlpihyo	t	2021-01-22 15:25:58	2021-01-22 15:25:58	12054455-1f79-4159-9eec-a2fe33e10902
259	155	1	__temp_gpydjuppekfhloveqssqxrveokpkpsptbqck	p/__temp_gpydjuppekfhloveqssqxrveokpkpsptbqck	t	2021-01-22 15:31:12	2021-01-22 15:31:12	08d4259b-eadb-497d-be31-3160956c3761
268	160	1	__temp_zuisjezkgrkibixdawajjazzlpkldqgniueu	p/__temp_zuisjezkgrkibixdawajjazzlpkldqgniueu	t	2021-01-22 15:57:12	2021-01-22 15:57:12	175d2953-d1fd-458e-9b5f-ac3af6ab9937
269	161	1	__temp_rtdiaciazbividvjmqzrtuiimrtkulkbhgvj	p/__temp_rtdiaciazbividvjmqzrtuiimrtkulkbhgvj	t	2021-01-22 16:27:22	2021-01-22 16:27:22	dc3e4367-6b4b-434d-b88b-79f42eb9fc8c
270	162	1	__temp_iqyiyvoqlppywqgtvsweqknxnxgxucovlltz	p/__temp_iqyiyvoqlppywqgtvsweqknxnxgxucovlltz	t	2021-01-22 16:41:40	2021-01-22 16:41:40	4dc2e31a-cbf8-4333-9e9e-78bbd29f024d
226	141	1	aussteller	kategorie/aussteller	t	2021-01-22 14:37:36	2021-01-22 14:38:16	d60b8e8d-1778-4024-b658-9da818638e96
227	141	2	aussteller	kategorie/aussteller	t	2021-01-22 14:37:36	2021-01-22 14:38:16	f84990fa-0e00-4dbb-a7fe-65ee30f5fdd3
232	143	1	veranstaltungsart	kategorie/veranstaltungsart	t	2021-01-22 14:37:51	2021-01-22 14:38:30	9bc63cb0-4edc-4e4c-8fe2-420995240ec7
233	143	2	veranstaltungsart	kategorie/veranstaltungsart	t	2021-01-22 14:37:51	2021-01-22 14:38:30	79742f07-b522-4973-a2fb-fcf2fee79e56
235	144	1	konferrenz	kategorie/konferrenz	t	2021-01-22 14:37:54	2021-01-22 14:38:37	53f25a6c-b6de-4716-ad9a-f87a33d991b1
236	144	2	konferrenz	kategorie/konferrenz	t	2021-01-22 14:37:54	2021-01-22 14:38:37	5a5a0751-bee5-4073-9c5b-172d8f1518bc
238	145	1	foren	kategorie/foren	t	2021-01-22 14:37:57	2021-01-22 14:38:42	cb66a8b5-4255-4840-a36a-777d36aec9b9
239	145	2	foren	kategorie/foren	t	2021-01-22 14:37:57	2021-01-22 14:38:42	b1c03ab9-46cf-471c-98dc-d4b99272ae0a
241	146	1	sonderschau	kategorie/sonderschau	t	2021-01-22 14:38:01	2021-01-22 14:38:45	756dafed-8f37-4277-9bcd-42694b20d327
242	146	2	sonderschau	kategorie/sonderschau	t	2021-01-22 14:38:01	2021-01-22 14:38:45	a050c79b-a7bf-45b9-bb69-60b0b922e25e
223	140	1	besucher	kategorie/besucher	t	2021-01-22 14:37:31	2021-01-22 14:38:49	b3c80149-64b0-49fd-868f-77fd4a317eab
224	140	2	besucher	kategorie/besucher	t	2021-01-22 14:37:31	2021-01-22 14:38:49	155768ea-ce67-45df-9682-156771698ce1
229	142	1	dienstleister	kategorie/dienstleister	t	2021-01-22 14:37:42	2021-01-22 14:38:55	b35ce35a-9a8c-4fb1-950a-e6b07ff16712
230	142	2	dienstleister	kategorie/dienstleister	t	2021-01-22 14:37:42	2021-01-22 14:38:55	deaa14e1-c884-4fce-80ce-73d7b8e3e855
271	163	1	themengebiete	kategorie/themengebiete	t	2021-01-25 14:32:37	2021-01-25 14:32:40	1d62a347-39bd-42e4-9d79-243fc9ab4346
272	163	2	themengebiete	kategorie/themengebiete	t	2021-01-25 14:32:38	2021-01-25 14:32:40	1222218b-2183-4f50-abca-2d79595c83f0
284	169	2	moderator	kategorie/moderator	t	2021-01-25 14:33:22	2021-01-25 14:33:40	9e006441-a2cd-4a32-9bbc-eb6d9ab9f7a0
285	170	1	speaker	kategorie/speaker	t	2021-01-25 14:33:25	2021-01-25 14:33:42	cb3d2ab3-4e39-4fea-8d5c-d7c4d79c85c5
286	170	2	speaker	kategorie/speaker	t	2021-01-25 14:33:25	2021-01-25 14:33:42	b6e60184-ab1f-423d-92fc-1cfa0c6f80d8
287	171	1	anprechpartner	kategorie/anprechpartner	t	2021-01-25 14:33:28	2021-01-25 14:33:43	b90dd95c-71b7-4d8d-8cc2-8708336a2ced
288	171	2	anprechpartner	kategorie/anprechpartner	t	2021-01-25 14:33:28	2021-01-25 14:33:44	4aa6a571-51c3-47c9-96ce-63b1dcab87e3
289	172	1	redakteur	kategorie/redakteur	t	2021-01-25 14:33:30	2021-01-25 14:33:45	72255a65-8c1d-4537-b288-43a0c1eca172
290	172	2	redakteur	kategorie/redakteur	t	2021-01-25 14:33:30	2021-01-25 14:33:45	3421213a-c9e3-42a5-b710-72670179f693
273	164	1	elektrotechnik-und-elektronik	kategorie/elektrotechnik-und-elektronik	t	2021-01-25 14:32:52	2021-01-25 14:33:10	9445bdaa-188c-4853-9c06-24210d7556c2
274	164	2	elektrotechnik-und-elektronik	kategorie/elektrotechnik-und-elektronik	t	2021-01-25 14:32:52	2021-01-25 14:33:10	077d8a7d-6c8a-4771-a0a2-fdad36eef31d
275	165	1	automobilindustrie-und-zulieferer	kategorie/automobilindustrie-und-zulieferer	t	2021-01-25 14:32:55	2021-01-25 14:33:12	b311b7dc-f21c-4fd6-8c41-7618bddb489b
276	165	2	automobilindustrie-und-zulieferer	kategorie/automobilindustrie-und-zulieferer	t	2021-01-25 14:32:55	2021-01-25 14:33:12	794c98d4-8fd0-40af-ac5a-9f243b88439d
277	166	1	bearbeitung-und-verarbeitung-neuer-werkstoffe	kategorie/bearbeitung-und-verarbeitung-neuer-werkstoffe	t	2021-01-25 14:32:59	2021-01-25 14:33:13	f740f5e6-acc0-493d-aca0-b20ec2ae6b76
278	166	2	bearbeitung-und-verarbeitung-neuer-werkstoffe	kategorie/bearbeitung-und-verarbeitung-neuer-werkstoffe	t	2021-01-25 14:32:59	2021-01-25 14:33:13	1c639249-3a38-4196-8020-4f9c166b3f35
279	167	1	feinmechanik-und-optik	kategorie/feinmechanik-und-optik	t	2021-01-25 14:33:02	2021-01-25 14:33:14	39a39e1a-7b5f-4644-a273-bd0d38611816
280	167	2	feinmechanik-und-optik	kategorie/feinmechanik-und-optik	t	2021-01-25 14:33:02	2021-01-25 14:33:14	92b223c4-9ef0-47ef-b821-910e9d737d4a
281	168	1	persona	kategorie/persona	t	2021-01-25 14:33:18	2021-01-25 14:33:20	cda5e9f0-a81a-4910-b4fe-a6c8df3cf3d7
282	168	2	persona	kategorie/persona	t	2021-01-25 14:33:18	2021-01-25 14:33:20	d9307120-49d2-4df2-8453-5509eefc1af6
291	173	1	messe-team	kategorie/messe-team	t	2021-01-25 14:33:33	2021-01-25 14:33:46	279fed58-4c78-450c-b3cc-bedde74e5781
305	180	1	schieblehre	tags/schieblehre	t	2021-01-25 14:35:03	2021-01-25 14:35:05	9bdb36e5-baec-407f-a2c7-768a822fcf49
306	180	2	schieblehre	tags/schieblehre	t	2021-01-25 14:35:03	2021-01-25 14:35:05	5b24a05b-a6de-49e8-aacf-62c97c9a8ffe
307	181	1	emo-news	tags/emo-news	t	2021-01-25 14:35:08	2021-01-25 14:35:10	1dfc5e39-d873-43df-9f54-0c8c247a1ea3
308	181	2	emo-news	tags/emo-news	t	2021-01-25 14:35:09	2021-01-25 14:35:10	7cfb8f54-10ab-4a0b-b5f1-9a23d06ecb43
314	186	1	__temp_yjxeolmrfnszoyhgvkchvaqxreulfdyednua	a/__temp_yjxeolmrfnszoyhgvkchvaqxreulfdyednua	t	2021-01-25 16:29:28	2021-01-25 16:29:28	affd1a7c-4908-41ad-b543-15816f59661a
315	186	2	__temp_yjxeolmrfnszoyhgvkchvaqxreulfdyednua	a/__temp_yjxeolmrfnszoyhgvkchvaqxreulfdyednua	t	2021-01-25 16:29:28	2021-01-25 16:29:28	0ca4b63f-4749-4746-9329-776e243b7145
316	187	1	__temp_kghnyhjugcwnkaxrkccanscqmywvbkybiamk	a/__temp_kghnyhjugcwnkaxrkccanscqmywvbkybiamk	t	2021-01-25 16:34:20	2021-01-25 16:34:20	1da8461b-15a7-4db6-a004-5b5360458524
283	169	1	moderator	kategorie/moderator	t	2021-01-25 14:33:21	2021-01-25 14:33:40	08947fbd-5b69-41c4-ac0f-3c08f7fc277b
292	173	2	messe-team	kategorie/messe-team	t	2021-01-25 14:33:33	2021-01-25 14:33:46	829a20c7-b2c0-4509-b7d0-3bd5881fe9ae
293	174	1	software	tags/software	t	2021-01-25 14:34:47	2021-01-25 14:34:49	8ed76af6-246a-4363-9510-99b062027753
294	174	2	software	tags/software	t	2021-01-25 14:34:48	2021-01-25 14:34:49	e661b926-af08-43fc-9eb3-b01fa1cacedb
317	187	2	__temp_kghnyhjugcwnkaxrkccanscqmywvbkybiamk	a/__temp_kghnyhjugcwnkaxrkccanscqmywvbkybiamk	t	2021-01-25 16:34:20	2021-01-25 16:34:20	25b1a10e-a68a-49d2-ae41-21af99b74b96
318	188	1	__temp_vmbjvbjdpsmghomewwrsjhjazuxbtqbkowvz	downloads-medien/__temp_vmbjvbjdpsmghomewwrsjhjazuxbtqbkowvz	t	2021-01-25 16:38:43	2021-01-25 16:38:43	0cf4b0f3-2d0c-4699-9ddc-5ac86971a7a8
319	188	2	__temp_vmbjvbjdpsmghomewwrsjhjazuxbtqbkowvz	downloads-medien/__temp_vmbjvbjdpsmghomewwrsjhjazuxbtqbkowvz	t	2021-01-25 16:38:43	2021-01-25 16:38:43	e13b05e9-27c6-40f8-9cf7-e678ec5d6d70
352	205	1	__temp_pmwffntvgmsfloqdbdbakckpzlotsqtrksgm	aussteller/__temp_pmwffntvgmsfloqdbdbakckpzlotsqtrksgm	t	2021-01-27 17:12:06	2021-01-27 17:12:06	1d823504-0cab-45ad-9c44-4fa4dc11d00e
299	177	1	presse	tags/presse	t	2021-01-25 14:34:55	2021-01-25 14:34:57	c6692cd6-9186-4147-92c1-e0f0fb4d7232
300	177	2	presse	tags/presse	t	2021-01-25 14:34:56	2021-01-25 14:34:57	b8b6ec93-8516-4473-841f-624a07fba5b2
301	178	1	milano	tags/milano	t	2021-01-25 14:34:58	2021-01-25 14:35:00	ca8fb391-2b60-4d26-8881-e0e0a34abae2
302	178	2	milano	tags/milano	t	2021-01-25 14:34:58	2021-01-25 14:35:00	0f858176-9346-4126-9d20-7294998c1917
303	179	1	zerspanung	tags/zerspanung	t	2021-01-25 14:35:01	2021-01-25 14:35:02	1a7c9efb-8e9c-4832-a5ba-3fdec6d8d30d
304	179	2	zerspanung	tags/zerspanung	t	2021-01-25 14:35:01	2021-01-25 14:35:02	8fa1e464-ee57-4b30-a50d-f0d1e1d9f7ab
295	175	1	intern	tags/intern	t	2021-01-25 14:34:50	2021-01-25 14:37:03	e08f4a6c-bd94-4e37-977a-9a9ed1e1c6f8
296	175	2	intern	tags/intern	t	2021-01-25 14:34:50	2021-01-25 14:37:03	15cf80a0-e407-4605-bd89-3b58abe6cb5b
297	176	1	highlight	tags/highlight	t	2021-01-25 14:34:52	2021-01-25 14:37:05	1a208029-b46c-4776-85e4-04234a6498bc
298	176	2	highlight	tags/highlight	t	2021-01-25 14:34:53	2021-01-25 14:37:05	480c877c-b393-439c-9b06-bf63fc90ca96
309	182	1	__temp_dmdgavljbuqkarrbowsvzazugsjqnnjnhztc	p/__temp_dmdgavljbuqkarrbowsvzazugsjqnnjnhztc	t	2021-01-25 14:39:06	2021-01-25 14:39:06	9d4bb677-657e-47df-9d4e-bc9906e192f8
310	183	1	__temp_assuhvwciieksiltukzvasmzjxxdjrwmddiz	p/__temp_assuhvwciieksiltukzvasmzjxxdjrwmddiz	t	2021-01-25 15:12:17	2021-01-25 15:12:17	bb2e9e75-2d57-46f4-ba99-5427c0e14afb
311	184	1	__temp_zqicofpdqpuombuxljbmdetwaohfqyvuxuwr	p/__temp_zqicofpdqpuombuxljbmdetwaohfqyvuxuwr	t	2021-01-25 15:13:22	2021-01-25 15:13:22	4b0ef16f-24b3-4a38-8759-45b457d1456b
321	189	2	__temp_iqqjqmevvpkcqbkmfmqhltreplipbxcdhlnm	events/__temp_iqqjqmevvpkcqbkmfmqhltreplipbxcdhlnm	f	2021-01-25 17:01:32	2021-01-27 09:14:49	551954b9-fff7-49f8-affe-b0f27a02dbb9
323	190	2	__temp_grkbwqhlkzxabapanfiqifilawhccydgkbuh	events/__temp_grkbwqhlkzxabapanfiqifilawhccydgkbuh	f	2021-01-25 17:03:55	2021-01-27 09:14:49	e3c0357a-acff-478e-9e88-6887691dbf05
312	185	1	__temp_uwcznkblhdaprleoywrdnuawoxddxamaxtqz	personen/__temp_uwcznkblhdaprleoywrdnuawoxddxamaxtqz	f	2021-01-25 15:33:25	2021-01-27 09:15:01	52f90f71-d132-49fe-a79c-caca78471574
320	189	1	__temp_iqqjqmevvpkcqbkmfmqhltreplipbxcdhlnm	events/__temp_iqqjqmevvpkcqbkmfmqhltreplipbxcdhlnm	f	2021-01-25 17:01:32	2021-01-27 09:15:03	0f50a15b-68b1-4244-af76-9d254dc9c4df
322	190	1	__temp_grkbwqhlkzxabapanfiqifilawhccydgkbuh	events/__temp_grkbwqhlkzxabapanfiqifilawhccydgkbuh	f	2021-01-25 17:03:55	2021-01-27 09:15:03	b24708f8-2d19-4935-adb5-45d1ef79f017
324	191	1	__temp_objdfvhicvdmbfoaichlwmumisagybdvkgqh	events/__temp_objdfvhicvdmbfoaichlwmumisagybdvkgqh	t	2021-01-27 08:49:43	2021-01-27 08:49:43	f9e765ca-0b86-4bb2-ac67-a8096c08324f
325	191	2	__temp_objdfvhicvdmbfoaichlwmumisagybdvkgqh	events/__temp_objdfvhicvdmbfoaichlwmumisagybdvkgqh	t	2021-01-27 08:49:43	2021-01-27 08:49:43	7dd2ea35-fd5e-4bfb-b48f-702ef652efa3
353	205	2	__temp_pmwffntvgmsfloqdbdbakckpzlotsqtrksgm	exhibitors/__temp_pmwffntvgmsfloqdbdbakckpzlotsqtrksgm	t	2021-01-27 17:12:06	2021-01-27 17:12:06	65884080-82b1-4c4e-9a88-c268a707420d
362	211	1	craft-graphql-mutations	produkte/craft-graphql-mutations	t	2021-02-01 15:55:26	2021-02-01 15:55:26	94e54361-fe16-4297-8eb5-1afa3aff347a
313	185	2	__temp_uwcznkblhdaprleoywrdnuawoxddxamaxtqz	personen/__temp_uwcznkblhdaprleoywrdnuawoxddxamaxtqz	f	2021-01-25 15:33:25	2021-01-27 09:14:48	c3d2c360-ae35-45f8-8562-c79d22af0742
328	193	1	__temp_jchpdzdunreshvxayirdwpozzvlhvaegwrad	aussteller/__temp_jchpdzdunreshvxayirdwpozzvlhvaegwrad	t	2021-01-27 13:28:18	2021-01-27 13:28:18	38bbe055-1eda-4006-9ead-c7cdcb41e1d0
329	193	2	__temp_jchpdzdunreshvxayirdwpozzvlhvaegwrad	exhibitors/__temp_jchpdzdunreshvxayirdwpozzvlhvaegwrad	t	2021-01-27 13:28:18	2021-01-27 13:28:18	806b4162-444a-4d43-aa64-db2e816fd388
330	194	1	__temp_zytpvnrecwwswksdpxhrugyhmdbnklzrqtuk	aussteller/__temp_zytpvnrecwwswksdpxhrugyhmdbnklzrqtuk	t	2021-01-27 15:27:35	2021-01-27 15:27:35	282edfa5-d945-4620-aa99-fce9af0eb580
331	194	2	__temp_zytpvnrecwwswksdpxhrugyhmdbnklzrqtuk	exhibitors/__temp_zytpvnrecwwswksdpxhrugyhmdbnklzrqtuk	t	2021-01-27 15:27:35	2021-01-27 15:27:35	ebf34ea6-9d7d-4720-a8fc-2be2bb024d7b
332	195	1	__temp_asblsfuisscwqufsqtfhritaztvxqdcjrpbs	produkte/__temp_asblsfuisscwqufsqtfhritaztvxqdcjrpbs	t	2021-01-27 15:28:46	2021-01-27 15:28:46	d54f376b-2eaf-4215-be34-d86a56f9b134
333	195	2	__temp_asblsfuisscwqufsqtfhritaztvxqdcjrpbs	products/__temp_asblsfuisscwqufsqtfhritaztvxqdcjrpbs	t	2021-01-27 15:28:46	2021-01-27 15:28:46	3ef766ec-c7c4-4c66-ba04-b7ac4119f898
334	196	1	__temp_xspzsmyuvqdiqjedmtxgbfzavvogporfhglh	produkte/__temp_xspzsmyuvqdiqjedmtxgbfzavvogporfhglh	t	2021-01-27 15:42:08	2021-01-27 15:42:08	17726219-4ea3-4018-8408-6165e4d7d08a
335	196	2	__temp_xspzsmyuvqdiqjedmtxgbfzavvogporfhglh	products/__temp_xspzsmyuvqdiqjedmtxgbfzavvogporfhglh	t	2021-01-27 15:42:08	2021-01-27 15:42:08	1b238130-7ef0-47db-ba36-66c36a9b2b87
336	197	1	drehmaschinen	nomenklatur/drehmaschinen	t	2021-01-27 15:42:26	2021-01-27 15:42:27	89a1e149-24dc-4565-affd-fd3c7fbdba85
337	197	2	drehmaschinen	nomenclature/drehmaschinen	t	2021-01-27 15:42:26	2021-01-27 15:42:27	31a851c4-25d7-4a78-b173-baa32bd25945
338	198	1	__temp_yzjtmvztlcvlqltipjzxcfovbsjjxqftkyip	produkte/__temp_yzjtmvztlcvlqltipjzxcfovbsjjxqftkyip	t	2021-01-27 15:51:04	2021-01-27 15:51:04	7a59111f-8177-463c-9a57-0a56a5042ab0
339	198	2	__temp_yzjtmvztlcvlqltipjzxcfovbsjjxqftkyip	products/__temp_yzjtmvztlcvlqltipjzxcfovbsjjxqftkyip	t	2021-01-27 15:51:04	2021-01-27 15:51:04	cc540a87-d845-40a6-a862-3182d905f3c5
340	199	1	__temp_kojzuumicegrsnclvhfjdlkdthunftowtpap	produkte/__temp_kojzuumicegrsnclvhfjdlkdthunftowtpap	t	2021-01-27 15:51:07	2021-01-27 15:51:07	1eeccc22-403d-4d36-aa6e-28c94f5e6ff8
341	199	2	__temp_kojzuumicegrsnclvhfjdlkdthunftowtpap	products/__temp_kojzuumicegrsnclvhfjdlkdthunftowtpap	t	2021-01-27 15:51:07	2021-01-27 15:51:07	390826e7-fb59-475b-84cb-510bbfe0a9fa
363	211	2	craft-graphql-mutations	products/craft-graphql-mutations	t	2021-02-01 15:55:26	2021-02-01 15:55:26	1ad88a85-0a58-4209-9f80-58a9882a5c4a
\.


--
-- Data for Name: entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entries (id, "sectionId", "parentId", "typeId", "authorId", "postDate", "expiryDate", "deletedWithEntryType", "dateCreated", "dateUpdated", uid) FROM stdin;
205	10	\N	12	16	2021-01-27 17:12:00	\N	\N	2021-01-27 17:12:06	2021-01-27 17:12:06	381c8ae5-0845-4124-9890-91626f997b4a
211	11	\N	13	16	2021-02-01 15:55:00	\N	\N	2021-02-01 15:55:26	2021-02-01 15:55:26	a6aa02b3-d521-45ed-99c5-b29ef24a0267
153	4	\N	4	16	2021-01-22 15:08:00	\N	\N	2021-01-22 15:08:41	2021-01-22 15:08:41	96526aef-fe1d-4c32-b13c-ae9f34e8bdd9
154	4	\N	4	16	2021-01-22 15:25:00	\N	\N	2021-01-22 15:25:58	2021-01-22 15:25:58	86791e22-a524-4897-8cc0-25df114f267a
155	4	\N	4	16	2021-01-22 15:31:00	\N	\N	2021-01-22 15:31:12	2021-01-22 15:31:12	c9d66307-0fda-4d2b-8784-9ca3580d8124
160	4	\N	4	16	2021-01-22 15:57:00	\N	\N	2021-01-22 15:57:12	2021-01-22 15:57:12	f9ebd765-a047-4dc9-82c0-8c484736f373
161	4	\N	4	16	2021-01-22 16:27:00	\N	\N	2021-01-22 16:27:22	2021-01-22 16:27:22	2d7c015e-f615-415c-9ddd-425caa145080
162	4	\N	4	16	2021-01-22 16:41:00	\N	\N	2021-01-22 16:41:40	2021-01-22 16:41:40	bbee3542-3c61-48db-9b83-b24b157914d8
182	4	\N	4	16	2021-01-25 14:39:00	\N	\N	2021-01-25 14:39:06	2021-01-25 14:39:06	44b99053-657f-45f3-9911-a90d0b4e46f0
183	4	\N	4	16	2021-01-25 15:12:00	\N	\N	2021-01-25 15:12:17	2021-01-25 15:12:17	a34fac4a-7c20-4277-93b3-b513281cabd7
184	4	\N	4	16	2021-01-25 15:13:00	\N	\N	2021-01-25 15:13:22	2021-01-25 15:13:22	5d41a98f-b893-41ec-afa0-4791cf7751c5
185	7	\N	8	16	2021-01-25 16:19:00	\N	\N	2021-01-25 15:33:25	2021-01-25 16:19:43	aa5fdb3a-b348-42a0-bcb8-adb8d2de03be
186	8	\N	9	16	2021-01-25 16:29:00	\N	\N	2021-01-25 16:29:28	2021-01-25 16:29:28	040c0bed-9824-4410-be4f-83ef29d265cc
187	8	\N	9	16	2021-01-25 16:34:00	\N	\N	2021-01-25 16:34:20	2021-01-25 16:34:20	49f6a97c-0ef7-4fd0-9fac-2be52e4a3d32
188	6	\N	7	16	2021-01-25 16:38:00	\N	\N	2021-01-25 16:38:43	2021-01-25 16:38:43	e9e1b079-6b30-4597-901c-861425d2add0
189	9	\N	10	16	2021-01-25 17:01:00	\N	\N	2021-01-25 17:01:32	2021-01-25 17:01:32	643b6e29-cb47-4f9f-b8d7-9acfae791fc0
190	9	\N	10	16	2021-01-25 17:03:00	\N	\N	2021-01-25 17:03:55	2021-01-25 17:03:55	8b34859e-5bb0-4ce2-bca7-e7c14988f901
191	9	\N	10	16	2021-01-27 08:49:00	\N	\N	2021-01-27 08:49:43	2021-01-27 08:49:43	1b7b2dbd-5ba1-443a-ab03-f8e47301c109
193	10	\N	12	16	2021-01-27 13:28:00	\N	\N	2021-01-27 13:28:18	2021-01-27 13:28:18	ed68f0a6-0f01-4f5b-9a9f-a55f342d3828
194	10	\N	12	16	2021-01-27 15:27:00	\N	\N	2021-01-27 15:27:35	2021-01-27 15:27:35	9f439c75-3364-4b63-94d7-e86ed233e18b
195	11	\N	13	16	2021-01-27 15:28:00	\N	\N	2021-01-27 15:28:46	2021-01-27 15:28:46	8c51f5a0-542c-42c3-93a3-d55820c8c592
196	11	\N	13	16	2021-01-27 15:42:00	\N	\N	2021-01-27 15:42:08	2021-01-27 15:42:08	50593c92-a2e4-4c9e-b2f8-8f2875c9f0e2
198	11	\N	13	16	2021-01-27 15:51:00	\N	\N	2021-01-27 15:51:04	2021-01-27 15:51:04	c0cf952e-f79c-445d-8ae9-7606acb34148
199	11	\N	13	16	2021-01-27 15:51:00	\N	\N	2021-01-27 15:51:07	2021-01-27 15:51:07	512adfe5-3269-4ae7-ba20-389b9d4612c2
208	10	\N	12	16	2021-01-29 15:14:00	\N	\N	2021-01-29 15:14:25	2021-01-29 15:14:25	33d380ba-02a1-43d7-83f6-7e45c07210de
210	11	\N	13	16	2021-02-01 15:49:00	\N	\N	2021-02-01 15:49:53	2021-02-01 15:49:53	474a7639-37c4-464c-898b-d6bab44fbee2
212	11	\N	13	16	2021-02-01 16:02:00	\N	\N	2021-02-01 16:02:06	2021-02-01 16:02:06	6b241c6c-e22a-4bbf-9647-0b629199acf2
\.


--
-- Data for Name: entrytypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrytypes (id, "sectionId", "fieldLayoutId", name, handle, "hasTitleField", "titleTranslationMethod", "titleTranslationKeyFormat", "titleFormat", "sortOrder", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
7	6	14	Downloads & Medien	downloads	t	site	\N	\N	1	2021-01-25 15:00:30	2021-01-25 15:00:30	\N	4926019f-9936-4a51-a84f-38d927e89c25
8	7	15	Personen	persons	f	none	\N	{title}_{salutation}_{firstname}_{lastname}	1	2021-01-25 15:30:00	2021-01-25 15:39:18	\N	f2313657-ca71-492d-9931-0f1a1c49cdce
9	8	16	Artikelbeitrag	article	t	site	\N	\N	1	2021-01-25 16:24:39	2021-01-25 16:24:39	\N	e7599b97-ad13-4eea-bd62-3fdd165886ce
4	4	9	Informationsseite	page	t	site	\N	\N	1	2021-01-22 14:48:20	2021-01-25 16:28:15	\N	0d410440-cbd2-47b2-8a7f-21e7b8afe43e
10	9	17	Veranstaltungen	events	t	none	\N	\N	1	2021-01-25 16:56:46	2021-01-25 17:07:07	\N	75c0a1e7-4014-4664-ac9e-01d4114becdc
12	10	20	Aussteller	exhibitors	t	none	\N	\N	2	2021-01-27 13:27:36	2021-01-27 13:27:56	\N	5f92a88d-eede-41f6-8695-815d1211d2fe
13	11	21	Produkte	products	t	none	\N	\N	1	2021-01-27 15:06:55	2021-01-27 15:36:11	\N	e93d03f4-73b1-4675-b5f7-1aff6d7f7a63
\.


--
-- Data for Name: fieldgroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fieldgroups (id, name, "dateCreated", "dateUpdated", uid) FROM stdin;
5	SEO	2021-01-22 16:07:15	2021-01-22 16:07:15	1bc07f3f-1822-42db-aaf9-aa04909a62d1
2	Taxonomy	2021-01-22 14:30:30	2021-01-25 15:03:08	34b5cb01-0278-41cb-8ac2-1c6d931920cf
6	Downloads & Media	2021-01-25 14:58:45	2021-01-25 15:03:48	a2bdc517-6ecc-4dfa-be02-558659dda46c
4	Content	2021-01-22 15:09:32	2021-01-25 15:03:57	dbde185a-c4d5-4159-96a4-e75394214c6c
7	Meta	2021-01-25 15:04:25	2021-01-25 15:04:25	bd527d51-1e8b-439f-8d9a-e8367987817e
8	Person	2021-01-25 15:18:13	2021-01-25 15:18:13	46e7d308-41fb-4441-87ee-70fa77295bf7
9	Contact	2021-01-25 15:26:55	2021-01-25 15:26:55	e0052448-4c56-4da7-a2b5-d0739570cba1
10	Article	2021-01-25 16:50:53	2021-01-25 17:02:49	fb32794f-b761-46ab-b045-7c0821da0010
11	Event	2021-01-25 16:51:52	2021-01-25 17:02:57	1409bb4a-dc75-44ba-99c9-5234616c4ab7
12	Location	2021-01-25 16:53:20	2021-01-25 17:03:27	5530bc01-dbd1-4eca-8a5d-fa8906f6a042
13	Address	2021-01-27 13:16:09	2021-01-27 13:16:09	1d55be6c-f0ae-45f5-91a7-6a4a464d109e
14	Exhibitor	2021-01-27 14:57:02	2021-01-27 14:57:02	ca6b85ed-e3a8-4acc-953d-6400dde26c06
15	Product	2021-01-27 15:30:13	2021-01-27 15:30:13	ecf27a09-c4c5-43fc-bad8-3c666a274fe2
\.


--
-- Data for Name: fieldlayoutfields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fieldlayoutfields (id, "layoutId", "tabId", "fieldId", required, "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
149	15	65	28	f	1	2021-01-25 15:39:18	2021-01-25 15:39:18	a1a3144e-49b4-4d40-8b82-8b528fee6949
150	15	65	20	f	2	2021-01-25 15:39:18	2021-01-25 15:39:18	6ba48913-23e6-4e9c-876f-1d004ac91f9f
151	15	65	18	f	3	2021-01-25 15:39:18	2021-01-25 15:39:18	855d4ab6-2e43-484a-a644-1dfc18634791
152	15	65	19	f	4	2021-01-25 15:39:18	2021-01-25 15:39:18	9b2efdbc-7f8c-4b5a-9ba9-ce41499de35f
153	15	65	21	f	6	2021-01-25 15:39:18	2021-01-25 15:39:18	60bb223c-ea00-4616-b309-db0d7ce34047
154	15	66	22	f	0	2021-01-25 15:39:18	2021-01-25 15:39:18	64cab023-f790-4d0a-9376-89c27c39a28d
155	15	66	23	f	1	2021-01-25 15:39:18	2021-01-25 15:39:18	1e3757d9-2c66-43a6-b1fa-e0b012b138f2
156	15	66	24	f	3	2021-01-25 15:39:18	2021-01-25 15:39:18	62091078-da35-419e-9a3a-fb071f59a035
157	15	66	27	f	4	2021-01-25 15:39:18	2021-01-25 15:39:18	8988061e-d618-4b37-ba99-ef33eb3a86ef
158	15	66	25	f	5	2021-01-25 15:39:18	2021-01-25 15:39:18	b60ab682-bb9f-474a-b8fd-c177c037db69
159	15	66	26	f	6	2021-01-25 15:39:18	2021-01-25 15:39:18	cfea59ed-e5f0-4da5-ad7a-85e388500381
160	9	68	4	f	1	2021-01-25 16:28:15	2021-01-25 16:28:15	e39369f7-50de-4ba2-a696-702ffb162fcd
161	9	68	6	f	2	2021-01-25 16:28:15	2021-01-25 16:28:15	e8c8aa0b-c642-40e8-8bc9-ef2b1f4b0ddf
162	9	68	8	f	3	2021-01-25 16:28:15	2021-01-25 16:28:15	02657835-2158-45d5-ab06-5db19141ada7
163	9	68	5	t	4	2021-01-25 16:28:15	2021-01-25 16:28:15	0e5fe343-e3b0-4703-9e7e-5ad19b97646b
164	9	68	14	f	6	2021-01-25 16:28:15	2021-01-25 16:28:15	d67eb522-0719-4751-bd8c-646380c71d21
165	9	68	9	f	7	2021-01-25 16:28:15	2021-01-25 16:28:15	d1348ba3-8fdf-421b-8630-ebfdda03b393
166	9	69	15	f	0	2021-01-25 16:28:15	2021-01-25 16:28:15	854062aa-ec93-4685-ba4f-304987851f18
167	9	69	16	f	1	2021-01-25 16:28:15	2021-01-25 16:28:15	09681f8a-dfca-41ef-b6cb-bfff24b1e48e
168	9	70	12	f	0	2021-01-25 16:28:15	2021-01-25 16:28:15	efa3445c-9f09-4c1b-a73a-ace720158391
169	9	70	10	f	1	2021-01-25 16:28:15	2021-01-25 16:28:15	e33fc000-df4b-4fe3-a361-025bee106159
170	9	70	11	f	2	2021-01-25 16:28:15	2021-01-25 16:28:15	e5f611b2-7412-4cf2-bc16-60d7651677ed
171	9	71	13	f	0	2021-01-25 16:28:15	2021-01-25 16:28:15	7d8c9685-c235-4c5d-9abb-77eed321df53
418	20	125	45	f	1	2021-01-27 15:25:50	2021-01-27 15:25:50	735ea227-6937-4db2-a1ac-3189baba7866
419	20	125	46	f	2	2021-01-27 15:25:50	2021-01-27 15:25:50	778a9633-5d45-4992-aa6f-bfa618086905
420	20	125	8	f	3	2021-01-27 15:25:50	2021-01-27 15:25:50	23ccead2-9924-4042-a116-70a201a0e464
421	20	125	51	f	4	2021-01-27 15:25:50	2021-01-27 15:25:50	e1e5d459-dce4-449e-998e-183d2ebbf8af
422	20	125	32	f	6	2021-01-27 15:25:50	2021-01-27 15:25:50	783afa85-53be-4bcb-9ae6-f85c8821611e
423	20	125	33	f	7	2021-01-27 15:25:50	2021-01-27 15:25:50	03fbb0b3-29c4-4bcf-968f-61f6a57290fe
424	20	126	20	f	1	2021-01-27 15:25:50	2021-01-27 15:25:50	7968200b-6b4e-42e0-8c45-01caf5a0cafe
425	20	126	41	f	2	2021-01-27 15:25:50	2021-01-27 15:25:50	ffbd36a5-227f-4091-9242-29b0fefef750
426	20	126	18	f	3	2021-01-27 15:25:50	2021-01-27 15:25:50	25316aef-0dc8-4bf3-b02a-d42644eec1f6
427	20	126	19	f	4	2021-01-27 15:25:50	2021-01-27 15:25:50	e7c22505-9c48-407e-9f11-9892b0dfdbad
182	16	75	4	f	1	2021-01-25 16:34:09	2021-01-25 16:34:09	5595bf4b-a6fc-48d5-a771-a49a9091cb7e
183	16	75	6	f	2	2021-01-25 16:34:09	2021-01-25 16:34:09	e972bc76-d19b-42b7-9af1-29a89f24dc2d
184	16	75	8	f	3	2021-01-25 16:34:09	2021-01-25 16:34:09	44c506d1-c02b-4deb-b9fc-703ca00f630e
185	16	75	5	f	4	2021-01-25 16:34:09	2021-01-25 16:34:09	2ea6e3a1-56ec-4bb8-aa82-25fbe37e6c7e
186	16	75	14	f	6	2021-01-25 16:34:09	2021-01-25 16:34:09	f41e3269-24d9-41d3-afea-eeaaf816951b
187	16	75	9	f	7	2021-01-25 16:34:09	2021-01-25 16:34:09	d61fd297-f357-47d4-817f-669093ef5f51
188	16	76	15	f	0	2021-01-25 16:34:09	2021-01-25 16:34:09	200cafe1-5422-436b-a9d0-6362833bb1bc
189	16	76	16	f	1	2021-01-25 16:34:09	2021-01-25 16:34:09	3338c292-b7d4-4442-bbd4-35b359793485
112	14	54	17	f	1	2021-01-25 15:02:19	2021-01-25 15:02:19	226ba1f6-626d-465e-be57-8f25a760239b
113	14	54	14	f	3	2021-01-25 15:02:19	2021-01-25 15:02:19	1053a595-9645-4c86-957c-be1d7d887f64
114	14	54	9	f	4	2021-01-25 15:02:19	2021-01-25 15:02:19	604497d6-93ec-47fb-97bc-388674f383f9
115	14	55	15	f	0	2021-01-25 15:02:19	2021-01-25 15:02:19	3b17a5dd-9cf6-46f2-930e-448eefbd68b1
116	14	55	16	f	1	2021-01-25 15:02:19	2021-01-25 15:02:19	85ca9915-ddda-4dcd-916a-16a94ea36dc6
428	20	126	34	f	6	2021-01-27 15:25:50	2021-01-27 15:25:50	c301781f-2403-44f4-95c4-b7a107d7538e
429	20	126	35	f	7	2021-01-27 15:25:50	2021-01-27 15:25:50	cf4366d0-6b5d-48ce-b996-8c1f4efc17e7
430	20	126	36	f	8	2021-01-27 15:25:50	2021-01-27 15:25:50	795afbfe-d2dc-4a6c-97bc-138de7161261
431	20	126	37	f	9	2021-01-27 15:25:50	2021-01-27 15:25:50	b415cbe7-56a1-4afa-8e48-866cd7ff9990
432	20	126	38	f	10	2021-01-27 15:25:50	2021-01-27 15:25:50	d28e1b46-43bb-4fb0-a18c-369442934784
433	20	126	22	f	12	2021-01-27 15:25:50	2021-01-27 15:25:50	880d5c7a-04c3-40de-b367-01c41ea4c900
434	20	126	23	f	13	2021-01-27 15:25:50	2021-01-27 15:25:50	d671a422-c650-4107-9b92-6326f495d2fd
190	16	77	12	f	0	2021-01-25 16:34:09	2021-01-25 16:34:09	084bc61f-f622-466b-82ff-4f0f21ae5b4b
191	16	77	10	f	1	2021-01-25 16:34:09	2021-01-25 16:34:09	b58303aa-660e-4a12-a29f-462f1047bab0
192	16	77	11	f	2	2021-01-25 16:34:09	2021-01-25 16:34:09	bfee969a-6b7f-4e37-961a-682bd7610367
197	17	80	30	f	1	2021-01-25 17:07:07	2021-01-25 17:07:07	a5b9d55f-642f-4f27-ba11-67209fa75754
198	17	80	31	f	2	2021-01-25 17:07:07	2021-01-25 17:07:07	31c46a37-340f-4e56-972d-03408d306037
199	17	80	32	f	3	2021-01-25 17:07:07	2021-01-25 17:07:07	4666fc26-bc35-42a9-93a7-b9a728d831d6
200	17	80	33	f	4	2021-01-25 17:07:07	2021-01-25 17:07:07	4b3a59b1-bede-42a8-821a-68117c26d851
201	17	80	8	f	5	2021-01-25 17:07:07	2021-01-25 17:07:07	5d513232-182e-4991-826b-83c0f49903e5
202	17	80	5	f	6	2021-01-25 17:07:07	2021-01-25 17:07:07	a8936821-be98-4dd5-ba76-45eca13112c2
203	17	80	14	f	8	2021-01-25 17:07:07	2021-01-25 17:07:07	6efbe523-ab35-4919-850e-ac2e4583bc14
204	17	80	9	f	9	2021-01-25 17:07:07	2021-01-25 17:07:07	a47bb011-07d0-4a4c-a6fc-21a43174845e
205	17	81	4	f	0	2021-01-25 17:07:07	2021-01-25 17:07:07	bf383269-c579-435d-8902-d83e6fa52900
206	17	81	6	f	1	2021-01-25 17:07:07	2021-01-25 17:07:07	2d70f041-adfc-41f6-afe9-e043fef94ce8
207	17	82	15	f	0	2021-01-25 17:07:07	2021-01-25 17:07:07	7f53e931-3833-4ff8-8cb8-193c30ec1f74
208	17	82	16	f	1	2021-01-25 17:07:07	2021-01-25 17:07:07	db9f56a7-1d10-432f-a389-dd33a8aec65a
435	20	126	39	f	14	2021-01-27 15:25:50	2021-01-27 15:25:50	b6799c2a-8e23-474a-810f-33c2062b91f0
436	20	126	40	f	15	2021-01-27 15:25:50	2021-01-27 15:25:50	c4eff0a3-9c46-4fe3-acad-0832b2ca5433
437	20	127	47	f	0	2021-01-27 15:25:50	2021-01-27 15:25:50	19bad46b-859a-45b8-9aaf-670b1191f516
438	20	127	48	f	1	2021-01-27 15:25:50	2021-01-27 15:25:50	13aad449-5faf-4724-82b1-71ce75ea2cd5
439	20	127	50	f	2	2021-01-27 15:25:50	2021-01-27 15:25:50	2aff351f-2452-4261-ac73-509ca2522eca
440	20	127	49	f	3	2021-01-27 15:25:50	2021-01-27 15:25:50	92ba3ddc-f7dc-4a99-bdf2-4e0c28122ce9
441	20	128	44	f	0	2021-01-27 15:25:50	2021-01-27 15:25:50	b28c8a76-40c7-4518-85ce-23d04dc18cb1
442	20	128	24	f	1	2021-01-27 15:25:50	2021-01-27 15:25:50	7bfbca90-5c32-470d-b23f-5c72296a12b1
443	20	128	27	f	2	2021-01-27 15:25:50	2021-01-27 15:25:50	4d497075-3c11-43d9-aadc-94e2ce7967b6
444	20	128	25	f	3	2021-01-27 15:25:50	2021-01-27 15:25:50	0345261a-4cdf-4444-91ff-3989a25fa581
445	20	128	26	f	4	2021-01-27 15:25:50	2021-01-27 15:25:50	3ca714a6-33d3-46ad-8d16-12efb81dc0cf
446	20	128	42	f	5	2021-01-27 15:25:50	2021-01-27 15:25:50	8e0b6966-7d00-4e2a-b801-7085ce75e54a
447	20	128	43	f	6	2021-01-27 15:25:50	2021-01-27 15:25:50	30e20084-43d2-4b55-bb4f-c0ef55418b17
453	21	132	6	f	1	2021-01-27 15:42:01	2021-01-27 15:42:01	c5beb647-ec1d-41a6-ac3d-e83f729a2f29
454	21	132	52	f	2	2021-01-27 15:42:01	2021-01-27 15:42:01	7a30377f-d1f9-4f01-95eb-d85048b95092
455	21	132	51	f	3	2021-01-27 15:42:01	2021-01-27 15:42:01	4bf56846-f9fe-46f3-8b1c-7014bdfc90f5
456	21	132	39	f	4	2021-01-27 15:42:01	2021-01-27 15:42:01	55480136-55c4-47d3-8358-cc97faccbf2d
457	21	132	53	f	5	2021-01-27 15:42:01	2021-01-27 15:42:01	9f148bde-d28f-48f1-a872-24e1e4dbcb48
\.


--
-- Data for Name: fieldlayouts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fieldlayouts (id, type, "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
2	craft\\elements\\Asset	2020-11-25 10:32:43	2020-11-25 10:32:43	\N	27caa54a-ccef-47d2-b7b4-05aab0d84ac4
3	craft\\elements\\Asset	2020-11-25 10:32:43	2020-11-25 10:32:43	\N	17fddcbf-504b-4f3d-a096-e52d47d417cb
8	craft\\elements\\Category	2021-01-22 14:35:05	2021-01-22 14:35:05	\N	655007d3-8586-4e80-96c0-e0c2e201b343
9	craft\\elements\\Entry	2021-01-22 14:48:20	2021-01-22 14:48:20	\N	c2bfcb97-5a33-4391-aef6-f939514b2fdf
13	craft\\elements\\Category	2021-01-25 14:34:23	2021-01-25 14:34:23	\N	a65f7e44-24f6-4456-92b9-32d7ea6766e1
14	craft\\elements\\Entry	2021-01-25 15:00:30	2021-01-25 15:00:30	\N	0218e180-021b-4456-a518-adda18fa6acb
15	craft\\elements\\Entry	2021-01-25 15:30:00	2021-01-25 15:30:00	\N	bc02eba3-888e-4833-9396-af64dae92bee
16	craft\\elements\\Entry	2021-01-25 16:24:39	2021-01-25 16:24:39	\N	3ed9cd20-9052-4216-9f78-2d7ad05a0351
17	craft\\elements\\Entry	2021-01-25 16:56:46	2021-01-25 16:56:46	\N	e633e577-fc52-4574-8ccb-971dbe2edda4
18	craft\\elements\\Asset	2021-01-27 08:57:12	2021-01-27 08:57:12	\N	76ba5428-f073-4669-846b-89e4b887a1d3
20	craft\\elements\\Entry	2021-01-27 13:27:36	2021-01-27 13:27:36	\N	fc561d93-5d34-40b4-a588-f309aeb64350
21	craft\\elements\\Entry	2021-01-27 15:06:55	2021-01-27 15:06:55	\N	a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8
22	craft\\elements\\Category	2021-01-27 15:40:44	2021-01-27 15:40:44	\N	94d02b6c-a146-4e67-9709-45dbe6b120ab
\.


--
-- Data for Name: fieldlayouttabs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fieldlayouttabs (id, "layoutId", name, elements, "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
80	17	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"0fe7b7e2-1d66-4533-b80c-3e1b63fce160"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"dd5974d9-ec7e-426b-aba0-2a01563861f4"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"8b581eed-f474-4169-a920-318f01f5e16c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"b819a17b-d2a6-48e3-81e8-e8496f4073c2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"38135310-b63d-4169-8f04-6fbbe0404998"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"18d73ec4-3757-40a2-a96a-cdedf667d895"},{"type":"craft\\\\fieldlayoutelements\\\\HorizontalRule"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"9ef612f5-8b16-401c-bd20-058431414095"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"10d914df-e824-4c0b-97c8-84c984dd0258"}]	1	2021-01-25 17:07:07	2021-01-25 17:07:07	4c3adcf0-4038-44d2-8e0d-335d0867dcc7
81	17	Meta	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"24403202-e90c-4bf2-9f60-d8b2146f107b"}]	2	2021-01-25 17:07:07	2021-01-25 17:07:07	fcbd353d-ee7d-437c-b163-428d474d8d18
82	17	Suchmaschine	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"ee9512d9-701e-4e12-842e-02a6030b0da9"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"e95bbf80-2274-41dc-b724-b2a404d796de"}]	3	2021-01-25 17:07:07	2021-01-25 17:07:07	35b6506a-1945-42c9-8b36-e447df51189f
133	2	Content	[{"type":"craft\\\\fieldlayoutelements\\\\AssetTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"","instructions":"","tip":null,"warning":null,"width":100}]	1	2021-01-27 15:48:33	2021-01-27 15:48:33	24cfa5fd-080e-49c8-b520-7afa7c209d3e
134	18	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\AssetTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2021-01-27 15:48:33	2021-01-27 15:48:33	d282fb6c-bd2a-4e2e-879d-2a20fa14091c
135	3	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\AssetTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2021-01-27 15:48:33	2021-01-27 15:48:33	95dee3b6-6625-4611-aa93-786740e2a5cd
125	20	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Name","instructions":"","tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"3a7873dc-80ec-4fc1-8702-0cd23d307ad0"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"5791152b-3883-4751-9803-a1efd9730f3d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"38135310-b63d-4169-8f04-6fbbe0404998"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"fa67a40b-6951-46d9-bda9-4369aa5dc327"},{"type":"craft\\\\fieldlayoutelements\\\\Heading","heading":"Standort"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"8b581eed-f474-4169-a920-318f01f5e16c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"b819a17b-d2a6-48e3-81e8-e8496f4073c2"}]	1	2021-01-27 15:25:50	2021-01-27 15:25:50	298655dc-2cfd-42b3-beaa-b9c1e457ffc7
126	20	Firma	[{"type":"craft\\\\fieldlayoutelements\\\\Heading","heading":"Ansprechpartner"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"b615217c-6a31-4d72-bc36-48a81c88be5d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"531d4f4f-7561-416d-a5f2-116a484ad6ff"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"f88bfc01-1476-4bd4-9a6a-b65fff783658"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"0157ca30-ec6c-42c5-8869-589c4bf6965f"},{"type":"craft\\\\fieldlayoutelements\\\\Heading","heading":"Anschrift"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"8cd7cefb-10df-4b63-a65f-2cadca1c4c1b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"4f5e11cf-b1e9-4f8e-a288-c8882b5b374d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"8d3d3523-0a94-44fa-be0d-11ecb92bdc20"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"5db55344-b925-4e15-b099-994baba0a7a4"},{"type":"craft\\\\fieldlayoutelements\\\\Heading","heading":"Kontakt"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"e402c4ce-9e9f-4644-8430-d6229f2d5737"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"39780143-51f5-4ce9-b1cf-0a9df42c8055"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"c85c285d-0701-44db-b2a7-306dd269680c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f"}]	2	2021-01-27 15:25:50	2021-01-27 15:25:50	ccf530fe-cae0-4df7-9f07-744cdf377c1a
127	20	Sonstiges	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"d619fc81-496a-4a1b-8f02-4a71c453f5d2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"a6d20208-15f2-493d-8a54-0adae2193700"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"1d9b5925-be5a-4c98-b2a8-eb7addbc635c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"68317155-d437-4b8a-a640-382a9092e553"}]	3	2021-01-27 15:25:50	2021-01-27 15:25:50	08e1dcfe-da4c-4b7c-ab9e-5c62451b3d77
128	20	Soziale Netzwerke	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"2b41ab49-178c-4ff2-b65d-fbbe2e33c562"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"9289a943-5ab0-45f8-9b78-876519730902"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"41e6657f-1bf4-42fb-bd66-4aea4f6d895b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"e61e3323-bb6b-466f-9f03-1a5c39d1605b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"f226fb33-c938-4e3d-9c88-8d5678ddb8ea"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"de7b667a-9d74-454c-bfd4-78f261a771a2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"dced25a8-d4dc-49a1-a4d9-4d7edea2959c"}]	4	2021-01-27 15:25:50	2021-01-27 15:25:50	cdf982a1-7b65-436c-9d7a-945b6321d007
20	8	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"","instructions":"","tip":null,"warning":null,"width":100}]	1	2021-01-22 14:50:52	2021-01-22 14:50:52	fda30623-2f9d-4c16-84e6-72f7168236db
48	13	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2021-01-25 14:38:57	2021-01-25 14:38:57	55f4e005-8d51-48df-ba7b-be349f1bf8e5
54	14	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"51fb8b04-05e1-4476-a9f5-008860e78c6b"},{"type":"craft\\\\fieldlayoutelements\\\\HorizontalRule"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"9ef612f5-8b16-401c-bd20-058431414095"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"10d914df-e824-4c0b-97c8-84c984dd0258"}]	1	2021-01-25 15:02:19	2021-01-25 15:02:19	8c299d75-98f0-4d33-94f7-83e1feba1951
55	14	Suchmaschine	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"ee9512d9-701e-4e12-842e-02a6030b0da9"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"e95bbf80-2274-41dc-b724-b2a404d796de"}]	2	2021-01-25 15:02:19	2021-01-25 15:02:19	b8faa19b-1f5e-4028-8f86-09118342924f
65	15	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":50},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"6b846f7f-9152-4526-813f-a931a421c454"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"b615217c-6a31-4d72-bc36-48a81c88be5d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"f88bfc01-1476-4bd4-9a6a-b65fff783658"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"0157ca30-ec6c-42c5-8869-589c4bf6965f"},{"type":"craft\\\\fieldlayoutelements\\\\HorizontalRule"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"92b7aba3-37db-44f6-bfb9-b7b63fb33ce9"}]	1	2021-01-25 15:39:18	2021-01-25 15:39:18	4ee9abdb-cd24-4717-b4b7-9e5ae4bbfb5c
66	15	Kontakt	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"e402c4ce-9e9f-4644-8430-d6229f2d5737"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"39780143-51f5-4ce9-b1cf-0a9df42c8055"},{"type":"craft\\\\fieldlayoutelements\\\\HorizontalRule"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"9289a943-5ab0-45f8-9b78-876519730902"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"41e6657f-1bf4-42fb-bd66-4aea4f6d895b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"e61e3323-bb6b-466f-9f03-1a5c39d1605b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"f226fb33-c938-4e3d-9c88-8d5678ddb8ea"}]	2	2021-01-25 15:39:18	2021-01-25 15:39:18	eecd4acb-4283-4a51-bcbd-74f65ff34528
68	9	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"24403202-e90c-4bf2-9f60-d8b2146f107b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"38135310-b63d-4169-8f04-6fbbe0404998"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Inhalt","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"18d73ec4-3757-40a2-a96a-cdedf667d895"},{"type":"craft\\\\fieldlayoutelements\\\\HorizontalRule"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"9ef612f5-8b16-401c-bd20-058431414095"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"10d914df-e824-4c0b-97c8-84c984dd0258"}]	1	2021-01-25 16:28:15	2021-01-25 16:28:15	028ca1f7-900c-40b8-8f51-11d6217ff50d
69	9	Suchmaschinen	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"ee9512d9-701e-4e12-842e-02a6030b0da9"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"e95bbf80-2274-41dc-b724-b2a404d796de"}]	2	2021-01-25 16:28:15	2021-01-25 16:28:15	2146b2e0-51f1-4fa1-92f3-bbb7a4193c27
70	9	Medien	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"739c8fb6-1cae-4dcb-94a0-59d0cbe8f662"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"9e502000-1aa2-4c0c-aff6-210966db7501"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d18731cd-c210-4397-bae3-3d498d1b6d8a"}]	3	2021-01-25 16:28:15	2021-01-25 16:28:15	1ebc8c6e-d6b1-43e5-889f-6164501edaa8
71	9	FAQ	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d93f6cc8-3554-4692-88db-230dc7d9bf0b"}]	4	2021-01-25 16:28:15	2021-01-25 16:28:15	66cb7e6d-a8c7-4ad6-8ee0-85addbd88812
131	22	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2021-01-27 15:40:44	2021-01-27 15:40:44	f29863ac-6069-4ba0-9d3f-c1e5ba64d340
75	16	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"24403202-e90c-4bf2-9f60-d8b2146f107b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"38135310-b63d-4169-8f04-6fbbe0404998"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"18d73ec4-3757-40a2-a96a-cdedf667d895"},{"type":"craft\\\\fieldlayoutelements\\\\HorizontalRule"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"9ef612f5-8b16-401c-bd20-058431414095"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"10d914df-e824-4c0b-97c8-84c984dd0258"}]	1	2021-01-25 16:34:09	2021-01-25 16:34:09	8e6c6a34-350a-48a0-a610-0b4620625f73
76	16	Suchmaschine	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"ee9512d9-701e-4e12-842e-02a6030b0da9"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"e95bbf80-2274-41dc-b724-b2a404d796de"}]	2	2021-01-25 16:34:09	2021-01-25 16:34:09	5d36379e-a2d2-43c9-a43d-6e553a02da0d
77	16	Medien	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"739c8fb6-1cae-4dcb-94a0-59d0cbe8f662"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"9e502000-1aa2-4c0c-aff6-210966db7501"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d18731cd-c210-4397-bae3-3d498d1b6d8a"}]	3	2021-01-25 16:34:09	2021-01-25 16:34:09	da6b4114-ad16-4f1f-b306-b7d065f5ffdc
132	21	Inhalt	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Name","instructions":"","tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"24403202-e90c-4bf2-9f60-d8b2146f107b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"dee5203e-54fb-4649-9f7f-11336a0b6da7"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"fa67a40b-6951-46d9-bda9-4369aa5dc327"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"c85c285d-0701-44db-b2a7-306dd269680c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"8de8794b-837b-4213-85e6-3496dfb21d96"}]	1	2021-01-27 15:42:01	2021-01-27 15:42:01	c172a0c9-efd6-4dea-b048-b38491a7bdbb
\.


--
-- Data for Name: fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fields (id, "groupId", name, handle, context, instructions, searchable, "translationMethod", "translationKeyFormat", type, settings, "dateCreated", "dateUpdated", uid) FROM stdin;
6	7	Titelbild	thumbimage	global		f	site	\N	craft\\fields\\Assets	{"allowSelfRelations":false,"allowUploads":true,"allowedKinds":null,"defaultUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","defaultUploadLocationSubpath":"","limit":"1","localizeRelations":false,"previewMode":"full","restrictFiles":"","selectionLabel":"","showSiteMenu":true,"showUnpermittedFiles":false,"showUnpermittedVolumes":false,"singleUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","singleUploadLocationSubpath":"","source":null,"sources":"*","targetSiteId":null,"useSingleFolder":false,"validateRelatedElements":false,"viewMode":"list"}	2020-11-25 10:32:43	2021-01-25 15:07:06	24403202-e90c-4bf2-9f60-d8b2146f107b
14	2	Kategorien	categories	global		t	site	\N	craft\\fields\\Categories	{"allowLimit":false,"allowMultipleSources":false,"allowSelfRelations":false,"branchLimit":"","limit":null,"localizeRelations":false,"selectionLabel":"","showSiteMenu":false,"source":"group:61b9cdf6-219a-4096-b35b-538d624e1ba9","sources":"*","targetSiteId":null,"validateRelatedElements":false,"viewMode":null}	2021-01-22 15:28:29	2021-01-22 15:49:20	9ef612f5-8b16-401c-bd20-058431414095
10	4	Downloads	downloads	global		f	site	\N	craft\\fields\\Assets	{"allowSelfRelations":false,"allowUploads":true,"allowedKinds":null,"defaultUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","defaultUploadLocationSubpath":"","limit":"","localizeRelations":false,"previewMode":"full","restrictFiles":"","selectionLabel":"","showSiteMenu":false,"showUnpermittedFiles":false,"showUnpermittedVolumes":false,"singleUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","singleUploadLocationSubpath":"","source":null,"sources":"*","targetSiteId":null,"useSingleFolder":false,"validateRelatedElements":false,"viewMode":"list"}	2021-01-22 15:16:45	2021-01-22 15:16:45	9e502000-1aa2-4c0c-aff6-210966db7501
13	4	Fragen & Antworten	faq	global		f	site	\N	craft\\fields\\Table	{"addRowLabel":"Zeile hinzufügen","columnType":"text","columns":{"col1":{"heading":"Frage","handle":"question","width":"","type":"singleline"},"col2":{"heading":"Antwort","handle":"answer","width":"","type":"singleline"}},"maxRows":"","minRows":""}	2021-01-22 15:23:51	2021-01-22 15:23:51	d93f6cc8-3554-4692-88db-230dc7d9bf0b
11	4	Videoeinbettung	videohtml	global		f	site	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"1","placeholder":"","uiMode":"enlarged"}	2021-01-22 15:21:12	2021-01-22 15:27:26	d18731cd-c210-4397-bae3-3d498d1b6d8a
9	2	Tags	tags	global		t	site	\N	craft\\fields\\Categories	{"allowLimit":false,"allowMultipleSources":false,"allowSelfRelations":false,"branchLimit":"","limit":null,"localizeRelations":false,"selectionLabel":"","showSiteMenu":false,"source":"group:68aee50b-ea3a-4325-aed3-211fef3f4db3","sources":"*","targetSiteId":null,"validateRelatedElements":false,"viewMode":null}	2021-01-22 14:32:48	2021-01-25 14:38:17	10d914df-e824-4c0b-97c8-84c984dd0258
12	4	Gallerie	images	global		f	site	\N	craft\\fields\\Assets	{"allowSelfRelations":false,"allowUploads":true,"allowedKinds":null,"defaultUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","defaultUploadLocationSubpath":"","limit":"","localizeRelations":false,"previewMode":"full","restrictFiles":"","selectionLabel":"","showSiteMenu":false,"showUnpermittedFiles":false,"showUnpermittedVolumes":false,"singleUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","singleUploadLocationSubpath":"","source":null,"sources":"*","targetSiteId":null,"useSingleFolder":false,"validateRelatedElements":false,"viewMode":"list"}	2021-01-22 15:22:13	2021-01-22 16:24:20	739c8fb6-1cae-4dcb-94a0-59d0cbe8f662
5	4	Inhalt	body	global		f	site	\N	craft\\redactor\\Field	{"availableTransforms":"*","availableVolumes":"*","cleanupHtml":true,"columnType":"text","configSelectionMode":"choose","defaultTransform":"","manualConfig":"","purifierConfig":"","purifyHtml":"1","redactorConfig":"","removeEmptyTags":"1","removeInlineStyles":"1","removeNbsp":"1","showHtmlButtonForNonAdmins":"1","showUnpermittedFiles":false,"showUnpermittedVolumes":false,"uiMode":"enlarged"}	2020-11-25 10:32:43	2021-01-22 16:27:12	18d73ec4-3757-40a2-a96a-cdedf667d895
4	7	Author	author	global		f	site	\N	craft\\fields\\Entries	{"allowSelfRelations":false,"limit":"1","localizeRelations":false,"selectionLabel":"","showSiteMenu":true,"source":null,"sources":["section:8ead6ec2-98a7-4ee4-9d59-c4ac9e294118"],"targetSiteId":null,"validateRelatedElements":false,"viewMode":null}	2020-11-25 10:32:43	2021-01-25 15:07:59	a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65
8	7	Teasertext	excerpt	global	Text erscheint in der Übersichtsseite	f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":400,"code":"","columnType":null,"initialRows":"4","multiline":"1","placeholder":"","uiMode":"normal"}	2020-11-25 14:16:57	2021-01-25 15:16:56	38135310-b63d-4169-8f04-6fbbe0404998
15	5	Meta Titel	meta_titel	global	Dieser Titel wird in den Suchmaschinen angezeigt. Empfehlenswert ist einen Mehrwert kommunizieren für einen Call-to-Action aktion.	f	site	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":70,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-22 16:15:54	2021-01-22 16:21:08	ee9512d9-701e-4e12-842e-02a6030b0da9
16	5	Meta Description	meta_description	global	Kurze Zusammenfassung des Inhalts, die in den Suchergebnissen von Suchmaschinen angezeigt wird. Die Beschreibung soll Besucher/innen zu verstehen zu geben, was sich hinter dem Ergebnis verbirgt.	f	site	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":160,"code":"","columnType":null,"initialRows":"4","multiline":"1","placeholder":"","uiMode":"normal"}	2021-01-22 16:17:17	2021-01-22 16:23:35	e95bbf80-2274-41dc-b724-b2a404d796de
17	6	Datei	file	global		f	site	\N	craft\\fields\\Assets	{"allowSelfRelations":false,"allowUploads":true,"allowedKinds":null,"defaultUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","defaultUploadLocationSubpath":"","limit":"","localizeRelations":false,"previewMode":"full","restrictFiles":"","selectionLabel":"","showSiteMenu":false,"showUnpermittedFiles":false,"showUnpermittedVolumes":false,"singleUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","singleUploadLocationSubpath":"","source":null,"sources":"*","targetSiteId":null,"useSingleFolder":false,"validateRelatedElements":false,"viewMode":"list"}	2021-01-25 14:59:26	2021-01-25 14:59:26	51fb8b04-05e1-4476-a9f5-008860e78c6b
27	9	Linkedin	linkedin	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"https://www.linkedin.com/company/google/","uiMode":"normal"}	2021-01-25 15:29:19	2021-01-25 15:46:45	41e6657f-1bf4-42fb-bd66-4aea4f6d895b
28	8	Titel	person_title	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-25 15:38:31	2021-01-25 15:38:31	6b846f7f-9152-4526-813f-a931a421c454
18	8	Vorname	person_firstname	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-25 15:21:34	2021-01-27 14:41:17	f88bfc01-1476-4bd4-9a6a-b65fff783658
22	9	E-Mail	email	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"john@doe.de","uiMode":"normal"}	2021-01-25 15:27:31	2021-01-25 15:41:32	e402c4ce-9e9f-4644-8430-d6229f2d5737
23	9	Telefon	phone	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"+49 69 756081-0","uiMode":"normal"}	2021-01-25 15:28:23	2021-01-25 15:41:48	39780143-51f5-4ce9-b1cf-0a9df42c8055
25	9	Twitter	twitter	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"https://twitter.com/bremen_de","uiMode":"normal"}	2021-01-25 15:28:47	2021-01-25 15:43:33	e61e3323-bb6b-466f-9f03-1a5c39d1605b
26	9	Xing	xing	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"https://www.xing.com/profile/Ugur_Sahin53","uiMode":"normal"}	2021-01-25 15:28:57	2021-01-25 15:44:33	f226fb33-c938-4e3d-9c88-8d5678ddb8ea
24	9	Facebook	facebook	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"https://www.facebook.com/IndustryArena","uiMode":"normal"}	2021-01-25 15:28:38	2021-01-25 15:44:54	9289a943-5ab0-45f8-9b78-876519730902
31	11	Personen	persons	global		f	site	\N	craft\\fields\\Entries	{"allowSelfRelations":false,"limit":"","localizeRelations":false,"selectionLabel":"","showSiteMenu":false,"source":null,"sources":["section:0daaa545-d1a0-4655-a507-2bac8b560f1d"],"targetSiteId":null,"validateRelatedElements":false,"viewMode":null}	2021-01-25 16:52:56	2021-01-25 16:52:56	dd5974d9-ec7e-426b-aba0-2a01563861f4
32	12	Halle	hall	global		f	none	\N	craft\\fields\\Number	{"decimals":0,"defaultValue":null,"max":"99","min":"0","prefix":"","previewCurrency":"","previewFormat":"decimal","size":null,"suffix":""}	2021-01-25 16:54:29	2021-01-25 16:54:29	8b581eed-f474-4169-a920-318f01f5e16c
33	12	Stand	booth	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"B13","uiMode":"normal"}	2021-01-25 16:55:20	2021-01-25 16:55:20	b819a17b-d2a6-48e3-81e8-e8496f4073c2
30	11	Datum	event_date	global		f	none	\N	craft\\fields\\Date	{"max":null,"min":null,"minuteIncrement":"60","showDate":true,"showTime":true}	2021-01-25 16:52:21	2021-01-25 17:02:30	0fe7b7e2-1d66-4533-b80c-3e1b63fce160
29	10	Datum	article_date	global		f	none	\N	craft\\fields\\Date	{"max":null,"min":null,"minuteIncrement":"60","showDate":true,"showTime":true}	2021-01-25 16:51:36	2021-01-25 17:03:43	b29474fd-4aaa-4f11-9f8f-eae1269ca9e0
34	13	Firmenname	address_name	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-27 13:17:32	2021-01-27 13:17:32	8cd7cefb-10df-4b63-a65f-2cadca1c4c1b
20	8	Anrede	person_salutation	global		f	none	\N	craft\\fields\\RadioButtons	{"options":[{"label":"Herr","value":"mr","default":"1"},{"label":"Frau","value":"mrs","default":""}]}	2021-01-25 15:23:07	2021-01-27 14:41:07	b615217c-6a31-4d72-bc36-48a81c88be5d
35	13	Straße	address_street	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-27 13:17:56	2021-01-27 13:17:56	4f5e11cf-b1e9-4f8e-a288-c8882b5b374d
36	13	PLZ	address_postalcode	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-27 13:18:07	2021-01-27 13:18:07	1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33
37	13	Stadt	address_city	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-27 13:18:25	2021-01-27 13:18:25	8d3d3523-0a94-44fa-be0d-11ecb92bdc20
48	14	VDW_AUFTRAG	vdw_auftrag	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-27 15:01:24	2021-01-27 15:01:24	a6d20208-15f2-493d-8a54-0adae2193700
38	13	Land	address_country	global	Kurzwahl nutzen, siehe https://de.wikipedia.org/wiki/ISO-3166-1-Kodierliste (Bsp. AT = Österreich, Vereinigte Staaten = US)	f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":2,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-27 13:22:22	2021-01-27 13:34:59	5db55344-b925-4e15-b099-994baba0a7a4
39	9	Webseite	website	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"https://example.org","uiMode":"normal"}	2021-01-27 14:35:56	2021-01-27 14:35:56	c85c285d-0701-44db-b2a7-306dd269680c
40	9	Fax	fax	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"+49 69 756081-0","uiMode":"normal"}	2021-01-27 14:36:45	2021-01-27 14:36:45	52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f
19	8	Nachname	person_lastname	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-25 15:21:53	2021-01-27 14:41:10	0157ca30-ec6c-42c5-8869-589c4bf6965f
21	8	Position	person_position	global		f	none	\N	craft\\fields\\Dropdown	{"optgroups":true,"options":[{"label":"Selbständiger Unternehmer, Mitinhaber","value":"selbstaendigerUnternehmerMitinhaber","default":""},{"label":"freiberuflich Tätiger","value":"freiberuflichTaetiger","default":""},{"label":"Geschäftsführer, Vorstandsmitglied","value":"geschaeftsfuehrerVorstandsmitglied","default":""},{"label":"Behördenleiter","value":"behoerdenleiter","default":""},{"label":"Bereichsleiter, Betrieb-, Werks-, Filialleiter","value":"bereichsleiterBetriebWerksFilialleiter","default":""},{"label":"Amtsleiter","value":"amtsleiter","default":""},{"label":"Abteilungsleiter, Gruppenleiter/Teamleiter","value":"abteilungsleiterGruppenleiterTeamleiter","default":""},{"label":"Andere Angestellte/Beamte, Facharbeiter","value":"andereAngestellteBeamteFacharbeiter","default":""},{"label":"Dozent, Lehrer","value":"dozentLehrer","default":""},{"label":"Auszubildender","value":"auszubildender","default":""},{"label":"Andere berufliche Stellung","value":"andereBeruflicheStellung","default":""},{"label":"Schüler","value":"schueler","default":""},{"label":"Student","value":"student","default":""},{"label":"Nicht berufstätig","value":"nichtBerufstaetig","default":""}]}	2021-01-25 15:26:41	2021-01-27 14:41:14	92b7aba3-37db-44f6-bfb9-b7b63fb33ce9
41	8	E-Mail	person_email	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-27 14:42:30	2021-01-27 14:42:30	531d4f4f-7561-416d-a5f2-116a484ad6ff
42	9	Instagram	instagram	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"https://www.instagram.com/rogueinvitational/","uiMode":"normal"}	2021-01-27 14:50:59	2021-01-27 14:50:59	de7b667a-9d74-454c-bfd4-78f261a771a2
43	9	Youtube	youtube	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"https://www.youtube.com/user/Siemens","uiMode":"normal"}	2021-01-27 14:51:25	2021-01-27 14:51:25	dced25a8-d4dc-49a1-a4d9-4d7edea2959c
44	9	IndustryArena	industryarena	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"https://industryarena.com/umati","uiMode":"normal"}	2021-01-27 14:52:10	2021-01-27 14:52:10	2b41ab49-178c-4ff2-b65d-fbbe2e33c562
45	14	Logo	logo	global		f	site	\N	craft\\fields\\Assets	{"allowSelfRelations":false,"allowUploads":true,"allowedKinds":null,"defaultUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","defaultUploadLocationSubpath":"","limit":"1","localizeRelations":false,"previewMode":"full","restrictFiles":"","selectionLabel":"","showSiteMenu":false,"showUnpermittedFiles":false,"showUnpermittedVolumes":false,"singleUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","singleUploadLocationSubpath":"","source":null,"sources":"*","targetSiteId":null,"useSingleFolder":false,"validateRelatedElements":false,"viewMode":"list"}	2021-01-27 14:57:36	2021-01-27 14:57:36	3a7873dc-80ec-4fc1-8702-0cd23d307ad0
46	14	Bühnenbild	bbi	global		f	site	\N	craft\\fields\\Assets	{"allowSelfRelations":false,"allowUploads":true,"allowedKinds":null,"defaultUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","defaultUploadLocationSubpath":"","limit":"1","localizeRelations":false,"previewMode":"full","restrictFiles":"","selectionLabel":"","showSiteMenu":false,"showUnpermittedFiles":false,"showUnpermittedVolumes":false,"singleUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","singleUploadLocationSubpath":"","source":null,"sources":"*","targetSiteId":null,"useSingleFolder":false,"validateRelatedElements":false,"viewMode":"list"}	2021-01-27 14:58:01	2021-01-27 14:58:01	5791152b-3883-4751-9803-a1efd9730f3d
47	14	VDW_ID	vdw_id	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-27 15:01:04	2021-01-27 15:01:04	d619fc81-496a-4a1b-8f02-4a71c453f5d2
49	14	Veranstaltungsjahr	event_year	global		f	none	\N	craft\\fields\\Number	{"decimals":0,"defaultValue":"2019","max":"2060","min":"2018","prefix":"","previewCurrency":"","previewFormat":"decimal","size":null,"suffix":""}	2021-01-27 15:02:51	2021-01-27 15:02:51	68317155-d437-4b8a-a640-382a9092e553
50	14	SEKTOR ID	sektor_id	global		f	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"","uiMode":"normal"}	2021-01-27 15:04:44	2021-01-27 15:04:44	1d9b5925-be5a-4c98-b2a8-eb7addbc635c
51	4	Inhalt	body_raw	global		f	site	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"12","multiline":"1","placeholder":"","uiMode":"normal"}	2021-01-27 15:25:35	2021-01-27 15:25:35	fa67a40b-6951-46d9-bda9-4369aa5dc327
52	15	Bilder	product_images	global		f	site	\N	craft\\fields\\Assets	{"allowSelfRelations":false,"allowUploads":true,"allowedKinds":null,"defaultUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","defaultUploadLocationSubpath":"","limit":"","localizeRelations":false,"previewMode":"full","restrictFiles":"","selectionLabel":"","showSiteMenu":false,"showUnpermittedFiles":false,"showUnpermittedVolumes":false,"singleUploadLocationSource":"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd","singleUploadLocationSubpath":"","source":null,"sources":"*","targetSiteId":null,"useSingleFolder":false,"validateRelatedElements":false,"viewMode":"list"}	2021-01-27 15:30:37	2021-01-27 15:30:37	dee5203e-54fb-4649-9f7f-11336a0b6da7
53	2	Produktkategorie	produkt_category	global		f	site	\N	craft\\fields\\Categories	{"allowLimit":false,"allowMultipleSources":false,"allowSelfRelations":false,"branchLimit":"1","limit":null,"localizeRelations":false,"selectionLabel":"","showSiteMenu":false,"source":"group:c01c0c86-571a-4af8-a30b-622e93d627d3","sources":"*","targetSiteId":null,"validateRelatedElements":false,"viewMode":null}	2021-01-27 15:41:46	2021-01-27 15:41:46	8de8794b-837b-4213-85e6-3496dfb21d96
\.


--
-- Data for Name: globalsets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.globalsets (id, name, handle, "fieldLayoutId", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: gqlschemas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gqlschemas (id, name, scope, "isPublic", "dateCreated", "dateUpdated", uid) FROM stdin;
1	DMAG	["sections.08161406-afd7-44e4-b188-ebaadac868c6:read","entrytypes.108570f4-3617-457d-a46e-c406066c04a4:read","sections.37b0574b-1b49-4f90-9362-9d503abf7eac:read","entrytypes.d05ed799-bbf3-4ead-8a61-965073026ee3:read","sections.8ead6ec2-98a7-4ee4-9d59-c4ac9e294118:read","entrytypes.c3e9dcdd-0256-499c-bf09-b1665dea607f:read","volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd:read","volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91:read"]	f	2020-11-25 10:32:43	2020-11-30 17:50:54	3250dc31-0c3c-44aa-80ce-af78d5ac2ad5
3	Authenticated	["sections.08161406-afd7-44e4-b188-ebaadac868c6:read","entrytypes.108570f4-3617-457d-a46e-c406066c04a4:read","sections.37b0574b-1b49-4f90-9362-9d503abf7eac:read","entrytypes.d05ed799-bbf3-4ead-8a61-965073026ee3:read","sections.8ead6ec2-98a7-4ee4-9d59-c4ac9e294118:read","entrytypes.c3e9dcdd-0256-499c-bf09-b1665dea607f:read","volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd:read","volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91:read","usergroups.everyone:read","usergroups.0144de20-93d5-432d-ba93-f08f4a599148:read","usergroups.b3ebc429-1aaf-4077-9b55-732d13785f99:read","taggroups.ea2dcd3b-7935-4765-9020-baa37294e9ab:read"]	f	2020-11-30 14:47:26	2020-12-14 15:12:05	8fef4b60-b73e-42af-aa08-dc5646a0b808
2	Public Schema	["sections.9b5bd243-bb29-4fea-81a4-e597852129b7:read","entrytypes.e7599b97-ad13-4eea-bd62-3fdd165886ce:read","sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d:read","entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:read","sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c:read","entrytypes.4926019f-9936-4a51-a84f-38d927e89c25:read","sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933:read","entrytypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e:read","sections.0daaa545-d1a0-4655-a507-2bac8b560f1d:read","entrytypes.f2313657-ca71-492d-9931-0f1a1c49cdce:read","sections.2a038e37-6c48-4746-8b6d-b27fabf7972f:read","entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:read","sections.06745480-8d8c-4976-934e-dc80b2ab5632:read","entrytypes.75c0a1e7-4014-4664-ac9e-01d4114becdc:read","volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd:read","volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91:read","volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7:read","categorygroups.61b9cdf6-219a-4096-b35b-538d624e1ba9:read","categorygroups.68aee50b-ea3a-4325-aed3-211fef3f4db3:read","categorygroups.c01c0c86-571a-4af8-a30b-622e93d627d3:read"]	t	2020-11-25 10:32:43	2021-01-27 16:15:31	e5041870-fbde-43c9-97ce-9950766b32e5
5	IndustryArena	["sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d:read","entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:read","sections.2a038e37-6c48-4746-8b6d-b27fabf7972f:read","entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:read","volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd:read","volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91:read","volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7:read","sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d:edit","entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:edit","entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:create","entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:save","entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:delete","sections.2a038e37-6c48-4746-8b6d-b27fabf7972f:edit","entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:edit","entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:create","entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:save","entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:delete"]	f	2021-01-29 15:40:42	2021-01-29 15:40:42	5b81e3ee-a4a7-4060-86fc-deb4965e0741
\.


--
-- Data for Name: gqltokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gqltokens (id, name, "accessToken", enabled, "expiryDate", "lastUsed", "schemaId", "dateCreated", "dateUpdated", uid) FROM stdin;
1	Public Token	__PUBLIC__	t	\N	\N	2	2020-11-25 10:32:43	2020-11-25 10:32:43	6634f07a-4f47-4e35-ad8b-2aaf1689502e
75	IA_DEV	ph8s9Al8-6vK_dD8psoNpCh0DJjO0sTt	t	\N	2021-01-29 15:50:33	5	2021-01-29 15:41:28	2021-01-29 15:50:33	2adf15d7-8b7d-420a-834e-ab0dbe17f41d
\.


--
-- Data for Name: info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.info (id, version, "schemaVersion", maintenance, "configVersion", "fieldVersion", "dateCreated", "dateUpdated", uid) FROM stdin;
1	3.6.1	3.6.1	f	icikexakoftq	neokxedtqihi	2020-11-25 10:32:42	2021-01-29 15:40:42	7bba6cb4-ff69-41e4-a748-b6bebfd19d54
\.


--
-- Data for Name: matrixblocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.matrixblocks (id, "ownerId", "fieldId", "typeId", "sortOrder", "deletedWithOwner", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: matrixblocktypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.matrixblocktypes (id, "fieldId", "fieldLayoutId", name, handle, "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, track, name, "applyTime", "dateCreated", "dateUpdated", uid) FROM stdin;
1	plugin:redactor	m180430_204710_remove_old_plugins	2020-11-25 10:32:43	2020-11-25 10:32:43	2020-11-25 10:32:43	b6dff910-9df8-412a-977d-28b8d8c8ef0b
2	plugin:redactor	Install	2020-11-25 10:32:43	2020-11-25 10:32:43	2020-11-25 10:32:43	4842787f-87b7-447c-ac54-d4d8fcce93d1
3	plugin:redactor	m190225_003922_split_cleanup_html_settings	2020-11-25 10:32:43	2020-11-25 10:32:43	2020-11-25 10:32:43	eeca3fee-427d-4a96-8a95-88d11703f739
4	craft	Install	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	532f2bd9-7285-4c58-9fc7-7dd31849e473
5	craft	m150403_183908_migrations_table_changes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	43684475-dc8a-4d3c-b04b-2f187bdee93b
6	craft	m150403_184247_plugins_table_changes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	28fc3ed2-edb9-480c-bc1a-628f19bcc977
7	craft	m150403_184533_field_version	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	6d7b68e8-a85c-47ec-80ae-1e18cf53f3cc
8	craft	m150403_184729_type_columns	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	ed481cf8-b068-4aca-aa4c-3f810b6d4b1d
9	craft	m150403_185142_volumes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	ce2e0b23-3289-4bbb-a982-6c345c725d83
10	craft	m150428_231346_userpreferences	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	69c69332-4e3a-4039-ac09-dfb670cdc780
11	craft	m150519_150900_fieldversion_conversion	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	7d3b14ba-f653-4b4d-8951-7b17693d61b5
12	craft	m150617_213829_update_email_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	a2990ba6-1e44-4d0c-930b-5c11c9d814db
13	craft	m150721_124739_templatecachequeries	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	c46da47b-4865-46d3-a0e7-478a0053f511
14	craft	m150724_140822_adjust_quality_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	a4118bc7-e1f2-48cf-af0b-f3679dd9540b
15	craft	m150815_133521_last_login_attempt_ip	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	8a68a5bb-db91-4efc-a3b2-ee2dc4a0284d
16	craft	m151002_095935_volume_cache_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	feab7132-6374-485e-b3b2-30696666215c
17	craft	m151005_142750_volume_s3_storage_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	dfd40b53-c10f-4bc6-8949-2c77dd48c072
18	craft	m151016_133600_delete_asset_thumbnails	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	bcd1ad7e-9f16-4cf4-afbf-d51ce4b36813
19	craft	m151209_000000_move_logo	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	36911d4d-6d79-4284-a18c-4f570342c5a7
20	craft	m151211_000000_rename_fileId_to_assetId	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	5f8bf593-a263-4b5d-8cd8-bbba33681d93
21	craft	m151215_000000_rename_asset_permissions	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	2f575548-d7aa-4b0c-9189-884337566b27
22	craft	m160707_000001_rename_richtext_assetsource_setting	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	c775d55b-8861-4e26-a4b9-a86b518c3c3e
23	craft	m160708_185142_volume_hasUrls_setting	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	505795d8-63d3-47ae-ac95-b50faed3f283
24	craft	m160714_000000_increase_max_asset_filesize	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	3abdf961-77e9-4e2f-aa55-de0a2eebcd30
25	craft	m160727_194637_column_cleanup	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	5b76049e-fa3e-45b8-8283-f4c7e95dad97
26	craft	m160804_110002_userphotos_to_assets	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	3187f0e2-e768-4524-8f9a-024121743490
27	craft	m160807_144858_sites	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	85dab4c0-8de3-401c-96b4-4a3526c436b7
28	craft	m160829_000000_pending_user_content_cleanup	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	efa9e56e-5676-4dea-bdaa-6258d6d5c4ee
29	craft	m160830_000000_asset_index_uri_increase	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	58526ab8-befe-42ad-ad32-a168f97f911f
30	craft	m160912_230520_require_entry_type_id	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	345f4ab6-4e23-4637-bea1-c671e13242a7
31	craft	m160913_134730_require_matrix_block_type_id	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	6d8433fc-ae2d-45b0-9cf1-3d06c7412951
32	craft	m160920_174553_matrixblocks_owner_site_id_nullable	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	8d132f45-96e8-4e07-9c20-5bb57e78ca5f
33	craft	m160920_231045_usergroup_handle_title_unique	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	42435516-b1b8-4c36-a122-29ab1f61ed39
34	craft	m160925_113941_route_uri_parts	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	0de16746-3a6a-4004-8758-9da1eccc935a
35	craft	m161006_205918_schemaVersion_not_null	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	af3d8464-58a1-4fd3-b958-9e92640bbc95
36	craft	m161007_130653_update_email_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	73901c3d-c5b8-4e84-8d08-409d39cea188
37	craft	m161013_175052_newParentId	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	36ba2a65-ffce-44ea-a2b9-2ffa942ee5bd
38	craft	m161021_102916_fix_recent_entries_widgets	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	1c9b4329-bac4-44c5-9fd6-0a2eb2149a70
39	craft	m161021_182140_rename_get_help_widget	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	e0cbdf90-7f9b-4730-b217-dea80acca1e6
40	craft	m161025_000000_fix_char_columns	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	50c2fea4-ab20-4372-b1fd-432b409a0cff
41	craft	m161029_124145_email_message_languages	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	419791f6-4c48-4097-9aa6-4af27bad6fae
42	craft	m161108_000000_new_version_format	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	3a2a5aa3-c201-4520-b758-27e599b2ab33
43	craft	m161109_000000_index_shuffle	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	45f22ddd-18e2-4fd2-a2ee-250b700805bb
44	craft	m161122_185500_no_craft_app	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	b9b0470b-fe5b-4855-8d5d-2db6ff7aa096
45	craft	m161125_150752_clear_urlmanager_cache	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	a97803f4-253d-4a21-a9dc-258fcdcedc77
46	craft	m161220_000000_volumes_hasurl_notnull	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	948c68f7-dad0-4394-90f4-d2cdeefb20b2
47	craft	m170114_161144_udates_permission	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	47688682-0c3a-45cc-a913-c483fffb4a1b
48	craft	m170120_000000_schema_cleanup	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	a50a900d-d48f-4751-b9e8-4b5003aacf2e
49	craft	m170126_000000_assets_focal_point	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	3f06a0cf-a099-4131-99b5-db714410ae17
50	craft	m170206_142126_system_name	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	4550f68f-7c56-4421-ad2f-326cc1009f7e
51	craft	m170217_044740_category_branch_limits	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	7194a69a-0779-479b-ad90-f1f84d1f566f
52	craft	m170217_120224_asset_indexing_columns	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	28545f41-7f13-40ec-aa1d-0bf6518c308a
53	craft	m170223_224012_plain_text_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	828c8ca8-30c3-4179-9315-45342349708a
54	craft	m170227_120814_focal_point_percentage	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	9356932d-5f94-43bf-b714-513542528392
55	craft	m170228_171113_system_messages	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	bc5a7d0c-f694-432c-a723-1ca7c02394fa
56	craft	m170303_140500_asset_field_source_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	0b2dadd2-ebfc-4b3b-85d8-0b09c9807149
57	craft	m170306_150500_asset_temporary_uploads	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	9e1ffd8f-b184-4c58-816e-ce6c8d238630
58	craft	m170523_190652_element_field_layout_ids	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	ae584d7e-b276-428c-a883-787e283bc09b
59	craft	m170621_195237_format_plugin_handles	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	2a26d665-247f-4cc5-b51a-3074fc4e0bd3
60	craft	m170630_161027_deprecation_line_nullable	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	552bc86f-5b2d-4904-9809-fd875c7597b8
61	craft	m170630_161028_deprecation_changes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	7fe88180-c401-4c79-a6df-380d54287281
62	craft	m170703_181539_plugins_table_tweaks	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	64f8204a-9bc8-46a1-8c06-13b347ee84b8
63	craft	m170704_134916_sites_tables	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	bb685c9f-7d51-403a-b068-61fd258e4370
64	craft	m170706_183216_rename_sequences	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	d1bd1920-e9bc-406f-a8a6-6c25c35ad9eb
65	craft	m170707_094758_delete_compiled_traits	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	bfff27e9-645b-4c26-91dd-423a8c4e65e6
66	craft	m170731_190138_drop_asset_packagist	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	4f5d68b4-c854-44bb-84a0-557172714331
67	craft	m170810_201318_create_queue_table	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	430e746b-aeb5-441d-9467-316cae8f3070
68	craft	m170903_192801_longblob_for_queue_jobs	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	db6fe4c3-a2dc-49ab-9477-92d03ad490f4
69	craft	m170914_204621_asset_cache_shuffle	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	2f5c66b7-66fc-4a79-8230-7d85e2e3a6ee
70	craft	m171011_214115_site_groups	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	0a53e7b4-2556-442a-b1cd-e345ee98b9cf
71	craft	m171012_151440_primary_site	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	8003e397-9689-4305-a219-fc79c452ac5d
72	craft	m171013_142500_transform_interlace	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	01dc142c-7f64-4eb5-a6a8-c5a0098fa744
73	craft	m171016_092553_drop_position_select	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	6e15e0f7-c401-4313-bd3d-e7eafbddeba8
74	craft	m171016_221244_less_strict_translation_method	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	631ee82c-c92f-429c-be2c-c30132dfb640
75	craft	m171107_000000_assign_group_permissions	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	0a2917f9-ef39-44ea-a185-124fdc7fe635
76	craft	m171117_000001_templatecache_index_tune	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	af866ac9-e7cd-43fc-965d-c512fc3a4664
77	craft	m171126_105927_disabled_plugins	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	9bfee9b5-799d-466a-88ed-5377a41666a0
78	craft	m171130_214407_craftidtokens_table	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	31c058bb-dddf-4b57-b630-77a41c0b8714
79	craft	m171202_004225_update_email_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	37b23a62-5fca-4f7e-b25b-5287f5c60499
80	craft	m171204_000001_templatecache_index_tune_deux	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	b5120f2a-a0b7-452c-bb0c-7bcc8f6a3dfd
81	craft	m171205_130908_remove_craftidtokens_refreshtoken_column	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	385e6a1d-7efc-4ede-b2e4-a9cf02691a3d
82	craft	m171218_143135_longtext_query_column	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	ac27492f-96bd-43d7-8299-72af81d4cbe9
83	craft	m171231_055546_environment_variables_to_aliases	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	035cab8d-a984-4fcb-9435-1f380bc2963d
84	craft	m180113_153740_drop_users_archived_column	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	00d5f4c5-ef01-41ac-86f0-162ae3e851ec
85	craft	m180122_213433_propagate_entries_setting	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	338d3850-453e-4850-a98e-3af5575af4d9
86	craft	m180124_230459_fix_propagate_entries_values	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	a5362730-b358-40f7-b780-e99cd449dd86
87	craft	m180128_235202_set_tag_slugs	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	e2e53aed-91cd-41ea-a4dd-8eacd222e40a
88	craft	m180202_185551_fix_focal_points	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	0babc412-3aa4-4775-92e4-24f1211ebd47
89	craft	m180217_172123_tiny_ints	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	60c312c6-3481-46c4-97dc-bb1e3e892f3e
90	craft	m180321_233505_small_ints	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	96cd7b47-b965-4fe1-ab72-9f8d801ffab3
91	craft	m180328_115523_new_license_key_statuses	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	cdf61fe5-f159-4a13-8387-c27981841349
92	craft	m180404_182320_edition_changes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	8412585a-22d2-4318-b25b-78d55c2b4f4a
93	craft	m180411_102218_fix_db_routes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	1ce0bebf-5652-4b36-8d38-6bda95f6c109
94	craft	m180416_205628_resourcepaths_table	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	2f10422e-14be-495f-afa8-5b8bb4b145a7
95	craft	m180418_205713_widget_cleanup	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	d5c3eba6-11d2-4e67-aefd-795c1d150ba2
96	craft	m180425_203349_searchable_fields	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	39718c0e-e1c6-41ed-94d7-a897f75fc7e6
97	craft	m180516_153000_uids_in_field_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	026a2ba1-a02e-4e84-8189-5f25b4d1d3b9
98	craft	m180517_173000_user_photo_volume_to_uid	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	4f90a735-6245-451f-9279-9820d1a1eae8
99	craft	m180518_173000_permissions_to_uid	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	40eab31e-7965-487b-9ac0-526bcf62f850
100	craft	m180520_173000_matrix_context_to_uids	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	ebaf01b9-835f-4469-ad79-b6fc119af2c8
101	craft	m180521_172900_project_config_table	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	c9bab022-823a-43a7-8808-c12dc91c5253
102	craft	m180521_173000_initial_yml_and_snapshot	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	f2dc08d5-5245-44ce-997d-8c7da631c316
103	craft	m180731_162030_soft_delete_sites	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	2e4a39c3-ce98-4c8c-989e-82b3a76df32a
104	craft	m180810_214427_soft_delete_field_layouts	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	ed234efb-3c89-4761-ae71-9a65312c4805
105	craft	m180810_214439_soft_delete_elements	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	640a2a98-4edd-4741-b147-26136d68b705
106	craft	m180824_193422_case_sensitivity_fixes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	82ede391-6d05-49fc-8e02-8a5b4b922676
107	craft	m180901_151639_fix_matrixcontent_tables	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	9684442c-e25f-4837-9350-ab3525694b7a
108	craft	m180904_112109_permission_changes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	1d09a740-03aa-4ae3-8407-d915098871bb
109	craft	m180910_142030_soft_delete_sitegroups	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	afef2ae7-6b37-4d91-a528-0ef694f66fa1
110	craft	m181011_160000_soft_delete_asset_support	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	3db8f9a8-1b56-4975-a81e-31649d83a762
111	craft	m181016_183648_set_default_user_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	17d45403-6c44-4a2c-983c-5a91ff83d3e0
112	craft	m181017_225222_system_config_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	39fbc9f8-1cac-4cf9-903d-502a2d28575f
113	craft	m181018_222343_drop_userpermissions_from_config	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	2eb80eb3-0cf7-4a14-959c-6d1f3c7399e2
114	craft	m181029_130000_add_transforms_routes_to_config	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	b7b121ca-2b2f-4c87-afa1-5d8e352b1a49
115	craft	m181112_203955_sequences_table	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	22731b26-cd73-4590-821c-7693d9ce0e59
116	craft	m181121_001712_cleanup_field_configs	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	3b10097b-de87-413a-832c-b0ad4b5faec2
117	craft	m181128_193942_fix_project_config	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	c06887b3-f966-4dee-9906-32cebb0b3b31
118	craft	m181130_143040_fix_schema_version	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	44e3d79e-b078-4c01-858b-b7b45dddde01
119	craft	m181211_143040_fix_entry_type_uids	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	6ee8ebf7-d297-4d43-a8ac-c23c996825f1
120	craft	m181217_153000_fix_structure_uids	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	c34b56ad-484d-4fef-9e01-d824347024e4
121	craft	m190104_152725_store_licensed_plugin_editions	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	afa1b4ca-cfae-467a-9f6d-ba91b23082bd
122	craft	m190108_110000_cleanup_project_config	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	3fa7d8b2-9706-48d0-ae28-0540d0e01d9e
123	craft	m190108_113000_asset_field_setting_change	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	b08da928-971d-400c-b3f3-ad2dd4133c1c
124	craft	m190109_172845_fix_colspan	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	2d71857d-a2f1-4cf8-ab63-aad5d2becb25
125	craft	m190110_150000_prune_nonexisting_sites	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	b4cddf01-9e21-4e36-8a9d-bd639df0544e
126	craft	m190110_214819_soft_delete_volumes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	0aa5058c-8ca7-4ed8-9c04-ced4226ba939
127	craft	m190112_124737_fix_user_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	3fde533f-581b-42ac-a39a-b7eb2bc1ebe8
128	craft	m190112_131225_fix_field_layouts	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	d644d04d-778b-49a3-91c7-10ca4a07f8fb
129	craft	m190112_201010_more_soft_deletes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	bccedfc6-5695-4272-9e7e-9f2c30555962
130	craft	m190114_143000_more_asset_field_setting_changes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	d09ce7c9-cc2e-46e5-ba0c-3aaa13238692
131	craft	m190121_120000_rich_text_config_setting	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	9df490cb-c7bc-43cf-b56f-41be44f8a0a9
132	craft	m190125_191628_fix_email_transport_password	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	7d2a66b7-9214-4036-903d-85d4f15403b6
133	craft	m190128_181422_cleanup_volume_folders	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	99f09b07-c4fa-48f6-b5bc-c88034dd408d
134	craft	m190205_140000_fix_asset_soft_delete_index	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	43e637b1-445f-49dd-86a1-bebbeb635e86
135	craft	m190218_143000_element_index_settings_uid	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	ea16bfa1-7340-426d-ab88-e4e3123dc552
136	craft	m190312_152740_element_revisions	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	c1d8afeb-4105-49db-9df0-d39ad0e87dcf
137	craft	m190327_235137_propagation_method	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	a418bc4c-20ca-48af-b240-66635a5b246d
138	craft	m190401_223843_drop_old_indexes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	b4b70be6-3945-46f9-9de5-a81b84393f05
139	craft	m190416_014525_drop_unique_global_indexes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	d84f55b3-773b-439e-942f-a4eafef6b52f
140	craft	m190417_085010_add_image_editor_permissions	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	40ba8a06-373b-4d70-ac20-24d5790e8c2a
141	craft	m190502_122019_store_default_user_group_uid	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	694ba2f5-835a-4b27-87c0-734afd3c4505
142	craft	m190504_150349_preview_targets	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	fb645151-1c26-442c-a110-4487e9e914da
143	craft	m190516_184711_job_progress_label	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	66c71741-7f32-4c1e-b4d7-3ecf69651b5d
144	craft	m190523_190303_optional_revision_creators	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	04779252-3729-4d85-8201-8d2d126919a3
145	craft	m190529_204501_fix_duplicate_uids	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	a1c261cb-f4c3-4584-bf07-06edd118d96d
146	craft	m190605_223807_unsaved_drafts	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	d7deea31-65a2-46fa-a844-57b94c6b9543
147	craft	m190607_230042_entry_revision_error_tables	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	27bec210-5c25-4535-bba5-77699d6773d6
148	craft	m190608_033429_drop_elements_uid_idx	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	a77fd817-a723-4b26-8930-0299c6fa0ff6
149	craft	m190617_164400_add_gqlschemas_table	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	d83b917a-181e-49ff-9e66-10c654be89ce
150	craft	m190624_234204_matrix_propagation_method	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	c571a75a-72a2-4774-8395-c2a63cf1ba08
151	craft	m190711_153020_drop_snapshots	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	f354f7e1-81cd-49b6-8d92-6ccace6a7e2b
152	craft	m190712_195914_no_draft_revisions	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	c12edfff-a1a9-4eaf-ad48-bf9df0c84b0c
153	craft	m190723_140314_fix_preview_targets_column	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	ef4bacbc-a664-4eb3-af85-f050239c18a1
154	craft	m190820_003519_flush_compiled_templates	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	0e1cc122-6de8-4c8c-9b0a-5c239e1b153a
155	craft	m190823_020339_optional_draft_creators	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	b92d5456-1dd2-4bf4-becd-fdd948ea3501
156	craft	m190913_152146_update_preview_targets	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	eb979e4e-cdec-4298-bf1b-299a3ae271ba
157	craft	m191107_122000_add_gql_project_config_support	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	5e3afe3c-e9ab-48a9-94da-6a13a1f04448
158	craft	m191204_085100_pack_savable_component_settings	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	e13276e3-f398-420d-abc7-2377f1b764f6
159	craft	m191206_001148_change_tracking	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	116d45aa-6396-4832-9bab-ec24fac019fa
160	craft	m191216_191635_asset_upload_tracking	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	02df5de9-ac12-4bfb-89ab-93d7884cb5fe
161	craft	m191222_002848_peer_asset_permissions	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	53756045-917c-4fe9-8e4d-0fe58fc1782b
162	craft	m200127_172522_queue_channels	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	8c29ab99-fc80-45b0-a0cf-7585a54306ff
163	craft	m200211_175048_truncate_element_query_cache	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	93b99db2-0063-4a8f-bc49-7b0a4ee062b9
164	craft	m200213_172522_new_elements_index	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	28351bbb-0e11-4218-942c-bbfef79f9a00
165	craft	m200228_195211_long_deprecation_messages	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	52499b9b-af0c-4b88-91b3-b123b48d71f4
166	craft	m200306_054652_disabled_sites	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	0dbe8489-5261-40c7-bd31-582a963faaa9
167	craft	m200522_191453_clear_template_caches	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	6e43c737-e00d-4eb4-a98b-198cda0ae192
168	craft	m200606_231117_migration_tracks	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	cccf14d9-800c-4b07-afae-9158d9d60518
169	craft	m200619_215137_title_translation_method	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	14ff1b23-51ad-4902-a1eb-f060d5f6e61c
170	craft	m200620_005028_user_group_descriptions	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	959b3e87-8b63-4f60-ace3-9b442da13106
171	craft	m200620_230205_field_layout_changes	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	61e69b66-cde5-49ff-b682-c2fba35ac4fe
172	craft	m200625_131100_move_entrytypes_to_top_project_config	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	1b947a5c-4ac2-403f-9a25-a9a3662749fd
173	craft	m200629_112700_remove_project_config_legacy_files	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	7568ea84-a2a8-4efd-978b-a90d26407a70
174	craft	m200630_183000_drop_configmap	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	99f1be90-6f0f-4879-bb98-75695dea8ab0
175	craft	m200715_113400_transform_index_error_flag	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	3aa0cf5f-8a83-4886-9611-3fd2cb0e0be7
176	craft	m200716_110900_replace_file_asset_permissions	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	dccc0c02-5726-4a3f-ba45-30c8abcad74a
177	craft	m200716_153800_public_token_settings_in_project_config	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	8870faa7-413b-459d-9db5-eb3bdf45c4d5
178	craft	m200720_175543_drop_unique_constraints	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	7b5cafe4-bf06-4b88-b07c-8b4365812cb9
179	craft	m200825_051217_project_config_version	2020-11-25 10:32:45	2020-11-25 10:32:45	2020-11-25 10:32:45	672547b5-656f-4299-ab4f-6783e1f6861f
181	craft	m201116_190500_asset_title_translation_method	2021-01-27 15:48:33	2021-01-27 15:48:33	2021-01-27 15:48:33	fd35c589-bfc9-43a4-9b42-9ef83b072b7b
182	craft	m201124_003555_plugin_trials	2021-01-27 15:48:33	2021-01-27 15:48:33	2021-01-27 15:48:33	93a28ef6-3d10-4e05-92be-4338b33c0c31
\.


--
-- Data for Name: plugins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plugins (id, handle, version, "schemaVersion", "licenseKeyStatus", "licensedEdition", "installDate", "dateCreated", "dateUpdated", uid) FROM stdin;
1	redactor	2.8.5	2.3.0	unknown	\N	2020-11-25 10:32:43	2020-11-25 10:32:43	2021-02-01 15:24:41	43bdd22d-d288-4607-b26c-5f3881b625be
\.


--
-- Data for Name: projectconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectconfig (path, value) FROM stdin;
fieldGroups.1bc07f3f-1822-42db-aaf9-aa04909a62d1.name	"SEO"
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.contentColumnType	"text"
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.handle	"linkedin"
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.instructions	""
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.name	"Linkedin"
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.searchable	false
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.settings.byteLimit	null
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.settings.charLimit	null
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.settings.code	""
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.settings.columnType	null
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.settings.initialRows	"4"
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.settings.multiline	""
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.settings.placeholder	"https://www.linkedin.com/company/google/"
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.settings.uiMode	"normal"
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.translationKeyFormat	null
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.translationMethod	"none"
fields.41e6657f-1bf4-42fb-bd66-4aea4f6d895b.type	"craft\\\\fields\\\\PlainText"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.contentColumnType	"string"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.elements.0.warning	null
users.groups.0144de20-93d5-432d-ba93-f08f4a599148.description	""
users.groups.0144de20-93d5-432d-ba93-f08f4a599148.handle	"redactor"
users.groups.0144de20-93d5-432d-ba93-f08f4a599148.name	"Redakteure"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.elements.0.width	100
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.name	"FAQ"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.sortOrder	4
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.handle	"page"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.hasTitleField	true
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.name	"Informationsseite"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.section	"ea25caf0-a9ce-415f-91f4-7c047d9b1933"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.sortOrder	1
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.titleFormat	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.titleTranslationKeyFormat	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.titleTranslationMethod	"site"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.autocapitalize	true
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.autocomplete	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.autocorrect	true
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.class	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.disabled	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.id	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.max	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.min	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.name	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.orientation	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.placeholder	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.readonly	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.requirable	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.size	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.step	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.title	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\EntryTitleField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.0.width	100
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.1.fieldUid	"a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.1.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.1.label	null
system.edition	"pro"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.fieldGroup	"dbde185a-c4d5-4159-96a4-e75394214c6c"
users.allowPublicRegistration	true
users.defaultGroup	"b3ebc429-1aaf-4077-9b55-732d13785f99"
users.groups.b3ebc429-1aaf-4077-9b55-732d13785f99.description	"Start Benutzergruppe nach einer Registrierung"
users.groups.b3ebc429-1aaf-4077-9b55-732d13785f99.handle	"registered"
users.groups.b3ebc429-1aaf-4077-9b55-732d13785f99.name	"Registriert"
users.photoSubpath	null
users.photoVolumeUid	"24c25c8a-80ea-4d24-ad72-d168a19e07cd"
users.requireEmailVerification	true
users.suspendByDefault	false
fieldGroups.34b5cb01-0278-41cb-8ac2-1c6d931920cf.name	"Taxonomy"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.1.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.1.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.1.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.1.width	50
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.2.fieldUid	"24403202-e90c-4bf2-9f60-d8b2146f107b"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.2.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.2.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.2.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.2.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
system.live	true
fields.9e502000-1aa2-4c0c-aff6-210966db7501.handle	"downloads"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.instructions	""
fields.9e502000-1aa2-4c0c-aff6-210966db7501.name	"Downloads"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.searchable	false
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.allowSelfRelations	false
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.allowUploads	true
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.allowedKinds	null
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.defaultUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.defaultUploadLocationSubpath	""
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.limit	""
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.localizeRelations	false
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.previewMode	"full"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.restrictFiles	""
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.selectionLabel	""
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.showSiteMenu	false
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.showUnpermittedFiles	false
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.showUnpermittedVolumes	false
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.singleUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.singleUploadLocationSubpath	""
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.source	null
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.sources	"*"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.targetSiteId	null
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.useSingleFolder	false
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.validateRelatedElements	false
fields.9e502000-1aa2-4c0c-aff6-210966db7501.settings.viewMode	"list"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.translationKeyFormat	null
fields.9e502000-1aa2-4c0c-aff6-210966db7501.translationMethod	"site"
fields.9e502000-1aa2-4c0c-aff6-210966db7501.type	"craft\\\\fields\\\\Assets"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.contentColumnType	"text"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.fieldGroup	"dbde185a-c4d5-4159-96a4-e75394214c6c"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.handle	"body"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.instructions	""
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.name	"Inhalt"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.searchable	false
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.availableTransforms	"*"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.availableVolumes	"*"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.cleanupHtml	true
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.columnType	"text"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.configSelectionMode	"choose"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.defaultTransform	""
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.manualConfig	""
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.purifierConfig	""
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.purifyHtml	"1"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.redactorConfig	""
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.removeEmptyTags	"1"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.removeInlineStyles	"1"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.removeNbsp	"1"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.showHtmlButtonForNonAdmins	"1"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.2.warning	null
email.fromEmail	"emo@clubofmetalworking.de"
email.fromName	"EMO Backend"
email.replyToEmail	null
email.template	""
email.transportSettings.encryptionMethod	""
email.transportSettings.host	"125jahre-vdw.de"
email.transportSettings.password	"iHml11&0"
email.transportSettings.port	"25"
email.transportSettings.timeout	"10"
email.transportSettings.useAuthentication	"1"
email.transportSettings.username	"emo@clubofmetalworking.de"
email.transportType	"craft\\\\mail\\\\transportadapters\\\\Smtp"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.2.width	50
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.3.fieldUid	"38135310-b63d-4169-8f04-6fbbe0404998"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.3.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.3.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.3.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.3.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.3.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.3.width	100
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.4.fieldUid	"18d73ec4-3757-40a2-a96a-cdedf667d895"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.4.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.4.label	null
fieldGroups.a2bdc517-6ecc-4dfa-be02-558659dda46c.name	"Downloads & Media"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.4.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.4.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.4.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.4.width	100
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.5.type	"craft\\\\fieldlayoutelements\\\\HorizontalRule"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.6.fieldUid	"9ef612f5-8b16-401c-bd20-058431414095"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.6.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.6.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.6.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.6.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.6.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.6.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.6.width	50
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.7.fieldUid	"10d914df-e824-4c0b-97c8-84c984dd0258"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.7.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.7.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.7.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.7.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.7.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.7.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.elements.7.width	50
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.name	"Inhalt"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.0.sortOrder	1
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.showUnpermittedFiles	false
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.showUnpermittedVolumes	false
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.settings.uiMode	"enlarged"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.translationKeyFormat	null
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.translationMethod	"site"
fields.18d73ec4-3757-40a2-a96a-cdedf667d895.type	"craft\\\\redactor\\\\Field"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.0.fieldUid	"ee9512d9-701e-4e12-842e-02a6030b0da9"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.isPublic	false
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.name	"Authenticated"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.0	"sections.08161406-afd7-44e4-b188-ebaadac868c6:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.1	"entrytypes.108570f4-3617-457d-a46e-c406066c04a4:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.2	"sections.37b0574b-1b49-4f90-9362-9d503abf7eac:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.3	"entrytypes.d05ed799-bbf3-4ead-8a61-965073026ee3:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.4	"sections.8ead6ec2-98a7-4ee4-9d59-c4ac9e294118:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.5	"entrytypes.c3e9dcdd-0256-499c-bf09-b1665dea607f:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.6	"volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.7	"volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.8	"usergroups.everyone:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.9	"usergroups.0144de20-93d5-432d-ba93-f08f4a599148:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.10	"usergroups.b3ebc429-1aaf-4077-9b55-732d13785f99:read"
graphql.schemas.8fef4b60-b73e-42af-aa08-dc5646a0b808.scope.11	"taggroups.ea2dcd3b-7935-4765-9020-baa37294e9ab:read"
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.contentColumnType	"string(280)"
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.fieldGroup	"1bc07f3f-1822-42db-aaf9-aa04909a62d1"
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.handle	"meta_titel"
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.instructions	"Dieser Titel wird in den Suchmaschinen angezeigt. Empfehlenswert ist einen Mehrwert kommunizieren für einen Call-to-Action aktion."
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.name	"Meta Titel"
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.searchable	false
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.settings.byteLimit	null
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.settings.charLimit	70
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.settings.code	""
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.settings.columnType	null
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.settings.initialRows	"4"
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.settings.multiline	""
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.settings.placeholder	""
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.settings.uiMode	"normal"
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.translationKeyFormat	null
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.translationMethod	"site"
fields.ee9512d9-701e-4e12-842e-02a6030b0da9.type	"craft\\\\fields\\\\PlainText"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.0.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.0.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.0.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.0.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.0.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.0.width	100
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.1.fieldUid	"e95bbf80-2274-41dc-b724-b2a404d796de"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.1.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.1.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.1.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.1.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.1.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.elements.1.width	100
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.name	"Suchmaschine"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.1.sortOrder	2
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.0.fieldUid	"739c8fb6-1cae-4dcb-94a0-59d0cbe8f662"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.0.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.0.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.0.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.0.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.contentColumnType	"text"
fieldGroups.dbde185a-c4d5-4159-96a4-e75394214c6c.name	"Content"
sites.34380f2c-988a-43d1-9723-8633250a5237.baseUrl	"$EN_BASE_URL"
sites.34380f2c-988a-43d1-9723-8633250a5237.enabled	true
sites.34380f2c-988a-43d1-9723-8633250a5237.handle	"emoEnglish"
sites.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
sites.34380f2c-988a-43d1-9723-8633250a5237.language	"en"
sites.34380f2c-988a-43d1-9723-8633250a5237.name	"EMO English"
sites.34380f2c-988a-43d1-9723-8633250a5237.primary	false
sites.34380f2c-988a-43d1-9723-8633250a5237.siteGroup	"541d1036-b8ff-48fd-b44b-f39fd928f44e"
sites.34380f2c-988a-43d1-9723-8633250a5237.sortOrder	2
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.0.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.0.width	100
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.1.fieldUid	"9e502000-1aa2-4c0c-aff6-210966db7501"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.1.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.1.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.1.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.1.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.1.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.1.width	100
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.2.fieldUid	"d18731cd-c210-4397-bae3-3d498d1b6d8a"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.2.instructions	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.2.label	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.2.required	false
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.2.tip	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.2.warning	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.elements.2.width	100
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.name	"Medien"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.fieldLayouts.3ed9cd20-9052-4216-9f78-2d7ad05a0351.tabs.2.sortOrder	3
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.handle	"article"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.hasTitleField	true
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.name	"Artikelbeitrag"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.section	"9b5bd243-bb29-4fea-81a4-e597852129b7"
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.sortOrder	1
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.titleFormat	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.titleTranslationKeyFormat	null
entryTypes.e7599b97-ad13-4eea-bd62-3fdd165886ce.titleTranslationMethod	"site"
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.fieldGroup	"5530bc01-dbd1-4eca-8a5d-fa8906f6a042"
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.handle	"booth"
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.instructions	""
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.name	"Stand"
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.searchable	false
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.enableVersioning	true
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.handle	"articles"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.name	"Artikelbeitrag"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.previewTargets.0.__assoc__.0.0	"label"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.previewTargets.0.__assoc__.0.1	"Primäre eintrag Seite"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.previewTargets.0.__assoc__.1.0	"urlFormat"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.previewTargets.0.__assoc__.1.1	"{url}"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.previewTargets.0.__assoc__.2.0	"refresh"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.previewTargets.0.__assoc__.2.1	"1"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.propagationMethod	"all"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.enabledByDefault	true
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"a/{slug}"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.enabledByDefault	true
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"a/{slug}"
sections.9b5bd243-bb29-4fea-81a4-e597852129b7.type	"channel"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.contentColumnType	"text"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.settings.byteLimit	null
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.settings.charLimit	null
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.settings.code	""
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.settings.columnType	null
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.settings.initialRows	"4"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.contentColumnType	"text"
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.settings.multiline	""
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.settings.placeholder	"B13"
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.settings.uiMode	"normal"
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.translationKeyFormat	null
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.translationMethod	"none"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.handle	"fax"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.instructions	""
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.name	"Fax"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.searchable	false
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.settings.byteLimit	null
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.settings.charLimit	null
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.settings.code	""
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.settings.columnType	null
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.settings.initialRows	"4"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.settings.multiline	""
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.settings.placeholder	"+49 69 756081-0"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.settings.uiMode	"normal"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.translationKeyFormat	null
fields.b819a17b-d2a6-48e3-81e8-e8496f4073c2.type	"craft\\\\fields\\\\PlainText"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.translationMethod	"none"
fields.52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f.type	"craft\\\\fields\\\\PlainText"
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.contentColumnType	"text"
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.handle	"instagram"
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.instructions	""
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.name	"Instagram"
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.searchable	false
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.settings.byteLimit	null
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.settings.charLimit	null
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.settings.code	""
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.settings.columnType	null
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.settings.initialRows	"4"
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.settings.multiline	""
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.settings.placeholder	"https://www.instagram.com/rogueinvitational/"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.handle	"person_salutation"
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.isPublic	false
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.name	"DMAG"
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.scope.0	"sections.08161406-afd7-44e4-b188-ebaadac868c6:read"
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.scope.1	"entrytypes.108570f4-3617-457d-a46e-c406066c04a4:read"
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.scope.2	"sections.37b0574b-1b49-4f90-9362-9d503abf7eac:read"
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.scope.3	"entrytypes.d05ed799-bbf3-4ead-8a61-965073026ee3:read"
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.scope.4	"sections.8ead6ec2-98a7-4ee4-9d59-c4ac9e294118:read"
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.scope.5	"entrytypes.c3e9dcdd-0256-499c-bf09-b1665dea607f:read"
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.scope.6	"volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd:read"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.instructions	""
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.settings.uiMode	"normal"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.enableVersioning	false
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.translationKeyFormat	null
fieldGroups.5530bc01-dbd1-4eca-8a5d-fa8906f6a042.name	"Location"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.3.width	25
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.4.fieldUid	"b819a17b-d2a6-48e3-81e8-e8496f4073c2"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.4.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.4.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.4.required	false
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.translationMethod	"none"
fields.de7b667a-9d74-454c-bfd4-78f261a771a2.type	"craft\\\\fields\\\\PlainText"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.contentColumnType	"text"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.fieldGroup	"ca6b85ed-e3a8-4acc-953d-6400dde26c06"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.handle	"vdw_id"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.instructions	""
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.name	"VDW_ID"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.fieldGroup	"dbde185a-c4d5-4159-96a4-e75394214c6c"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.handle	"faq"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.instructions	""
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.name	"Fragen & Antworten"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.searchable	false
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.addRowLabel	"Zeile hinzufügen"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columnType	"text"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.0.0	"col1"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.0.1.__assoc__.0.0	"heading"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.0.1.__assoc__.0.1	"Frage"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.0.1.__assoc__.1.0	"handle"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.0.1.__assoc__.1.1	"question"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.0.1.__assoc__.2.0	"width"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.0.1.__assoc__.2.1	""
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.0.1.__assoc__.3.0	"type"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.0.1.__assoc__.3.1	"singleline"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.1.0	"col2"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.1.1.__assoc__.0.0	"heading"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.1.1.__assoc__.0.1	"Antwort"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.1.1.__assoc__.1.0	"handle"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.1.1.__assoc__.1.1	"answer"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.1.1.__assoc__.2.0	"width"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.1.1.__assoc__.2.1	""
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.1.1.__assoc__.3.0	"type"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.columns.__assoc__.1.1.__assoc__.3.1	"singleline"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.maxRows	""
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.settings.minRows	""
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.translationKeyFormat	null
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.translationMethod	"site"
fields.d93f6cc8-3554-4692-88db-230dc7d9bf0b.type	"craft\\\\fields\\\\Table"
system.name	"EMO Backend"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.name	"Anrede"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.enableVersioning	true
sections.06745480-8d8c-4976-934e-dc80b2ab5632.handle	"events"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.name	"Veranstaltungen"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.previewTargets.0.__assoc__.0.0	"label"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.previewTargets.0.__assoc__.0.1	"Primäre eintrag Seite"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.previewTargets.0.__assoc__.1.0	"urlFormat"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.previewTargets.0.__assoc__.1.1	"{url}"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.previewTargets.0.__assoc__.2.0	"refresh"
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.contentColumnType	"text"
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.handle	"email"
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.instructions	""
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.name	"E-Mail"
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.searchable	false
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.settings.byteLimit	null
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.settings.charLimit	null
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.settings.code	""
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.settings.columnType	null
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.settings.initialRows	"4"
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.settings.multiline	""
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.settings.placeholder	"john@doe.de"
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.settings.uiMode	"normal"
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.translationKeyFormat	null
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.translationMethod	"none"
fields.e402c4ce-9e9f-4644-8430-d6229f2d5737.type	"craft\\\\fields\\\\PlainText"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.handle	"downloads"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.name	"Downloads & Medien"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.previewTargets.0.__assoc__.0.0	"label"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.previewTargets.0.__assoc__.0.1	"Primäre eintrag Seite"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.previewTargets.0.__assoc__.1.0	"urlFormat"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.previewTargets.0.__assoc__.1.1	"{url}"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.previewTargets.0.__assoc__.2.0	"refresh"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.previewTargets.0.__assoc__.2.1	"1"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.propagationMethod	"all"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.enabledByDefault	true
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"downloads-medien/{slug}"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.previewTargets.0.__assoc__.2.1	"1"
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.contentColumnType	"datetime"
fields.5db55344-b925-4e15-b099-994baba0a7a4.translationKeyFormat	null
graphql.schemas.3250dc31-0c3c-44aa-80ce-af78d5ac2ad5.scope.7	"volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91:read"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.propagationMethod	"all"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.enabledByDefault	true
sections.06745480-8d8c-4976-934e-dc80b2ab5632.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
sections.06745480-8d8c-4976-934e-dc80b2ab5632.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
sections.06745480-8d8c-4976-934e-dc80b2ab5632.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"events/{slug}"
sections.06745480-8d8c-4976-934e-dc80b2ab5632.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.enabledByDefault	true
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.autocapitalize	true
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.autocomplete	false
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.autocorrect	true
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.class	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.disabled	false
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.id	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.instructions	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.label	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.max	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.min	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.name	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.orientation	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.placeholder	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.readonly	false
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.requirable	false
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.size	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.step	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.tip	null
sections.06745480-8d8c-4976-934e-dc80b2ab5632.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
sections.06745480-8d8c-4976-934e-dc80b2ab5632.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
sections.06745480-8d8c-4976-934e-dc80b2ab5632.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"events/{slug}"
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.contentColumnType	"datetime"
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.fieldGroup	"fb32794f-b761-46ab-b045-7c0821da0010"
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.handle	"article_date"
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.instructions	""
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.name	"Datum"
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.searchable	false
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.settings.max	null
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.settings.min	null
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.settings.minuteIncrement	"60"
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.settings.showDate	true
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.settings.showTime	true
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.translationKeyFormat	null
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.contentColumnType	"text"
sites.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.baseUrl	"$DE_BASE_URL"
sites.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.enabled	true
sites.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.handle	"emoDeutsch"
sites.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
sites.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.language	"de"
sites.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.name	"EMO Deutsch"
sites.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.primary	true
sites.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.siteGroup	"541d1036-b8ff-48fd-b44b-f39fd928f44e"
sites.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.sortOrder	1
fields.9ef612f5-8b16-401c-bd20-058431414095.contentColumnType	"string"
fields.9ef612f5-8b16-401c-bd20-058431414095.fieldGroup	"34b5cb01-0278-41cb-8ac2-1c6d931920cf"
fields.9ef612f5-8b16-401c-bd20-058431414095.handle	"categories"
fields.9ef612f5-8b16-401c-bd20-058431414095.instructions	""
fields.9ef612f5-8b16-401c-bd20-058431414095.name	"Kategorien"
fields.9ef612f5-8b16-401c-bd20-058431414095.searchable	true
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.allowLimit	false
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.allowMultipleSources	false
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.allowSelfRelations	false
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.branchLimit	""
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.limit	null
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.localizeRelations	false
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.selectionLabel	""
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.showSiteMenu	false
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.source	"group:61b9cdf6-219a-4096-b35b-538d624e1ba9"
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.sources	"*"
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.targetSiteId	null
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.validateRelatedElements	false
fields.9ef612f5-8b16-401c-bd20-058431414095.settings.viewMode	null
fields.9ef612f5-8b16-401c-bd20-058431414095.translationKeyFormat	null
fields.9ef612f5-8b16-401c-bd20-058431414095.translationMethod	"site"
fields.9ef612f5-8b16-401c-bd20-058431414095.type	"craft\\\\fields\\\\Categories"
fieldGroups.bd527d51-1e8b-439f-8d9a-e8367987817e.name	"Meta"
fields.38135310-b63d-4169-8f04-6fbbe0404998.contentColumnType	"string(1600)"
fields.38135310-b63d-4169-8f04-6fbbe0404998.fieldGroup	"bd527d51-1e8b-439f-8d9a-e8367987817e"
fields.38135310-b63d-4169-8f04-6fbbe0404998.handle	"excerpt"
fields.38135310-b63d-4169-8f04-6fbbe0404998.instructions	"Text erscheint in der Übersichtsseite"
fields.38135310-b63d-4169-8f04-6fbbe0404998.name	"Teasertext"
fields.38135310-b63d-4169-8f04-6fbbe0404998.searchable	false
fields.38135310-b63d-4169-8f04-6fbbe0404998.settings.byteLimit	null
fields.38135310-b63d-4169-8f04-6fbbe0404998.settings.charLimit	400
fields.38135310-b63d-4169-8f04-6fbbe0404998.settings.code	""
fields.38135310-b63d-4169-8f04-6fbbe0404998.settings.columnType	null
fields.38135310-b63d-4169-8f04-6fbbe0404998.settings.initialRows	"4"
fields.38135310-b63d-4169-8f04-6fbbe0404998.settings.multiline	"1"
fields.38135310-b63d-4169-8f04-6fbbe0404998.settings.placeholder	""
fields.38135310-b63d-4169-8f04-6fbbe0404998.settings.uiMode	"normal"
fields.38135310-b63d-4169-8f04-6fbbe0404998.translationKeyFormat	null
fields.38135310-b63d-4169-8f04-6fbbe0404998.translationMethod	"none"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.searchable	false
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.0.__assoc__.0.0	"label"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.0.__assoc__.0.1	"Herr"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.0.__assoc__.1.0	"value"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.0.__assoc__.1.1	"mr"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.0.__assoc__.2.0	"default"
fields.38135310-b63d-4169-8f04-6fbbe0404998.type	"craft\\\\fields\\\\PlainText"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.enableVersioning	true
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.handle	"pages"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.name	"Informationsseite"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.previewTargets.0.__assoc__.0.0	"label"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.previewTargets.0.__assoc__.0.1	"Primäre eintrag Seite"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.previewTargets.0.__assoc__.1.0	"urlFormat"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.previewTargets.0.__assoc__.1.1	"/p/preview/{slug}"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.previewTargets.0.__assoc__.2.0	"refresh"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.previewTargets.0.__assoc__.2.1	"1"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.propagationMethod	"none"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.enabledByDefault	true
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"p/{slug}"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.enabledByDefault	true
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"p/{slug}"
sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933.type	"channel"
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.handle	"youtube"
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.instructions	""
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.name	"Youtube"
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.searchable	false
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.settings.byteLimit	null
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.settings.charLimit	null
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.settings.code	""
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.settings.columnType	null
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.settings.initialRows	"4"
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.settings.multiline	""
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.settings.placeholder	"https://www.youtube.com/user/Siemens"
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.settings.uiMode	"normal"
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.translationKeyFormat	null
fieldGroups.46e7d308-41fb-4441-87ee-70fa77295bf7.name	"Person"
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.translationMethod	"none"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.autocapitalize	true
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.autocomplete	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.autocorrect	true
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.class	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.disabled	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.id	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.max	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.min	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.name	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.orientation	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.placeholder	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.readonly	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.requirable	false
fields.dced25a8-d4dc-49a1-a4d9-4d7edea2959c.type	"craft\\\\fields\\\\PlainText"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.searchable	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.size	null
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.contentColumnType	"text"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.step	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.title	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\EntryTitleField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.0.width	100
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.1.fieldUid	"a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.1.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.1.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.1.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.1.tip	null
fields.5791152b-3883-4751-9803-a1efd9730f3d.contentColumnType	"string"
system.retryDuration	30
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.handle	"phone"
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.instructions	""
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.name	"Telefon"
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.searchable	false
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.settings.byteLimit	null
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.settings.charLimit	null
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.settings.code	""
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.settings.columnType	null
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.settings.initialRows	"4"
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.settings.multiline	""
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.settings.placeholder	"+49 69 756081-0"
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.settings.uiMode	"normal"
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.translationKeyFormat	null
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.translationMethod	"none"
fields.39780143-51f5-4ce9-b1cf-0a9df42c8055.type	"craft\\\\fields\\\\PlainText"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.settings.byteLimit	null
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.contentColumnType	"string"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.fieldGroup	"bd527d51-1e8b-439f-8d9a-e8367987817e"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.handle	"thumbimage"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.instructions	""
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.name	"Titelbild"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.searchable	false
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.allowSelfRelations	false
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.allowUploads	true
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.contentColumnType	"text"
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.autocapitalize	true
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.autocomplete	false
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.autocorrect	true
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.class	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.disabled	false
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.id	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.instructions	""
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.label	""
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.max	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.min	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.name	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.orientation	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.placeholder	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.readonly	false
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.requirable	false
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.size	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.step	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.tip	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.title	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\TitleField"
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.warning	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.elements.0.width	100
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.name	"Inhalt"
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.fieldLayouts.655007d3-8586-4e80-96c0-e0c2e201b343.tabs.0.sortOrder	1
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.handle	"categories"
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.name	"Kategorie"
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"kategorie/{slug}"
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"kategorie/{slug}"
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.structure.maxLevels	2
categoryGroups.61b9cdf6-219a-4096-b35b-538d624e1ba9.structure.uid	"cee94a14-2190-4dc1-a129-1ccafd44ed14"
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.handle	"industryarena"
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.instructions	""
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.name	"IndustryArena"
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.searchable	false
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.settings.byteLimit	null
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.settings.charLimit	null
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.settings.code	""
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.settings.columnType	null
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.settings.initialRows	"4"
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.settings.multiline	""
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.settings.placeholder	"https://industryarena.com/umati"
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.settings.uiMode	"normal"
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.translationKeyFormat	null
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.translationMethod	"none"
fields.2b41ab49-178c-4ff2-b65d-fbbe2e33c562.type	"craft\\\\fields\\\\PlainText"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.settings.charLimit	null
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.settings.code	""
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.allowedKinds	null
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.defaultUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.defaultUploadLocationSubpath	""
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.limit	"1"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.localizeRelations	false
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.previewMode	"full"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.restrictFiles	""
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.selectionLabel	""
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.settings.columnType	null
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.settings.initialRows	"4"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.settings.multiline	""
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.settings.placeholder	""
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.settings.uiMode	"normal"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.translationKeyFormat	null
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.translationMethod	"none"
fields.d619fc81-496a-4a1b-8f02-4a71c453f5d2.type	"craft\\\\fields\\\\PlainText"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.9.fieldUid	"8d3d3523-0a94-44fa-be0d-11ecb92bdc20"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.9.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.9.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.9.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.9.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.9.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.9.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.9.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.10.fieldUid	"5db55344-b925-4e15-b099-994baba0a7a4"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.10.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.10.label	null
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.showSiteMenu	true
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.showUnpermittedFiles	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.10.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.10.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.10.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.10.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.10.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.11.heading	"Kontakt"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.11.type	"craft\\\\fieldlayoutelements\\\\Heading"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.12.fieldUid	"e402c4ce-9e9f-4644-8430-d6229f2d5737"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.12.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.12.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.12.required	false
sections.06745480-8d8c-4976-934e-dc80b2ab5632.type	"channel"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.12.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.12.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.12.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.12.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.13.fieldUid	"39780143-51f5-4ce9-b1cf-0a9df42c8055"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.13.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.13.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.13.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.13.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.13.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.13.warning	null
system.schemaVersion	"3.6.1"
system.timeZone	"UTC"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.showUnpermittedVolumes	false
fields.10d914df-e824-4c0b-97c8-84c984dd0258.contentColumnType	"string"
fields.10d914df-e824-4c0b-97c8-84c984dd0258.fieldGroup	"34b5cb01-0278-41cb-8ac2-1c6d931920cf"
fields.10d914df-e824-4c0b-97c8-84c984dd0258.handle	"tags"
fields.10d914df-e824-4c0b-97c8-84c984dd0258.instructions	""
fields.10d914df-e824-4c0b-97c8-84c984dd0258.name	"Tags"
fields.10d914df-e824-4c0b-97c8-84c984dd0258.searchable	true
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.allowLimit	false
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.allowMultipleSources	false
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.allowSelfRelations	false
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.branchLimit	""
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.limit	null
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.localizeRelations	false
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.selectionLabel	""
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.showSiteMenu	false
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.source	"group:68aee50b-ea3a-4325-aed3-211fef3f4db3"
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.sources	"*"
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.targetSiteId	null
fields.a6d20208-15f2-493d-8a54-0adae2193700.contentColumnType	"text"
fields.a6d20208-15f2-493d-8a54-0adae2193700.fieldGroup	"ca6b85ed-e3a8-4acc-953d-6400dde26c06"
fields.a6d20208-15f2-493d-8a54-0adae2193700.handle	"vdw_auftrag"
fields.a6d20208-15f2-493d-8a54-0adae2193700.instructions	""
fields.a6d20208-15f2-493d-8a54-0adae2193700.name	"VDW_AUFTRAG"
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.contentColumnType	"string"
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.fieldGroup	"1409bb4a-dc75-44ba-99c9-5234616c4ab7"
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.handle	"persons"
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.instructions	""
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.name	"Personen"
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.searchable	false
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.allowSelfRelations	false
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.limit	""
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.localizeRelations	false
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.selectionLabel	""
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.showSiteMenu	false
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.source	null
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.sources.0	"section:0daaa545-d1a0-4655-a507-2bac8b560f1d"
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.targetSiteId	null
fields.a6d20208-15f2-493d-8a54-0adae2193700.searchable	false
fields.a6d20208-15f2-493d-8a54-0adae2193700.settings.byteLimit	null
fields.a6d20208-15f2-493d-8a54-0adae2193700.settings.charLimit	null
fields.a6d20208-15f2-493d-8a54-0adae2193700.settings.code	""
fields.a6d20208-15f2-493d-8a54-0adae2193700.settings.columnType	null
fields.a6d20208-15f2-493d-8a54-0adae2193700.settings.initialRows	"4"
fields.a6d20208-15f2-493d-8a54-0adae2193700.settings.multiline	""
fields.a6d20208-15f2-493d-8a54-0adae2193700.settings.placeholder	""
fields.a6d20208-15f2-493d-8a54-0adae2193700.settings.uiMode	"normal"
fields.a6d20208-15f2-493d-8a54-0adae2193700.translationKeyFormat	null
fields.a6d20208-15f2-493d-8a54-0adae2193700.translationMethod	"none"
fields.a6d20208-15f2-493d-8a54-0adae2193700.type	"craft\\\\fields\\\\PlainText"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.13.width	50
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.validateRelatedElements	false
fields.10d914df-e824-4c0b-97c8-84c984dd0258.settings.viewMode	null
fields.10d914df-e824-4c0b-97c8-84c984dd0258.translationKeyFormat	null
fields.10d914df-e824-4c0b-97c8-84c984dd0258.translationMethod	"site"
fields.10d914df-e824-4c0b-97c8-84c984dd0258.type	"craft\\\\fields\\\\Categories"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.14.fieldUid	"c85c285d-0701-44db-b2a7-306dd269680c"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.14.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.14.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.14.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.14.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.14.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.14.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.14.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.15.fieldUid	"52b46a5b-3bc7-4eb4-a2c5-4372222a1c9f"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.15.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.15.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.15.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.15.tip	null
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.enabledByDefault	true
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.autocapitalize	true
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.autocomplete	false
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.autocorrect	true
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.class	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.disabled	false
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.id	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.instructions	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.label	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.max	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.min	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.name	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.orientation	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.placeholder	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.readonly	false
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.requirable	false
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.size	null
fields.68317155-d437-4b8a-a640-382a9092e553.contentColumnType	"smallint(4)"
fields.68317155-d437-4b8a-a640-382a9092e553.fieldGroup	"ca6b85ed-e3a8-4acc-953d-6400dde26c06"
fields.68317155-d437-4b8a-a640-382a9092e553.handle	"event_year"
fields.68317155-d437-4b8a-a640-382a9092e553.instructions	""
fields.68317155-d437-4b8a-a640-382a9092e553.name	"Veranstaltungsjahr"
fields.68317155-d437-4b8a-a640-382a9092e553.searchable	false
fields.68317155-d437-4b8a-a640-382a9092e553.settings.decimals	0
fields.68317155-d437-4b8a-a640-382a9092e553.settings.defaultValue	"2019"
fields.68317155-d437-4b8a-a640-382a9092e553.settings.max	"2060"
fields.68317155-d437-4b8a-a640-382a9092e553.settings.min	"2018"
fields.68317155-d437-4b8a-a640-382a9092e553.settings.prefix	""
fields.68317155-d437-4b8a-a640-382a9092e553.settings.previewCurrency	""
fields.68317155-d437-4b8a-a640-382a9092e553.settings.previewFormat	"decimal"
fields.68317155-d437-4b8a-a640-382a9092e553.settings.size	null
fields.68317155-d437-4b8a-a640-382a9092e553.settings.suffix	""
fields.68317155-d437-4b8a-a640-382a9092e553.translationKeyFormat	null
fields.68317155-d437-4b8a-a640-382a9092e553.translationMethod	"none"
fields.68317155-d437-4b8a-a640-382a9092e553.type	"craft\\\\fields\\\\Number"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.15.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.15.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.15.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.name	"Firma"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.enableVersioning	true
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.handle	"persons"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.name	"Personen"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.previewTargets.0.__assoc__.0.0	"label"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.previewTargets.0.__assoc__.0.1	"Primäre eintrag Seite"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.previewTargets.0.__assoc__.1.0	"urlFormat"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.previewTargets.0.__assoc__.1.1	"{url}"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.previewTargets.0.__assoc__.2.0	"refresh"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.previewTargets.0.__assoc__.2.1	"1"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.propagationMethod	"all"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.enabledByDefault	true
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"personen/{slug}"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.enabledByDefault	true
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"personen/{slug}"
sections.0daaa545-d1a0-4655-a507-2bac8b560f1d.type	"channel"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.sortOrder	2
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.0.fieldUid	"d619fc81-496a-4a1b-8f02-4a71c453f5d2"
graphql.publicToken.enabled	true
graphql.publicToken.expiryDate	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.step	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.tip	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.title	null
fields.e95bbf80-2274-41dc-b724-b2a404d796de.contentColumnType	"string(640)"
fields.e95bbf80-2274-41dc-b724-b2a404d796de.fieldGroup	"1bc07f3f-1822-42db-aaf9-aa04909a62d1"
fields.e95bbf80-2274-41dc-b724-b2a404d796de.handle	"meta_description"
fields.e95bbf80-2274-41dc-b724-b2a404d796de.instructions	"Kurze Zusammenfassung des Inhalts, die in den Suchergebnissen von Suchmaschinen angezeigt wird. Die Beschreibung soll Besucher/innen zu verstehen zu geben, was sich hinter dem Ergebnis verbirgt."
plugins.redactor.edition	"standard"
plugins.redactor.enabled	true
plugins.redactor.schemaVersion	"2.3.0"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.0.__assoc__.2.1	"1"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.1.__assoc__.0.0	"label"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.1.__assoc__.0.1	"Frau"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.1.__assoc__.1.0	"value"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.1.__assoc__.1.1	"mrs"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.1.__assoc__.2.0	"default"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.settings.options.1.__assoc__.2.1	""
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.translationKeyFormat	null
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.translationMethod	"none"
fields.5db55344-b925-4e15-b099-994baba0a7a4.translationMethod	"none"
fields.5db55344-b925-4e15-b099-994baba0a7a4.type	"craft\\\\fields\\\\PlainText"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.type	"craft\\\\fields\\\\RadioButtons"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.9.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.10.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.10.__assoc__.0.1	"Andere berufliche Stellung"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.10.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.10.__assoc__.1.1	"andereBeruflicheStellung"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.10.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.10.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.11.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.11.__assoc__.0.1	"Schüler"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.11.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.11.__assoc__.1.1	"schueler"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.11.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.11.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.12.__assoc__.0.0	"label"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.contentColumnType	"text"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.handle	"twitter"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.instructions	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.12.__assoc__.0.1	"Student"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.12.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.12.__assoc__.1.1	"student"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.12.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.12.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.13.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.13.__assoc__.0.1	"Nicht berufstätig"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.13.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.13.__assoc__.1.1	"nichtBerufstaetig"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.13.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.13.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.translationKeyFormat	null
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.translationMethod	"none"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.type	"craft\\\\fields\\\\Dropdown"
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.fieldGroup	"46e7d308-41fb-4441-87ee-70fa77295bf7"
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.handle	"person_email"
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.instructions	""
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.name	"E-Mail"
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.searchable	false
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.settings.byteLimit	null
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.settings.charLimit	null
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.settings.code	""
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.settings.columnType	null
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.settings.initialRows	"4"
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.settings.multiline	""
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.settings.placeholder	""
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.settings.uiMode	"normal"
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.translationKeyFormat	null
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.translationMethod	"none"
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.type	"craft\\\\fields\\\\PlainText"
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.contentColumnType	"text"
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.fieldGroup	"46e7d308-41fb-4441-87ee-70fa77295bf7"
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.handle	"person_lastname"
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.instructions	""
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.name	"Nachname"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.1.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.1.width	50
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.enableVersioning	false
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.handle	"exhibitors"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.name	"Aussteller"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.previewTargets.0.__assoc__.0.0	"label"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.previewTargets.0.__assoc__.0.1	"Primäre eintrag Seite"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.previewTargets.0.__assoc__.1.0	"urlFormat"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.previewTargets.0.__assoc__.1.1	"{url}"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.previewTargets.0.__assoc__.2.0	"refresh"
fields.6b846f7f-9152-4526-813f-a931a421c454.contentColumnType	"text"
fields.6b846f7f-9152-4526-813f-a931a421c454.fieldGroup	"46e7d308-41fb-4441-87ee-70fa77295bf7"
fields.6b846f7f-9152-4526-813f-a931a421c454.handle	"person_title"
fields.6b846f7f-9152-4526-813f-a931a421c454.instructions	""
fields.6b846f7f-9152-4526-813f-a931a421c454.name	"Titel"
fields.6b846f7f-9152-4526-813f-a931a421c454.searchable	false
fields.6b846f7f-9152-4526-813f-a931a421c454.settings.byteLimit	null
fields.6b846f7f-9152-4526-813f-a931a421c454.settings.charLimit	null
fields.6b846f7f-9152-4526-813f-a931a421c454.settings.code	""
fields.6b846f7f-9152-4526-813f-a931a421c454.settings.columnType	null
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.previewTargets.0.__assoc__.2.1	"1"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.propagationMethod	"all"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.enabledByDefault	true
fields.6b846f7f-9152-4526-813f-a931a421c454.settings.initialRows	"4"
fields.6b846f7f-9152-4526-813f-a931a421c454.settings.multiline	""
fields.6b846f7f-9152-4526-813f-a931a421c454.settings.placeholder	""
fields.6b846f7f-9152-4526-813f-a931a421c454.settings.uiMode	"normal"
fields.6b846f7f-9152-4526-813f-a931a421c454.translationKeyFormat	null
fields.6b846f7f-9152-4526-813f-a931a421c454.translationMethod	"none"
fields.6b846f7f-9152-4526-813f-a931a421c454.type	"craft\\\\fields\\\\PlainText"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.name	"Twitter"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.searchable	false
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.settings.byteLimit	null
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.settings.charLimit	null
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.settings.code	""
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.settings.columnType	null
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.settings.initialRows	"4"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.settings.multiline	""
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.settings.placeholder	"https://twitter.com/bremen_de"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.settings.uiMode	"normal"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.translationKeyFormat	null
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.translationMethod	"none"
fields.e61e3323-bb6b-466f-9f03-1a5c39d1605b.type	"craft\\\\fields\\\\PlainText"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"exhibitors/{slug}"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.enabledByDefault	true
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"aussteller/{slug}"
sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d.type	"channel"
fields.5db55344-b925-4e15-b099-994baba0a7a4.contentColumnType	"string(8)"
fields.5db55344-b925-4e15-b099-994baba0a7a4.fieldGroup	"1d55be6c-f0ae-45f5-91a7-6a4a464d109e"
fields.5db55344-b925-4e15-b099-994baba0a7a4.handle	"address_country"
fields.5db55344-b925-4e15-b099-994baba0a7a4.instructions	"Kurzwahl nutzen, siehe https://de.wikipedia.org/wiki/ISO-3166-1-Kodierliste (Bsp. AT = Österreich, Vereinigte Staaten = US)"
fields.5db55344-b925-4e15-b099-994baba0a7a4.name	"Land"
fields.5db55344-b925-4e15-b099-994baba0a7a4.searchable	false
fields.5db55344-b925-4e15-b099-994baba0a7a4.settings.byteLimit	null
fields.5db55344-b925-4e15-b099-994baba0a7a4.settings.charLimit	2
fields.5db55344-b925-4e15-b099-994baba0a7a4.settings.code	""
fields.5db55344-b925-4e15-b099-994baba0a7a4.settings.columnType	null
fields.5db55344-b925-4e15-b099-994baba0a7a4.settings.initialRows	"4"
fields.5db55344-b925-4e15-b099-994baba0a7a4.settings.multiline	""
fields.5db55344-b925-4e15-b099-994baba0a7a4.settings.placeholder	""
fields.5db55344-b925-4e15-b099-994baba0a7a4.settings.uiMode	"normal"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.2.fieldUid	"24403202-e90c-4bf2-9f60-d8b2146f107b"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.autocapitalize	true
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.autocomplete	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.autocorrect	true
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.class	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.disabled	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.id	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.max	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.min	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.name	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.orientation	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.placeholder	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.readonly	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.requirable	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.size	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.step	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.title	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\EntryTitleField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.0.width	50
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.1.fieldUid	"6b846f7f-9152-4526-813f-a931a421c454"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.1.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.1.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.2.instructions	null
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.contentColumnType	"text"
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.2.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.2.required	false
fields.e95bbf80-2274-41dc-b724-b2a404d796de.name	"Meta Description"
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.contentColumnType	"text"
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.fieldGroup	"dbde185a-c4d5-4159-96a4-e75394214c6c"
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.handle	"videohtml"
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.instructions	""
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.name	"Videoeinbettung"
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.searchable	false
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.settings.byteLimit	null
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.settings.charLimit	null
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.settings.code	""
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.settings.columnType	null
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.settings.initialRows	"4"
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.settings.multiline	"1"
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.settings.placeholder	""
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.settings.uiMode	"enlarged"
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.handle	"xing"
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.instructions	""
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.name	"Xing"
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.searchable	false
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.settings.byteLimit	null
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.settings.charLimit	null
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.settings.code	""
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.settings.columnType	null
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.settings.initialRows	"4"
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.settings.multiline	""
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.settings.placeholder	"https://www.xing.com/profile/Ugur_Sahin53"
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.settings.uiMode	"normal"
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.translationKeyFormat	null
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.translationMethod	"none"
fields.f226fb33-c938-4e3d-9c88-8d5678ddb8ea.type	"craft\\\\fields\\\\PlainText"
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.translationKeyFormat	null
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.translationMethod	"site"
fields.d18731cd-c210-4397-bae3-3d498d1b6d8a.type	"craft\\\\fields\\\\PlainText"
fields.e95bbf80-2274-41dc-b724-b2a404d796de.searchable	false
fields.e95bbf80-2274-41dc-b724-b2a404d796de.settings.byteLimit	null
fields.e95bbf80-2274-41dc-b724-b2a404d796de.settings.charLimit	160
fields.e95bbf80-2274-41dc-b724-b2a404d796de.settings.code	""
fields.e95bbf80-2274-41dc-b724-b2a404d796de.settings.columnType	null
fields.e95bbf80-2274-41dc-b724-b2a404d796de.settings.initialRows	"4"
fields.e95bbf80-2274-41dc-b724-b2a404d796de.settings.multiline	"1"
fields.e95bbf80-2274-41dc-b724-b2a404d796de.settings.placeholder	""
fields.e95bbf80-2274-41dc-b724-b2a404d796de.settings.uiMode	"normal"
fields.e95bbf80-2274-41dc-b724-b2a404d796de.translationKeyFormat	null
fields.e95bbf80-2274-41dc-b724-b2a404d796de.translationMethod	"site"
fields.e95bbf80-2274-41dc-b724-b2a404d796de.type	"craft\\\\fields\\\\PlainText"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.singleUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.singleUploadLocationSubpath	""
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.source	null
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.sources	"*"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.targetSiteId	null
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.useSingleFolder	false
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.validateRelatedElements	false
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.settings.viewMode	"list"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.translationKeyFormat	null
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.translationMethod	"site"
fields.24403202-e90c-4bf2-9f60-d8b2146f107b.type	"craft\\\\fields\\\\Assets"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.2.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.2.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.2.width	50
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.3.fieldUid	"38135310-b63d-4169-8f04-6fbbe0404998"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.3.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.3.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.3.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.3.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.3.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.3.width	100
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.4.fieldUid	"18d73ec4-3757-40a2-a96a-cdedf667d895"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.4.instructions	""
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.4.label	"Inhalt"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.4.required	"1"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.4.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.4.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.4.width	100
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.validateRelatedElements	false
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.settings.viewMode	null
fields.9289a943-5ab0-45f8-9b78-876519730902.contentColumnType	"text"
fields.9289a943-5ab0-45f8-9b78-876519730902.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.9289a943-5ab0-45f8-9b78-876519730902.handle	"facebook"
fields.9289a943-5ab0-45f8-9b78-876519730902.instructions	""
fields.9289a943-5ab0-45f8-9b78-876519730902.name	"Facebook"
fields.9289a943-5ab0-45f8-9b78-876519730902.searchable	false
fields.9289a943-5ab0-45f8-9b78-876519730902.settings.byteLimit	null
fields.9289a943-5ab0-45f8-9b78-876519730902.settings.charLimit	null
fields.9289a943-5ab0-45f8-9b78-876519730902.settings.code	""
fields.9289a943-5ab0-45f8-9b78-876519730902.settings.columnType	null
fields.9289a943-5ab0-45f8-9b78-876519730902.settings.initialRows	"4"
fields.9289a943-5ab0-45f8-9b78-876519730902.settings.multiline	""
fields.9289a943-5ab0-45f8-9b78-876519730902.settings.placeholder	"https://www.facebook.com/IndustryArena"
fields.9289a943-5ab0-45f8-9b78-876519730902.settings.uiMode	"normal"
fields.9289a943-5ab0-45f8-9b78-876519730902.translationKeyFormat	null
fields.9289a943-5ab0-45f8-9b78-876519730902.translationMethod	"none"
fields.9289a943-5ab0-45f8-9b78-876519730902.type	"craft\\\\fields\\\\PlainText"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.1.required	false
fieldGroups.e0052448-4c56-4da7-a2b5-d0739570cba1.name	"Contact"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.1.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.1.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.1.width	50
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.2.fieldUid	"b615217c-6a31-4d72-bc36-48a81c88be5d"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.2.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.2.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.2.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.2.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.2.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.2.width	50
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.3.fieldUid	"f88bfc01-1476-4bd4-9a6a-b65fff783658"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.3.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.3.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.3.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.3.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.3.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.3.width	50
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.4.fieldUid	"0157ca30-ec6c-42c5-8869-589c4bf6965f"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.4.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.4.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.4.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.4.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.5.type	"craft\\\\fieldlayoutelements\\\\HorizontalRule"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.6.fieldUid	"9ef612f5-8b16-401c-bd20-058431414095"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.6.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.6.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.6.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.6.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.6.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.6.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.6.width	50
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.7.fieldUid	"10d914df-e824-4c0b-97c8-84c984dd0258"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.7.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.7.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.7.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.7.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.7.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.7.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.elements.7.width	50
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.4.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.4.width	50
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.name	"Inhalt"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.5.type	"craft\\\\fieldlayoutelements\\\\HorizontalRule"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.6.fieldUid	"92b7aba3-37db-44f6-bfb9-b7b63fb33ce9"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.6.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.6.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.6.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.6.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.6.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.6.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.elements.6.width	50
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.name	"Inhalt"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.0.sortOrder	1
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.0.fieldUid	"e402c4ce-9e9f-4644-8430-d6229f2d5737"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.0.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.0.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.0.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.0.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.0.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.0.width	50
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.1.fieldUid	"39780143-51f5-4ce9-b1cf-0a9df42c8055"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.1.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.1.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.1.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.1.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.1.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.1.width	50
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.2.type	"craft\\\\fieldlayoutelements\\\\HorizontalRule"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.3.fieldUid	"9289a943-5ab0-45f8-9b78-876519730902"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.3.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.3.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.3.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.3.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.3.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.3.width	25
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.4.fieldUid	"41e6657f-1bf4-42fb-bd66-4aea4f6d895b"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.4.instructions	null
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.translationKeyFormat	null
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.contentColumnType	"string"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.fieldGroup	"dbde185a-c4d5-4159-96a4-e75394214c6c"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.handle	"images"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.instructions	""
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.name	"Gallerie"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.searchable	false
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.allowSelfRelations	false
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.allowUploads	true
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.allowedKinds	null
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.defaultUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.defaultUploadLocationSubpath	""
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\TitleField"
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.warning	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.elements.0.width	100
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.name	"Inhalt"
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.fieldLayouts.a65f7e44-24f6-4456-92b9-32d7ea6766e1.tabs.0.sortOrder	1
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.handle	"tags"
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.name	"Tags"
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"tags/{slug}"
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"tags/{slug}"
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.structure.maxLevels	1
categoryGroups.68aee50b-ea3a-4325-aed3-211fef3f4db3.structure.uid	"8a65445b-9e49-450e-a60e-190e1b0b5de8"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.contentColumnType	"string"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.fieldGroup	"a2bdc517-6ecc-4dfa-be02-558659dda46c"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.handle	"file"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.instructions	""
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.name	"Datei"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.searchable	false
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.allowSelfRelations	false
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.allowUploads	true
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.allowedKinds	null
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.defaultUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.defaultUploadLocationSubpath	""
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.limit	""
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.localizeRelations	false
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.previewMode	"full"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.restrictFiles	""
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.selectionLabel	""
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.showSiteMenu	false
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.showUnpermittedFiles	false
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.showUnpermittedVolumes	false
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.singleUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.singleUploadLocationSubpath	""
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.source	null
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.sources	"*"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.targetSiteId	null
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.useSingleFolder	false
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.validateRelatedElements	false
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.settings.viewMode	"list"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.translationKeyFormat	null
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.translationMethod	"site"
fields.51fb8b04-05e1-4476-a9f5-008860e78c6b.type	"craft\\\\fields\\\\Assets"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"downloads-medien/{slug}"
sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c.type	"channel"
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.contentColumnType	"string"
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.searchable	false
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.limit	""
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.localizeRelations	false
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.previewMode	"full"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.restrictFiles	""
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.selectionLabel	""
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.showSiteMenu	false
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.showUnpermittedFiles	false
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.showUnpermittedVolumes	false
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.singleUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.singleUploadLocationSubpath	""
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.source	null
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.sources	"*"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.targetSiteId	null
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.useSingleFolder	false
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.validateRelatedElements	false
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.settings.viewMode	"list"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.translationKeyFormat	null
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.translationMethod	"site"
fields.739c8fb6-1cae-4dcb-94a0-59d0cbe8f662.type	"craft\\\\fields\\\\Assets"
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.fieldGroup	"bd527d51-1e8b-439f-8d9a-e8367987817e"
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.handle	"author"
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.instructions	""
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.name	"Author"
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.searchable	false
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.allowSelfRelations	false
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.limit	"1"
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.localizeRelations	false
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.selectionLabel	""
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.showSiteMenu	true
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.source	null
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.sources.0	"section:8ead6ec2-98a7-4ee4-9d59-c4ac9e294118"
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.targetSiteId	null
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.validateRelatedElements	false
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.settings.viewMode	null
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.translationKeyFormat	null
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.translationMethod	"site"
fields.a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65.type	"craft\\\\fields\\\\Entries"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.4.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.0.sortOrder	1
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.0.fieldUid	"ee9512d9-701e-4e12-842e-02a6030b0da9"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.0.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.0.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.0.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.0.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.0.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.0.width	100
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.1.fieldUid	"e95bbf80-2274-41dc-b724-b2a404d796de"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.4.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.4.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.4.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.4.width	25
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.5.fieldUid	"e61e3323-bb6b-466f-9f03-1a5c39d1605b"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.5.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.5.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.5.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.5.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.5.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.5.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.5.width	25
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.6.fieldUid	"f226fb33-c938-4e3d-9c88-8d5678ddb8ea"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.6.instructions	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.6.label	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.6.required	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.6.tip	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.6.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.6.warning	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.elements.6.width	25
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.name	"Kontakt"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.fieldLayouts.bc02eba3-888e-4833-9396-af64dae92bee.tabs.1.sortOrder	2
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.handle	"persons"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.hasTitleField	false
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.name	"Personen"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.section	"0daaa545-d1a0-4655-a507-2bac8b560f1d"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.sortOrder	1
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.title	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\EntryTitleField"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.warning	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.0.width	100
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.1.fieldUid	"51fb8b04-05e1-4476-a9f5-008860e78c6b"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.1.instructions	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.1.label	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.1.required	false
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.1.tip	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.1.warning	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.1.width	100
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\HorizontalRule"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.3.fieldUid	"9ef612f5-8b16-401c-bd20-058431414095"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.3.instructions	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.3.label	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.3.required	false
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.3.tip	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.3.warning	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.3.width	50
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.4.fieldUid	"10d914df-e824-4c0b-97c8-84c984dd0258"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.4.instructions	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.4.label	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.4.required	false
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.4.tip	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.4.warning	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.elements.4.width	50
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.name	"Inhalt"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.0.sortOrder	1
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.0.fieldUid	"ee9512d9-701e-4e12-842e-02a6030b0da9"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.0.instructions	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.0.label	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.0.required	false
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.0.tip	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.0.warning	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.0.width	100
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.1.fieldUid	"e95bbf80-2274-41dc-b724-b2a404d796de"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.1.instructions	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.1.label	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.1.required	false
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.1.tip	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.1.warning	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.elements.1.width	100
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.name	"Suchmaschine"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.fieldLayouts.0218e180-021b-4456-a518-adda18fa6acb.tabs.1.sortOrder	2
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.handle	"downloads"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.hasTitleField	true
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.name	"Downloads & Medien"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.section	"f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c"
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.sortOrder	1
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.titleFormat	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.titleTranslationKeyFormat	null
entryTypes.4926019f-9936-4a51-a84f-38d927e89c25.titleTranslationMethod	"site"
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.titleFormat	"{title}_{salutation}_{firstname}_{lastname}"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.1.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.1.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.1.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.1.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.1.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.elements.1.width	100
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.name	"Suchmaschinen"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.1.sortOrder	2
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.0.fieldUid	"739c8fb6-1cae-4dcb-94a0-59d0cbe8f662"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.0.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.0.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.0.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.0.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.0.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.0.width	100
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.titleTranslationKeyFormat	null
entryTypes.f2313657-ca71-492d-9931-0f1a1c49cdce.titleTranslationMethod	"none"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.1.fieldUid	"9e502000-1aa2-4c0c-aff6-210966db7501"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.1.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.1.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.1.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.1.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.1.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.1.width	100
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.2.fieldUid	"d18731cd-c210-4397-bae3-3d498d1b6d8a"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.2.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.2.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.2.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.2.tip	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.2.warning	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.elements.2.width	100
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.name	"Medien"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.2.sortOrder	3
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.elements.0.fieldUid	"d93f6cc8-3554-4692-88db-230dc7d9bf0b"
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.elements.0.instructions	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.elements.0.label	null
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.elements.0.required	false
entryTypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e.fieldLayouts.c2bfcb97-5a33-4391-aef6-f939514b2fdf.tabs.3.elements.0.tip	null
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.translationMethod	"site"
fields.dd5974d9-ec7e-426b-aba0-2a01563861f4.type	"craft\\\\fields\\\\Entries"
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.fieldGroup	"1409bb4a-dc75-44ba-99c9-5234616c4ab7"
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.handle	"event_date"
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.instructions	""
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.name	"Datum"
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.searchable	false
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.settings.max	null
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.settings.min	null
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.settings.minuteIncrement	"60"
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.settings.showDate	true
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.settings.showTime	true
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.translationKeyFormat	null
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.translationMethod	"none"
fields.0fe7b7e2-1d66-4533-b80c-3e1b63fce160.type	"craft\\\\fields\\\\Date"
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.translationMethod	"none"
fields.b29474fd-4aaa-4f11-9f8f-eae1269ca9e0.type	"craft\\\\fields\\\\Date"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.4.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.4.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.4.width	25
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.5.fieldUid	"38135310-b63d-4169-8f04-6fbbe0404998"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.5.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.5.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.5.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.5.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.5.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.5.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.5.width	100
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.6.fieldUid	"18d73ec4-3757-40a2-a96a-cdedf667d895"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.6.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.6.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.6.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.6.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.6.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.6.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.6.width	100
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.7.type	"craft\\\\fieldlayoutelements\\\\HorizontalRule"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.8.fieldUid	"9ef612f5-8b16-401c-bd20-058431414095"
fieldGroups.fb32794f-b761-46ab-b045-7c0821da0010.name	"Article"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.autocapitalize	true
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.autocomplete	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.autocorrect	true
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.class	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.disabled	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.id	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.max	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.min	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.name	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.orientation	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.placeholder	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.readonly	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.requirable	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.size	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.step	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.title	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\EntryTitleField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.0.width	100
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.1.fieldUid	"0fe7b7e2-1d66-4533-b80c-3e1b63fce160"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.1.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.1.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.1.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.1.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.1.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.1.width	25
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.2.fieldUid	"dd5974d9-ec7e-426b-aba0-2a01563861f4"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.2.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.2.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.2.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.2.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.2.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.2.width	25
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.3.fieldUid	"8b581eed-f474-4169-a920-318f01f5e16c"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.3.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.3.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.3.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.3.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.3.warning	null
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.contentColumnType	"text"
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.fieldGroup	"ca6b85ed-e3a8-4acc-953d-6400dde26c06"
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.handle	"sektor_id"
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.instructions	""
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.name	"SEKTOR ID"
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.searchable	false
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.settings.byteLimit	null
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.settings.charLimit	null
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.settings.code	""
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.settings.columnType	null
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.settings.initialRows	"4"
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.settings.multiline	""
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.settings.placeholder	""
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.settings.uiMode	"normal"
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.translationKeyFormat	null
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.translationMethod	"none"
fields.1d9b5925-be5a-4c98-b2a8-eb7addbc635c.type	"craft\\\\fields\\\\PlainText"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.0.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.0.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.0.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.0.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.0.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.0.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.1.fieldUid	"a6d20208-15f2-493d-8a54-0adae2193700"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.1.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.1.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.1.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.1.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.1.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.1.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.2.fieldUid	"1d9b5925-be5a-4c98-b2a8-eb7addbc635c"
fields.8b581eed-f474-4169-a920-318f01f5e16c.contentColumnType	"smallint(2)"
fields.8b581eed-f474-4169-a920-318f01f5e16c.fieldGroup	"5530bc01-dbd1-4eca-8a5d-fa8906f6a042"
fields.8b581eed-f474-4169-a920-318f01f5e16c.handle	"hall"
fields.8b581eed-f474-4169-a920-318f01f5e16c.instructions	""
fields.8b581eed-f474-4169-a920-318f01f5e16c.name	"Halle"
fields.8b581eed-f474-4169-a920-318f01f5e16c.searchable	false
fields.8b581eed-f474-4169-a920-318f01f5e16c.settings.decimals	0
fields.8b581eed-f474-4169-a920-318f01f5e16c.settings.defaultValue	null
fields.8b581eed-f474-4169-a920-318f01f5e16c.settings.max	"99"
fields.8b581eed-f474-4169-a920-318f01f5e16c.settings.min	"0"
fields.8b581eed-f474-4169-a920-318f01f5e16c.settings.prefix	""
fields.8b581eed-f474-4169-a920-318f01f5e16c.settings.previewCurrency	""
fields.8b581eed-f474-4169-a920-318f01f5e16c.settings.previewFormat	"decimal"
fields.8b581eed-f474-4169-a920-318f01f5e16c.settings.size	null
fields.8b581eed-f474-4169-a920-318f01f5e16c.settings.suffix	""
fields.8b581eed-f474-4169-a920-318f01f5e16c.translationKeyFormat	null
fields.8b581eed-f474-4169-a920-318f01f5e16c.translationMethod	"none"
fields.8b581eed-f474-4169-a920-318f01f5e16c.type	"craft\\\\fields\\\\Number"
fieldGroups.1409bb4a-dc75-44ba-99c9-5234616c4ab7.name	"Event"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.8.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.8.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.8.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.8.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.8.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.8.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.8.width	50
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.9.fieldUid	"10d914df-e824-4c0b-97c8-84c984dd0258"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.9.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.9.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.9.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.9.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.9.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.9.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.elements.9.width	50
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.name	"Inhalt"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.0.sortOrder	1
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.0.fieldUid	"a1edddb7-5eaf-4b3a-ac4f-5b58c6494d65"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.0.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.0.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.0.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.0.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.0.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.0.width	50
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.1.fieldUid	"24403202-e90c-4bf2-9f60-d8b2146f107b"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.1.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.1.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.1.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.1.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.1.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.elements.1.width	50
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.name	"Meta"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.1.sortOrder	2
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.0.fieldUid	"ee9512d9-701e-4e12-842e-02a6030b0da9"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.0.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.0.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.0.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.0.tip	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.0.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.0.width	100
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.1.fieldUid	"e95bbf80-2274-41dc-b724-b2a404d796de"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.1.instructions	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.1.label	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.1.required	false
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.1.tip	null
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.settings.byteLimit	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.1.warning	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.elements.1.width	100
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.name	"Suchmaschine"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.fieldLayouts.e633e577-fc52-4574-8ccb-971dbe2edda4.tabs.2.sortOrder	3
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.handle	"events"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.hasTitleField	true
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.name	"Veranstaltungen"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.section	"06745480-8d8c-4976-934e-dc80b2ab5632"
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.sortOrder	1
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.titleFormat	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.titleTranslationKeyFormat	null
entryTypes.75c0a1e7-4014-4664-ac9e-01d4114becdc.titleTranslationMethod	"none"
fieldGroups.1d55be6c-f0ae-45f5-91a7-6a4a464d109e.name	"Address"
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.settings.charLimit	null
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.settings.code	""
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.settings.columnType	null
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.settings.initialRows	"4"
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.settings.multiline	""
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.settings.placeholder	""
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.settings.uiMode	"normal"
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.translationKeyFormat	null
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.translationMethod	"none"
fields.0157ca30-ec6c-42c5-8869-589c4bf6965f.type	"craft\\\\fields\\\\PlainText"
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.contentColumnType	"text"
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.fieldGroup	"46e7d308-41fb-4441-87ee-70fa77295bf7"
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.handle	"person_firstname"
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.instructions	""
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.name	"Vorname"
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.searchable	false
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.settings.byteLimit	null
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.settings.charLimit	null
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.settings.code	""
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.settings.columnType	null
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.settings.initialRows	"4"
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.settings.multiline	""
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.settings.placeholder	""
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.settings.uiMode	"normal"
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.translationKeyFormat	null
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.translationMethod	"none"
fields.f88bfc01-1476-4bd4-9a6a-b65fff783658.type	"craft\\\\fields\\\\PlainText"
siteGroups.541d1036-b8ff-48fd-b44b-f39fd928f44e.name	"EMO"
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.contentColumnType	"text"
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.fieldGroup	"1d55be6c-f0ae-45f5-91a7-6a4a464d109e"
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.handle	"address_name"
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.instructions	""
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.name	"Firmenname"
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.searchable	false
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.settings.byteLimit	null
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.settings.charLimit	null
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.settings.code	""
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.settings.columnType	null
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.settings.initialRows	"4"
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.settings.multiline	""
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.settings.placeholder	""
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.settings.uiMode	"normal"
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.translationKeyFormat	null
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.translationMethod	"none"
fields.8cd7cefb-10df-4b63-a65f-2cadca1c4c1b.type	"craft\\\\fields\\\\PlainText"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.contentColumnType	"string"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.fieldGroup	"46e7d308-41fb-4441-87ee-70fa77295bf7"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.handle	"person_position"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.instructions	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.name	"Position"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.searchable	false
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.optgroups	true
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.0.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.0.__assoc__.0.1	"Selbständiger Unternehmer, Mitinhaber"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.0.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.0.__assoc__.1.1	"selbstaendigerUnternehmerMitinhaber"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.0.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.0.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.1.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.1.__assoc__.0.1	"freiberuflich Tätiger"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.1.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.1.__assoc__.1.1	"freiberuflichTaetiger"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.1.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.1.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.2.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.2.__assoc__.0.1	"Geschäftsführer, Vorstandsmitglied"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.2.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.2.__assoc__.1.1	"geschaeftsfuehrerVorstandsmitglied"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.2.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.2.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.3.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.3.__assoc__.0.1	"Behördenleiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.3.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.3.__assoc__.1.1	"behoerdenleiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.3.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.3.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.4.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.4.__assoc__.0.1	"Bereichsleiter, Betrieb-, Werks-, Filialleiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.4.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.4.__assoc__.1.1	"bereichsleiterBetriebWerksFilialleiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.4.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.4.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.5.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.5.__assoc__.0.1	"Amtsleiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.5.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.5.__assoc__.1.1	"amtsleiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.5.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.5.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.6.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.6.__assoc__.0.1	"Abteilungsleiter, Gruppenleiter/Teamleiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.6.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.6.__assoc__.1.1	"abteilungsleiterGruppenleiterTeamleiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.6.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.6.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.7.__assoc__.0.0	"label"
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.contentColumnType	"text"
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.fieldGroup	"1d55be6c-f0ae-45f5-91a7-6a4a464d109e"
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.handle	"address_street"
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.instructions	""
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.name	"Straße"
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.searchable	false
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.settings.byteLimit	null
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.settings.charLimit	null
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.settings.code	""
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.settings.columnType	null
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.settings.initialRows	"4"
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.settings.multiline	""
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.settings.placeholder	""
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.settings.uiMode	"normal"
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.translationKeyFormat	null
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.translationMethod	"none"
fields.4f5e11cf-b1e9-4f8e-a288-c8882b5b374d.type	"craft\\\\fields\\\\PlainText"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.7.__assoc__.0.1	"Andere Angestellte/Beamte, Facharbeiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.7.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.7.__assoc__.1.1	"andereAngestellteBeamteFacharbeiter"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.7.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.7.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.8.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.8.__assoc__.0.1	"Dozent, Lehrer"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.8.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.8.__assoc__.1.1	"dozentLehrer"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.8.__assoc__.2.0	"default"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.8.__assoc__.2.1	""
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.9.__assoc__.0.0	"label"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.9.__assoc__.0.1	"Auszubildender"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.9.__assoc__.1.0	"value"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.9.__assoc__.1.1	"auszubildender"
fields.92b7aba3-37db-44f6-bfb9-b7b63fb33ce9.settings.options.9.__assoc__.2.0	"default"
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.contentColumnType	"text"
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.fieldGroup	"1d55be6c-f0ae-45f5-91a7-6a4a464d109e"
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.handle	"address_postalcode"
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.instructions	""
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.name	"PLZ"
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.searchable	false
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.settings.byteLimit	null
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.settings.charLimit	null
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.settings.code	""
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.settings.columnType	null
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.settings.initialRows	"4"
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.settings.multiline	""
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.settings.placeholder	""
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.settings.uiMode	"normal"
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.translationKeyFormat	null
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.translationMethod	"none"
fields.1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33.type	"craft\\\\fields\\\\PlainText"
fieldGroups.ecf27a09-c4c5-43fc-bad8-3c666a274fe2.name	"Product"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.contentColumnType	"string"
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.contentColumnType	"text"
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.fieldGroup	"1d55be6c-f0ae-45f5-91a7-6a4a464d109e"
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.handle	"address_city"
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.instructions	""
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.name	"Stadt"
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.searchable	false
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.settings.byteLimit	null
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.settings.charLimit	null
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.settings.code	""
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.settings.columnType	null
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.settings.initialRows	"4"
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.settings.multiline	""
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.settings.placeholder	""
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.settings.uiMode	"normal"
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.translationKeyFormat	null
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.translationMethod	"none"
fields.8d3d3523-0a94-44fa-be0d-11ecb92bdc20.type	"craft\\\\fields\\\\PlainText"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.contentColumnType	"string"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.fieldGroup	"ecf27a09-c4c5-43fc-bad8-3c666a274fe2"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.handle	"product_images"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.instructions	""
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.name	"Bilder"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.searchable	false
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.allowSelfRelations	false
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.allowUploads	true
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.allowedKinds	null
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.defaultUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.defaultUploadLocationSubpath	""
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.limit	""
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.localizeRelations	false
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.previewMode	"full"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.restrictFiles	""
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.selectionLabel	""
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.showSiteMenu	false
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.showUnpermittedFiles	false
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.showUnpermittedVolumes	false
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.singleUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.singleUploadLocationSubpath	""
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.source	null
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.sources	"*"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.targetSiteId	null
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.useSingleFolder	false
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.validateRelatedElements	false
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.settings.viewMode	"list"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.translationKeyFormat	null
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.translationMethod	"site"
fields.dee5203e-54fb-4649-9f7f-11336a0b6da7.type	"craft\\\\fields\\\\Assets"
fields.531d4f4f-7561-416d-a5f2-116a484ad6ff.contentColumnType	"text"
fields.c85c285d-0701-44db-b2a7-306dd269680c.contentColumnType	"text"
dateModified	1611934842
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.isPublic	false
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.name	"IndustryArena"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.0	"sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d:read"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.1	"entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:read"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.2	"sections.2a038e37-6c48-4746-8b6d-b27fabf7972f:read"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.3	"entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:read"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.4	"volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd:read"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.5	"volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91:read"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.6	"volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7:read"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.7	"sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d:edit"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.8	"entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:edit"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.9	"entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:create"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.10	"entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:save"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.11	"entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:delete"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.12	"sections.2a038e37-6c48-4746-8b6d-b27fabf7972f:edit"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.13	"entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:edit"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.14	"entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:create"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.15	"entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:save"
graphql.schemas.5b81e3ee-a4a7-4060-86fc-deb4965e0741.scope.16	"entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:delete"
fieldGroups.ca6b85ed-e3a8-4acc-953d-6400dde26c06.name	"Exhibitor"
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.autocapitalize	true
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.autocomplete	false
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.autocorrect	true
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.class	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.disabled	false
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.id	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.instructions	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.label	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.max	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.min	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.name	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.orientation	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.placeholder	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.readonly	false
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.requirable	false
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.size	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.step	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.tip	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.title	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\TitleField"
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.warning	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.elements.0.width	100
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.name	"Inhalt"
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.fieldLayouts.94d02b6c-a146-4e67-9709-45dbe6b120ab.tabs.0.sortOrder	1
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.handle	"product_categories"
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.name	"VDW Nomenklatur"
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"nomenclature/{slug}"
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"nomenklatur/{slug}"
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.structure.maxLevels	2
categoryGroups.c01c0c86-571a-4af8-a30b-622e93d627d3.structure.uid	"6ce3fefa-8060-4e69-8df4-0e550b537554"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.contentColumnType	"string"
fields.c85c285d-0701-44db-b2a7-306dd269680c.fieldGroup	"e0052448-4c56-4da7-a2b5-d0739570cba1"
fields.c85c285d-0701-44db-b2a7-306dd269680c.handle	"website"
fields.c85c285d-0701-44db-b2a7-306dd269680c.instructions	""
fields.c85c285d-0701-44db-b2a7-306dd269680c.name	"Webseite"
fields.c85c285d-0701-44db-b2a7-306dd269680c.searchable	false
fields.c85c285d-0701-44db-b2a7-306dd269680c.settings.byteLimit	null
fields.c85c285d-0701-44db-b2a7-306dd269680c.settings.charLimit	null
fields.c85c285d-0701-44db-b2a7-306dd269680c.settings.code	""
fields.c85c285d-0701-44db-b2a7-306dd269680c.settings.columnType	null
fields.c85c285d-0701-44db-b2a7-306dd269680c.settings.initialRows	"4"
fields.c85c285d-0701-44db-b2a7-306dd269680c.settings.multiline	""
fields.c85c285d-0701-44db-b2a7-306dd269680c.settings.placeholder	"https://example.org"
fields.c85c285d-0701-44db-b2a7-306dd269680c.settings.uiMode	"normal"
fields.c85c285d-0701-44db-b2a7-306dd269680c.translationKeyFormat	null
fields.c85c285d-0701-44db-b2a7-306dd269680c.translationMethod	"none"
fields.c85c285d-0701-44db-b2a7-306dd269680c.type	"craft\\\\fields\\\\PlainText"
fields.8de8794b-837b-4213-85e6-3496dfb21d96.contentColumnType	"string"
fields.8de8794b-837b-4213-85e6-3496dfb21d96.fieldGroup	"34b5cb01-0278-41cb-8ac2-1c6d931920cf"
fields.8de8794b-837b-4213-85e6-3496dfb21d96.handle	"produkt_category"
fields.8de8794b-837b-4213-85e6-3496dfb21d96.instructions	""
fields.8de8794b-837b-4213-85e6-3496dfb21d96.name	"Produktkategorie"
fields.8de8794b-837b-4213-85e6-3496dfb21d96.searchable	false
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.allowLimit	false
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.allowMultipleSources	false
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.allowSelfRelations	false
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.branchLimit	"1"
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.limit	null
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.localizeRelations	false
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.selectionLabel	""
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.showSiteMenu	false
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.source	"group:c01c0c86-571a-4af8-a30b-622e93d627d3"
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.sources	"*"
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.targetSiteId	null
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.validateRelatedElements	false
fields.8de8794b-837b-4213-85e6-3496dfb21d96.settings.viewMode	null
fields.8de8794b-837b-4213-85e6-3496dfb21d96.translationKeyFormat	null
fields.8de8794b-837b-4213-85e6-3496dfb21d96.translationMethod	"site"
fields.8de8794b-837b-4213-85e6-3496dfb21d96.type	"craft\\\\fields\\\\Categories"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.2.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.2.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.2.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.2.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.2.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.2.width	50
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.fieldGroup	"ca6b85ed-e3a8-4acc-953d-6400dde26c06"
fields.b615217c-6a31-4d72-bc36-48a81c88be5d.fieldGroup	"46e7d308-41fb-4441-87ee-70fa77295bf7"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.3.fieldUid	"68317155-d437-4b8a-a640-382a9092e553"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.3.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.3.label	null
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.enableVersioning	false
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.handle	"products"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.name	"Produkte"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.previewTargets.0.__assoc__.0.0	"label"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.previewTargets.0.__assoc__.0.1	"Primäre eintrag Seite"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.previewTargets.0.__assoc__.1.0	"urlFormat"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.previewTargets.0.__assoc__.1.1	"{url}"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.previewTargets.0.__assoc__.2.0	"refresh"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.previewTargets.0.__assoc__.2.1	"1"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.propagationMethod	"all"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.enabledByDefault	true
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.hasUrls	true
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.template	null
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.siteSettings.34380f2c-988a-43d1-9723-8633250a5237.uriFormat	"products/{slug}"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.enabledByDefault	true
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.handle	"logo"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.instructions	""
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.name	"Logo"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.searchable	false
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.allowSelfRelations	false
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.allowUploads	true
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.allowedKinds	null
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.defaultUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.defaultUploadLocationSubpath	""
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.limit	"1"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.localizeRelations	false
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.previewMode	"full"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.restrictFiles	""
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.selectionLabel	""
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.showSiteMenu	false
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.showUnpermittedFiles	false
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.showUnpermittedVolumes	false
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.singleUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.singleUploadLocationSubpath	""
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.source	null
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.sources	"*"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.targetSiteId	null
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.useSingleFolder	false
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.validateRelatedElements	false
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.settings.viewMode	"list"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.translationKeyFormat	null
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.translationMethod	"site"
fields.3a7873dc-80ec-4fc1-8702-0cd23d307ad0.type	"craft\\\\fields\\\\Assets"
fields.5791152b-3883-4751-9803-a1efd9730f3d.fieldGroup	"ca6b85ed-e3a8-4acc-953d-6400dde26c06"
fields.5791152b-3883-4751-9803-a1efd9730f3d.handle	"bbi"
fields.5791152b-3883-4751-9803-a1efd9730f3d.instructions	""
fields.5791152b-3883-4751-9803-a1efd9730f3d.name	"Bühnenbild"
fields.5791152b-3883-4751-9803-a1efd9730f3d.searchable	false
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.allowSelfRelations	false
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.allowUploads	true
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.allowedKinds	null
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.defaultUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.defaultUploadLocationSubpath	""
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.limit	"1"
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.localizeRelations	false
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.previewMode	"full"
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.restrictFiles	""
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.selectionLabel	""
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.showSiteMenu	false
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.showUnpermittedFiles	false
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.showUnpermittedVolumes	false
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.singleUploadLocationSource	"volume:24c25c8a-80ea-4d24-ad72-d168a19e07cd"
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.singleUploadLocationSubpath	""
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.source	null
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.sources	"*"
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.targetSiteId	null
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.useSingleFolder	false
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.validateRelatedElements	false
fields.5791152b-3883-4751-9803-a1efd9730f3d.settings.viewMode	"list"
fields.5791152b-3883-4751-9803-a1efd9730f3d.translationKeyFormat	null
fields.5791152b-3883-4751-9803-a1efd9730f3d.translationMethod	"site"
fields.5791152b-3883-4751-9803-a1efd9730f3d.type	"craft\\\\fields\\\\Assets"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.hasUrls	true
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.template	null
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.siteSettings.ff97e19b-a38b-48c6-b4a8-4ed14019ec07.uriFormat	"produkte/{slug}"
sections.2a038e37-6c48-4746-8b6d-b27fabf7972f.type	"channel"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.3.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.3.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.3.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.elements.3.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.name	"Sonstiges"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.2.sortOrder	3
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.0.fieldUid	"2b41ab49-178c-4ff2-b65d-fbbe2e33c562"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.0.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.0.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.0.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.0.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.0.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.0.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.1.fieldUid	"9289a943-5ab0-45f8-9b78-876519730902"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.1.instructions	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.autocapitalize	true
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.contentColumnType	"text"
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.fieldGroup	"dbde185a-c4d5-4159-96a4-e75394214c6c"
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.handle	"body_raw"
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.instructions	""
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.name	"Inhalt"
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.searchable	false
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.settings.byteLimit	null
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.settings.charLimit	null
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.settings.code	""
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.settings.columnType	null
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.settings.initialRows	"12"
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.settings.multiline	"1"
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.settings.placeholder	""
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.settings.uiMode	"normal"
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.translationKeyFormat	null
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.translationMethod	"site"
fields.fa67a40b-6951-46d9-bda9-4369aa5dc327.type	"craft\\\\fields\\\\PlainText"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.1.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.1.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.1.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.1.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.1.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.2.fieldUid	"41e6657f-1bf4-42fb-bd66-4aea4f6d895b"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.2.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.2.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.2.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.2.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.2.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.2.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.3.fieldUid	"e61e3323-bb6b-466f-9f03-1a5c39d1605b"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.3.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.3.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.3.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.3.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.3.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.3.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.4.fieldUid	"f226fb33-c938-4e3d-9c88-8d5678ddb8ea"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.4.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.4.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.4.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.4.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.4.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.4.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.5.fieldUid	"de7b667a-9d74-454c-bfd4-78f261a771a2"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.5.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.5.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.5.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.5.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.5.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.5.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.autocapitalize	true
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.autocomplete	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.autocorrect	true
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.class	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.disabled	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.id	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.instructions	""
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.label	"Name"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.max	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.min	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.name	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.orientation	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.placeholder	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.readonly	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.requirable	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.size	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.step	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.title	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\EntryTitleField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.0.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.1.fieldUid	"3a7873dc-80ec-4fc1-8702-0cd23d307ad0"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.1.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.1.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.1.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.1.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.1.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.1.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.2.fieldUid	"5791152b-3883-4751-9803-a1efd9730f3d"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.2.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.2.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.2.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.2.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.2.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.2.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.3.fieldUid	"38135310-b63d-4169-8f04-6fbbe0404998"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.3.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.3.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.3.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.3.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.3.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.3.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.4.fieldUid	"fa67a40b-6951-46d9-bda9-4369aa5dc327"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.4.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.4.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.4.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.4.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.4.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.4.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.5.heading	"Standort"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.5.type	"craft\\\\fieldlayoutelements\\\\Heading"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.6.fieldUid	"8b581eed-f474-4169-a920-318f01f5e16c"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.6.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.6.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.6.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.6.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.6.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.6.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.6.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.7.fieldUid	"b819a17b-d2a6-48e3-81e8-e8496f4073c2"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.7.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.7.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.7.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.7.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.7.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.7.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.elements.7.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.name	"Inhalt"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.0.sortOrder	1
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.0.heading	"Ansprechpartner"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.0.type	"craft\\\\fieldlayoutelements\\\\Heading"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.1.fieldUid	"b615217c-6a31-4d72-bc36-48a81c88be5d"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.1.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.1.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.1.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.1.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.1.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.1.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.2.fieldUid	"531d4f4f-7561-416d-a5f2-116a484ad6ff"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.2.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.2.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.2.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.2.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.2.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.2.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.3.fieldUid	"f88bfc01-1476-4bd4-9a6a-b65fff783658"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.3.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.3.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.3.required	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.autocomplete	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.autocorrect	true
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.class	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.disabled	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.id	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.instructions	""
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.label	"Name"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.max	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.min	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.name	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.orientation	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.placeholder	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.readonly	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.requirable	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.size	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.step	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.tip	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.title	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\EntryTitleField"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.warning	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.0.width	100
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.1.fieldUid	"24403202-e90c-4bf2-9f60-d8b2146f107b"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.1.instructions	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.1.label	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.1.required	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.1.tip	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.1.warning	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.1.width	50
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.2.fieldUid	"dee5203e-54fb-4649-9f7f-11336a0b6da7"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.2.instructions	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.2.label	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.2.required	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.2.tip	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.2.warning	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.2.width	50
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.3.fieldUid	"fa67a40b-6951-46d9-bda9-4369aa5dc327"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.3.instructions	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.3.label	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.3.required	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.3.tip	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.3.warning	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.3.width	100
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.4.fieldUid	"c85c285d-0701-44db-b2a7-306dd269680c"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.4.instructions	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.4.label	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.4.required	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.4.tip	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.4.warning	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.4.width	100
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.5.fieldUid	"8de8794b-837b-4213-85e6-3496dfb21d96"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.5.instructions	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.5.label	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.5.required	false
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.5.tip	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.5.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.5.warning	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.elements.5.width	100
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.name	"Inhalt"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.fieldLayouts.a4a554ec-af28-4fd5-8b0a-48b5ba8c76e8.tabs.0.sortOrder	1
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.handle	"products"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.hasTitleField	true
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.name	"Produkte"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.section	"2a038e37-6c48-4746-8b6d-b27fabf7972f"
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.sortOrder	1
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.titleFormat	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.titleTranslationKeyFormat	null
entryTypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63.titleTranslationMethod	"none"
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.autocapitalize	true
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.autocomplete	false
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.autocorrect	true
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.class	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.disabled	false
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.id	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.instructions	""
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.label	""
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.max	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.min	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.name	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.orientation	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.placeholder	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.readonly	false
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.requirable	false
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.size	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.step	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.tip	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.title	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\AssetTitleField"
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.warning	null
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.elements.0.width	100
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.name	"Content"
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.fieldLayouts.27caa54a-ccef-47d2-b7b4-05aab0d84ac4.tabs.0.sortOrder	1
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.handle	"persons_2019"
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.hasUrls	true
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.name	"Personen 2019"
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.settings.path	"@webroot/persons_2019"
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.sortOrder	1
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.type	"craft\\\\volumes\\\\Local"
volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd.url	"@web/persons_2019"
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.autocapitalize	true
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.autocomplete	false
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.autocorrect	true
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.class	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.disabled	false
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.id	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.instructions	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.label	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.max	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.min	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.name	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.orientation	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.placeholder	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.readonly	false
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.requirable	false
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.size	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.step	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.tip	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.title	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\AssetTitleField"
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.warning	null
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.elements.0.width	100
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.name	"Inhalt"
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.fieldLayouts.76ba5428-f073-4669-846b-89e4b887a1d3.tabs.0.sortOrder	1
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.handle	"article_2019"
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.hasUrls	true
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.name	"Artikel 2019"
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.settings.path	"@webroot/article_2019"
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.sortOrder	3
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.type	"craft\\\\volumes\\\\Local"
volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7.url	"@web/article_2019"
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.autocapitalize	true
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.autocomplete	false
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.autocorrect	true
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.class	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.disabled	false
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.id	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.instructions	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.label	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.max	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.min	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.name	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.orientation	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.placeholder	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.readonly	false
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.requirable	false
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.size	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.step	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.tip	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.title	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\AssetTitleField"
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.warning	null
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.elements.0.width	100
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.name	"Inhalt"
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.fieldLayouts.17fddcbf-504b-4f3d-a096-e52d47d417cb.tabs.0.sortOrder	1
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.handle	"pages_2019"
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.hasUrls	true
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.name	"Seiten 2019"
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.settings.path	"@webroot/pages_2019"
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.sortOrder	2
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.type	"craft\\\\volumes\\\\Local"
volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91.url	"@web/pages_2019"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.isPublic	true
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.name	"Public Schema"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.0	"sections.9b5bd243-bb29-4fea-81a4-e597852129b7:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.1	"entrytypes.e7599b97-ad13-4eea-bd62-3fdd165886ce:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.2	"sections.1b0aae41-58ef-4c4b-8749-6e8a8c98221d:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.3	"entrytypes.5f92a88d-eede-41f6-8695-815d1211d2fe:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.4	"sections.f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.5	"entrytypes.4926019f-9936-4a51-a84f-38d927e89c25:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.6	"sections.ea25caf0-a9ce-415f-91f4-7c047d9b1933:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.7	"entrytypes.0d410440-cbd2-47b2-8a7f-21e7b8afe43e:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.8	"sections.0daaa545-d1a0-4655-a507-2bac8b560f1d:read"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.3.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.3.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.3.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.4.fieldUid	"0157ca30-ec6c-42c5-8869-589c4bf6965f"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.4.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.4.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.4.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.4.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.4.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.4.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.5.heading	"Anschrift"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.5.type	"craft\\\\fieldlayoutelements\\\\Heading"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.6.fieldUid	"8cd7cefb-10df-4b63-a65f-2cadca1c4c1b"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.6.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.6.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.6.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.6.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.6.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.6.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.6.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.7.fieldUid	"4f5e11cf-b1e9-4f8e-a288-c8882b5b374d"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.7.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.7.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.7.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.7.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.7.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.7.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.7.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.8.fieldUid	"1f8b3b3f-ed42-4b28-b49e-cef4c51a0e33"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.8.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.8.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.8.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.8.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.8.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.8.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.1.elements.8.width	50
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.5.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.6.fieldUid	"dced25a8-d4dc-49a1-a4d9-4d7edea2959c"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.6.instructions	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.6.label	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.6.required	false
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.6.tip	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.6.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.6.warning	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.elements.6.width	100
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.name	"Soziale Netzwerke"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.fieldLayouts.fc561d93-5d34-40b4-a588-f309aeb64350.tabs.3.sortOrder	4
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.handle	"exhibitors"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.hasTitleField	true
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.name	"Aussteller"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.section	"1b0aae41-58ef-4c4b-8749-6e8a8c98221d"
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.sortOrder	2
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.titleFormat	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.titleTranslationKeyFormat	null
entryTypes.5f92a88d-eede-41f6-8695-815d1211d2fe.titleTranslationMethod	"none"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.9	"entrytypes.f2313657-ca71-492d-9931-0f1a1c49cdce:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.10	"sections.2a038e37-6c48-4746-8b6d-b27fabf7972f:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.11	"entrytypes.e93d03f4-73b1-4675-b5f7-1aff6d7f7a63:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.12	"sections.06745480-8d8c-4976-934e-dc80b2ab5632:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.13	"entrytypes.75c0a1e7-4014-4664-ac9e-01d4114becdc:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.14	"volumes.24c25c8a-80ea-4d24-ad72-d168a19e07cd:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.15	"volumes.6d6fb726-ec98-4924-a4c4-0d5e30359a91:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.16	"volumes.6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.17	"categorygroups.61b9cdf6-219a-4096-b35b-538d624e1ba9:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.18	"categorygroups.68aee50b-ea3a-4325-aed3-211fef3f4db3:read"
graphql.schemas.e5041870-fbde-43c9-97ce-9950766b32e5.scope.19	"categorygroups.c01c0c86-571a-4af8-a30b-622e93d627d3:read"
\.


--
-- Data for Name: queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.queue (id, channel, job, description, "timePushed", ttr, delay, priority, "dateReserved", "timeUpdated", progress, "progressLabel", attempt, fail, "dateFailed", error) FROM stdin;
445	queue	\\x4f3a33343a2263726166745c71756575655c6a6f62735c557064617465536561726368496e646578223a373a7b733a31313a22656c656d656e7454797065223b733a32303a2263726166745c656c656d656e74735c456e747279223b733a393a22656c656d656e744964223b693a3231323b733a363a22736974654964223b693a323b733a31323a226669656c6448616e646c6573223b613a353a7b693a303b733a31303a227468756d62696d616765223b693a313b733a31343a2270726f647563745f696d61676573223b693a323b733a383a22626f64795f726177223b693a333b733a373a2277656273697465223b693a343b733a31363a2270726f64756b745f63617465676f7279223b7d733a31313a226465736372697074696f6e223b4e3b733a33303a220063726166745c71756575655c426173654a6f62005f70726f6772657373223b693a303b733a33353a220063726166745c71756575655c426173654a6f62005f70726f67726573734c6162656c223b4e3b7d	Aktualisiere Suchindexe	1612195327	300	0	1024	\N	\N	0	\N	\N	f	\N	\N
446	queue	\\x4f3a33343a2263726166745c71756575655c6a6f62735c557064617465536561726368496e646578223a373a7b733a31313a22656c656d656e7454797065223b733a32303a2263726166745c656c656d656e74735c456e747279223b733a393a22656c656d656e744964223b693a3231323b733a363a22736974654964223b733a313a222a223b733a31323a226669656c6448616e646c6573223b613a303a7b7d733a31313a226465736372697074696f6e223b4e3b733a33303a220063726166745c71756575655c426173654a6f62005f70726f6772657373223b693a303b733a33353a220063726166745c71756575655c426173654a6f62005f70726f67726573734c6162656c223b4e3b7d	Aktualisiere Suchindexe	1612195327	300	0	1024	\N	\N	0	\N	\N	f	\N	\N
\.


--
-- Data for Name: relations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.relations (id, "fieldId", "sourceId", "sourceSiteId", "targetId", "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
104	14	155	\N	138	1	2021-01-22 15:34:39	2021-01-22 15:34:39	98fed984-1478-4dde-8795-e2e3062c5298
105	14	155	\N	139	2	2021-01-22 15:34:39	2021-01-22 15:34:39	6af22c58-4865-4c95-a610-04c26ce6e0d0
113	53	196	\N	197	1	2021-01-27 15:42:30	2021-01-27 15:42:30	6af6fea1-76e8-4815-801b-e5b858a3db06
\.


--
-- Data for Name: resourcepaths; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resourcepaths (hash, path) FROM stdin;
dc6539c	@app/web/assets/updateswidget/dist
572a7dc1	@app/web/assets/feed/dist
85b2c8e0	@app/web/assets/edituser/dist
a7fdf164	@lib/timepicker
354ff5d	@app/web/assets/craftsupport/dist
ed3c7833	@app/web/assets/dashboard/dist
53bf865e	@app/web/assets/cp/dist
71091120	@lib/jquery-ui
c332f654	@lib/prismjs
f83c78c1	@app/web/assets/edituser/dist
7048e3bd	@app/web/assets/updateswidget/dist
7bde5169	@lib/axios
52ae5cc7	@app/web/assets/userpermissions/dist
32ed8ee4	@craft/web/assets/editentry/dist
ba6d4081	@lib/fileupload
93055a3a	@craft/web/assets/fields/dist
a5217dbd	@lib/jquery-touch-events
c3687004	@lib/timepicker
cd5f1ed3	@craft/redactor/assets/redactor/dist
4c4a74ee	@app/web/assets/utilities/dist
ef58cbe7	@lib/datepicker-i18n
b3f9bc63	@app/web/assets/admintable/dist
94c4f97	@craft/web/assets/edituser/dist
2a0f2301	@app/web/assets/login/dist
7075cdc2	@craft/web/assets/editsection/dist
5635f21c	@lib/vue
64ec8fac	@app/web/assets/generalsettings/dist
cd0be30c	@craft/web/assets/recententries/dist
4169f8c6	@app/web/assets/assetindexes/dist
4ef2a1d3	@app/web/assets/recententries/dist
35097b54	@app/web/assets/pluginstore/dist
6b89c06f	@craft/redactor/assets/field/dist
f2c1b742	@app/web/assets/updates/dist
2aa4cde0	@app/web/assets/feed/dist
1d9301a3	@app/web/assets/updater/dist
2e31367f	@app/web/assets/cp/dist
32a0737c	@lib/vue
1f4bd009	@lib/axios
c8b5e04e	@lib/d3
541d576b	@craft/web/assets/craftsupport/dist
2f20ece6	@app/web/assets/userpermissions/dist
652a576d	@lib/element-resize-detector
fb08f7c8	@lib/garnishjs
4abafc98	@bower/jquery/dist
c1b4fcdd	@lib/jquery-touch-events
5b350be5	@lib/velocity
159c9040	@lib/jquery-ui
4712a40d	@lib/jquery.payment
8bcd4a87	@lib/datepicker-i18n
c610c01f	@lib/picturefill
926eed9b	@lib/selectize
def8c1e1	@lib/fileupload
9802a911	@lib/xregexp
ee4e23f6	@lib/fabric
d25bfef6	@lib/iframe-resizer
ade5d21a	@craft/web/assets/sites/dist
fe85ebf6	@craft/redactor/assets/redactor/dist
124b4ce4	@craft/web/assets/dashboard/dist
cd9aba33	@app/web/assets/editentry/dist
ac20612e	@lib/d3
5301a7bc	@craft/redactor/assets/redactor-plugins/dist/fullscreen
c32229ac	@app/web/assets/clearcaches/dist
5c1be0a6	@craft/web/assets/login/dist
57819320	@app/web/assets/login/dist
fcd0f855	@craft/redactor/assets/redactor-plugins/dist/video
62564c0a	@app/web/assets/graphiql/dist
3fa08a85	@lib/velocity
7eda4f7c	@app/web/assets/craftsupport/dist
9a2ba2ef	@craft/web/assets/admintable/dist
d2798501	@app/web/assets/plugins/dist
a285417f	@lib/picturefill
93267b5c	@craft/web/assets/graphiql/dist
337c11f2	@app/web/assets/recententries/dist
fef2823b	@craft/web/assets/fieldsettings/dist
8adba296	@lib/fabric
601db182	@app/web/assets/updater/dist
fa9ef539	@craft/web/assets/generalsettings/dist
2387256d	@lib/jquery.payment
90b2c812	@app/web/assets/dashboard/dist
fc972871	@lib/xregexp
4887cb75	@app/web/assets/pluginstore/dist
2e2f7df8	@bower/jquery/dist
f3b1a162	@craft/web/assets/updateswidget/dist
b1529673	@craft/web/assets/userpermissions/dist
b33d4039	@craft/web/assets/utilities/dist
6b086a2f	@craft/web/assets/feed/dist
a67fa19c	@app/web/assets/sites/dist
b6ce7f96	@lib/iframe-resizer
cf0a0d70	@craft/redactor/assets/redactor-plugins/dist/video
1bfd60d	@lib/element-resize-detector
a7a77734	@lib/prismjs
e0b4488e	@craft/web/assets/pluginstore/dist
ce770c42	@app/web/assets/admintable/dist
2b9a13b2	@craft/web/assets/updates/dist
9f9d76a8	@lib/garnishjs
c4c8a553	@craft/web/assets/updater/dist
b0140a12	@app/web/assets/editentry/dist
76ac91d0	@craft/web/assets/plugins/dist
e9cf78f3	@craft/web/assets/cp/dist
9e19a20e	@app/web/assets/queuemanager/dist
8f4f0763	@app/web/assets/updates/dist
f6fb6cfb	@lib/selectize
31c4c4cf	@app/web/assets/utilities/dist
3afde3b0	@app/web/assets/utilities/dist
60db5299	@craft/redactor/assets/redactor-plugins/dist/fullscreen
8dbf6096	@lib/garnishjs
be027710	@lib/d3
2d829cbb	@lib/velocity
ad4686e3	@app/web/assets/sites/dist
5cb8b45f	@app/web/assets/login/dist
3c0d6bc6	@bower/jquery/dist
69fc4757	@lib/axios
6343b8a0	@app/web/assets/findreplace/dist
696f6b75	@app/web/assets/graphiql/dist
6c794890	@app/web/assets/tablesettings/dist
e9094f35	@lib/axios
bb2d2d6d	@app/web/assets/editentry/dist
3ef77f72	@lib/d3
9368c851	@lib/element-resize-detector
d4a68f4	@lib/garnishjs
259ef320	@lib/jquery-ui
f5166061	@app/web/assets/craftsupport/dist
fb84cca0	@app/web/assets/updateswidget/dist
c54e2b3d	@app/web/assets/admintable/dist
71436862	@app/web/assets/systemmessages/dist
a168e2fd	@app/web/assets/feed/dist
1b7ee70f	@app/web/assets/dashboard/dist
219dea9f	@app/web/assets/feed/dist
37f663e1	@lib/jquery-touch-events
ad7794d9	@lib/velocity
e3de0f7c	@lib/jquery-ui
b585610a	@lib/prismjs
299c22e4	@app/web/assets/fieldsettings/dist
d14a663a	@lib/timepicker
b1503b31	@lib/jquery.payment
2436682c	@app/web/assets/dbbackup/dist
7d8fd5bb	@lib/datepicker-i18n
30525f23	@lib/picturefill
4417e422	@lib/vue
642c72a7	@lib/selectize
28ba5edd	@lib/fileupload
6e40362d	@lib/xregexp
180cbcca	@lib/fabric
241961ca	@lib/iframe-resizer
dc4dbc3d	@app/web/assets/login/dist
c342045c	@app/web/assets/fields/dist
5886a121	@app/web/assets/cp/dist
139dc033	@lib/element-resize-detector
b7036b83	@lib/jquery-touch-events
d940a27e	@app/web/assets/plugins/dist
f3055fbe	@app/web/assets/edituser/dist
632b071e	@lib/jquery-ui
c81b0ed3	@app/web/assets/clearcaches/dist
45cb86ac	@app/web/assets/recententries/dist
bc73677	@vendor/yiisoft/yii2/assets
d37f6946	@app/web/assets/editsection/dist
31a53353	@lib/jquery.payment
fd7addd9	@lib/datepicker-i18n
e27a0ff6	@yii/debug/assets
b0a75741	@lib/picturefill
e4d97ac5	@lib/selectize
a84f56bf	@lib/fileupload
eeb53e4f	@lib/xregexp
98f9b4a8	@lib/fabric
a4ec69a8	@lib/iframe-resizer
8476201c	@app/web/assets/updates/dist
2a2101c	@lib/vue
43beec0a	@app/web/assets/pluginstore/dist
95208571	@app/web/assets/queuemanager/dist
2419cb99	@app/web/assets/userpermissions/dist
75e36803	@app/web/assets/craftsupport/dist
9b8bef6d	@app/web/assets/dashboard/dist
655326cf	@app/web/assets/utilities/dist
45bb235f	@app/web/assets/admintable/dist
bcf863a4	@bower/jquery/dist
d873a943	@app/web/assets/cp/dist
de4c4096	@lib/fabric
ba08ebd2	@app/web/assets/utilities/dist
6fd5a8d3	@app/web/assets/generalsettings/dist
7ab89ff8	@bower/jquery/dist
7b71c4c2	@app/web/assets/updateswidget/dist
3167120	@app/web/assets/login/dist
dbd8e563	@app/web/assets/updates/dist
4ff97b8f	@app/web/assets/matrixsettings/dist
1a6543d3	@app/web/assets/recententries/dist
c5b93817	@app/web/assets/deprecationerrors/dist
c53e8ece	@app/web/assets/recententries/dist
bbcf29e7	@lib/datepicker-i18n
48ee06b1	@app/web/assets/clearcaches/dist
c4e2ec40	@lib/vue
f8b7832e	@lib/d3
2f49b369	@lib/axios
83fbdf03	@app/web/assets/admintable/dist
24df01bd	@app/web/assets/updateswidget/dist
35706968	@lib/prismjs
7710c76d	@lib/jquery.payment
1e33551f	@app/web/assets/cp/dist
483287e	@app/web/assets/updates/dist
5528340d	@lib/element-resize-detector
ca8e400e	@app/web/assets/queuemanager/dist
2a4dad7c	@app/web/assets/craftsupport/dist
8eaefaed	@app/web/assets/clearcaches/dist
97ff9204	@lib/timepicker
cb0a94a8	@lib/garnishjs
8cd1ac39	@app/web/assets/editsection/dist
f612a37f	@lib/picturefill
e2599d96	@lib/iframe-resizer
a26c8efb	@lib/selectize
f1b69fbd	@lib/jquery-touch-events
1c102975	@app/web/assets/pluginstore/dist
ce52b87	@app/web/assets/assetindexes/dist
e483e812	@app/web/assets/editentry/dist
eefaa281	@lib/fileupload
5853354a	@craft/redactor/assets/field/dist
3ced7ddf	@app/web/assets/findreplace/dist
f2e8439c	@app/web/assets/sites/dist
7e332fe0	@app/web/assets/feed/dist
f3309534	@lib/prismjs
6b376885	@lib/velocity
fb6da531	@app/web/assets/dbbackup/dist
2e093c92	@lib/garnishjs
c4252a12	@app/web/assets/dashboard/dist
a800ca71	@lib/xregexp
2eedad1d	@app/web/assets/systemmessages/dist
8e34c0bf	@lib/velocity
14b53787	@lib/jquery-touch-events
9fbb37c2	@bower/jquery/dist
92136f57	@lib/jquery.payment
ca4a1b53	@lib/axios
c09d5b1a	@lib/jquery-ui
4bbb793d	@storage/rebrand/icon
1db42b14	@lib/d3
1ed3a37b	@app/web/assets/utilities/dist
778fb1d5	@lib/vue
3f672f3a	@app/web/assets/pluginstore/dist
e1606bf6	@app/web/assets/admintable/dist
a05860d7	@app/web/assets/updates/dist
7ca8e1ea	@app/web/assets/cp/dist
595ee1e2	@vendor/yiisoft/yii2/assets
b8749ba2	@yii/debug/assets
b02b9c37	@lib/element-resize-detector
5ecc81dd	@lib/datepicker-i18n
13110b45	@lib/picturefill
476f26c1	@lib/selectize
bf90abb	@lib/fileupload
4d03624b	@lib/xregexp
3b4fe8ac	@lib/fabric
75a35ac	@lib/iframe-resizer
4bfbe818	@app/web/assets/generalsettings/dist
d72b1f75	@app/web/assets/edituser/dist
378b52	@app/web/assets/userpermissions/dist
7896f494	@app/web/assets/login/dist
4f0ad636	@app/web/assets/updater/dist
15b6a845	@app/web/assets/graphiql/dist
c7f4ee5d	@app/web/assets/editentry/dist
61e5c667	@app/web/assets/recententries/dist
3912459c	@app/web/assets/recententries/dist
6790acc1	@app/web/assets/pluginstore/dist
9f036da6	@app/web/assets/editentry/dist
6e7e9f72	@app/web/assets/assetindexes/dist
51cd28c8	@app/web/assets/craftsupport/dist
5b3aa54	@app/web/assets/feed/dist
bfa5afa6	@app/web/assets/dashboard/dist
fd6ee2b5	@app/web/assets/plugins/dist
f8afe32c	@app/web/assets/updates/dist
46242080	@app/web/assets/utilities/dist
16333d0e	@lib/prismjs
5a6412a0	@lib/axios
8d9a22e7	@lib/d3
c1a788df	@app/web/assets/pluginstoreoauth/dist
200595c4	@lib/element-resize-detector
5f5f8409	@app/web/assets/updateswidget/dist
4d412bbe	@app/web/assets/graphiql/dist
be273561	@lib/garnishjs
861d34fd	@lib/prismjs
e2d233cd	@lib/timepicker
849b3e74	@lib/jquery-touch-events
58c008a9	@app/web/assets/userpermissions/dist
1e1ac94c	@lib/velocity
50b352e9	@lib/jquery-ui
93aab33	@app/web/assets/craftsupport/dist
656c4794	@bower/yii2-pjax
7a807f2	@app/web/assets/updateswidget/dist
5d4429af	@app/web/assets/feed/dist
e7522c5d	@app/web/assets/dashboard/dist
8968c628	@app/web/assets/sites/dist
e7a1b826	@lib/vue
f6d67eca	@app/web/assets/admintable/dist
23d66a4	@lib/jquery.payment
cee2882e	@lib/datepicker-i18n
8fdc9c8e	@app/web/assets/edituser/dist
72fc3a3e	@lib/timepicker
833f02b6	@lib/picturefill
d7412f32	@lib/selectize
9bd70348	@lib/fileupload
dd2d6bb8	@lib/xregexp
ab61e15f	@lib/fabric
2061776f	@app/web/assets/login/dist
97743c5f	@lib/iframe-resizer
f953e31	@bower/jquery/dist
6b1ef4d6	@app/web/assets/cp/dist
\.


--
-- Data for Name: revisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revisions (id, "sourceId", "creatorId", num, notes) FROM stdin;
\.


--
-- Data for Name: searchindex; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.searchindex ("elementId", attribute, "fieldId", "siteId", keywords, keywords_vector) FROM stdin;
206	username	0	1	 stefan schwaneck 	'schwaneck' 'stefan'
206	firstname	0	1	 stefan 	'stefan'
174	slug	0	2	 software 	'software'
174	title	0	2	 software 	'software'
174	slug	0	1	 software 	'software'
174	title	0	1	 software 	'software'
206	lastname	0	1	 schwaneck 	'schwaneck'
206	fullname	0	1	 stefan schwaneck 	'schwaneck' 'stefan'
206	email	0	1	 s schwaneck vdw de 	'de' 's' 'schwaneck' 'vdw'
206	slug	0	1		
178	slug	0	2	 milano 	'milano'
178	title	0	2	 milano 	'milano'
178	slug	0	1	 milano 	'milano'
178	title	0	1	 milano 	'milano'
207	username	0	1	 sebastian noell 	'noell' 'sebastian'
207	firstname	0	1	 sebastian 	'sebastian'
207	lastname	0	1	 noell 	'noell'
207	fullname	0	1	 sebastian noell 	'noell' 'sebastian'
207	email	0	1	 noell 4ft de 	'4ft' 'de' 'noell'
207	slug	0	1		
175	slug	0	2	 intern 	'intern'
175	title	0	2	 intern 	'intern'
175	slug	0	1	 intern 	'intern'
175	title	0	1	 intern 	'intern'
1	username	0	1	 dev industryarena com 	'com' 'dev' 'industryarena'
1	firstname	0	1	 laura 	'laura'
1	lastname	0	1	 meister 	'meister'
1	fullname	0	1	 laura meister 	'laura' 'meister'
1	email	0	1	 dev industryarena com 	'com' 'dev' 'industryarena'
1	slug	0	1		
210	slug	0	1	 bbb 	'bbb'
210	title	0	1	 aaaaa 	'aaaaa'
210	slug	0	2	 bbb 	'bbb'
210	title	0	2	 aaaaa 	'aaaaa'
16	username	0	1	 alexej kloos 	'alexej' 'kloos'
16	firstname	0	1	 alexej 	'alexej'
16	lastname	0	1	 kloos 	'kloos'
16	fullname	0	1	 alexej kloos 	'alexej' 'kloos'
16	email	0	1	 alexej kloos industryarena com 	'alexej' 'com' 'industryarena' 'kloos'
16	slug	0	1		
176	slug	0	2	 highlight 	'highlight'
176	title	0	2	 highlight 	'highlight'
176	slug	0	1	 highlight 	'highlight'
176	title	0	1	 highlight 	'highlight'
179	slug	0	2	 zerspanung 	'zerspanung'
179	title	0	2	 zerspanung 	'zerspanung'
179	slug	0	1	 zerspanung 	'zerspanung'
179	title	0	1	 zerspanung 	'zerspanung'
201	filename	0	1	 20 jpg 	'20' 'jpg'
201	extension	0	1	 jpg 	'jpg'
201	kind	0	1	 image 	'image'
201	slug	0	1		
201	title	0	1	 20 	'20'
139	slug	0	1	 journalisten 	'journalisten'
139	title	0	1	 journalisten 	'journalisten'
139	slug	0	2	 journalisten 	'journalisten'
139	title	0	2	 journalisten 	'journalisten'
139	slug	0	3	 journalisten 	'journalisten'
139	title	0	3	 journalisten 	'journalisten'
201	filename	0	2	 20 jpg 	'20' 'jpg'
201	extension	0	2	 jpg 	'jpg'
201	kind	0	2	 image 	'image'
201	slug	0	2		
141	slug	0	1	 aussteller 	'aussteller'
141	title	0	1	 aussteller 	'aussteller'
141	slug	0	2	 aussteller 	'aussteller'
141	title	0	2	 aussteller 	'aussteller'
201	title	0	2	 20 	'20'
141	slug	0	3	 aussteller 	'aussteller'
141	title	0	3	 aussteller 	'aussteller'
202	filename	0	1	 44 jpg 	'44' 'jpg'
202	extension	0	1	 jpg 	'jpg'
202	kind	0	1	 image 	'image'
202	slug	0	1		
143	slug	0	1	 veranstaltungsart 	'veranstaltungsart'
143	title	0	1	 veranstaltungsart 	'veranstaltungsart'
143	slug	0	2	 veranstaltungsart 	'veranstaltungsart'
143	title	0	2	 veranstaltungsart 	'veranstaltungsart'
143	slug	0	3	 veranstaltungsart 	'veranstaltungsart'
143	title	0	3	 veranstaltungsart 	'veranstaltungsart'
202	title	0	1	 44 	'44'
202	filename	0	2	 44 jpg 	'44' 'jpg'
202	extension	0	2	 jpg 	'jpg'
202	kind	0	2	 image 	'image'
145	slug	0	1	 foren 	'foren'
145	title	0	1	 foren 	'foren'
145	slug	0	2	 foren 	'foren'
145	title	0	2	 foren 	'foren'
145	slug	0	3	 foren 	'foren'
145	title	0	3	 foren 	'foren'
202	slug	0	2		
202	title	0	2	 44 	'44'
203	filename	0	1	 56 jpg 	'56' 'jpg'
203	extension	0	1	 jpg 	'jpg'
203	kind	0	1	 image 	'image'
203	slug	0	1		
203	title	0	1	 56 	'56'
203	filename	0	2	 56 jpg 	'56' 'jpg'
203	extension	0	2	 jpg 	'jpg'
203	kind	0	2	 image 	'image'
203	slug	0	2		
203	title	0	2	 56 	'56'
163	slug	0	2	 themengebiete 	'themengebiete'
163	title	0	2	 themengebiete 	'themengebiete'
163	slug	0	1	 themengebiete 	'themengebiete'
163	title	0	1	 themengebiete 	'themengebiete'
165	slug	0	2	 automobilindustrie und zulieferer 	'automobilindustrie' 'und' 'zulieferer'
165	title	0	2	 automobilindustrie und zulieferer 	'automobilindustrie' 'und' 'zulieferer'
165	slug	0	1	 automobilindustrie und zulieferer 	'automobilindustrie' 'und' 'zulieferer'
165	title	0	1	 automobilindustrie und zulieferer 	'automobilindustrie' 'und' 'zulieferer'
167	slug	0	2	 feinmechanik und optik 	'feinmechanik' 'optik' 'und'
167	title	0	2	 feinmechanik und optik 	'feinmechanik' 'optik' 'und'
167	slug	0	1	 feinmechanik und optik 	'feinmechanik' 'optik' 'und'
167	title	0	1	 feinmechanik und optik 	'feinmechanik' 'optik' 'und'
169	slug	0	2	 moderator 	'moderator'
169	title	0	2	 moderator 	'moderator'
169	slug	0	1	 moderator 	'moderator'
169	title	0	1	 moderator 	'moderator'
171	slug	0	2	 anprechpartner 	'anprechpartner'
171	title	0	2	 anprechpartner 	'anprechpartner'
171	slug	0	1	 anprechpartner 	'anprechpartner'
171	title	0	1	 anprechpartner 	'anprechpartner'
173	slug	0	2	 messe team 	'messe' 'team'
173	title	0	2	 messe team 	'messe' 'team'
173	slug	0	1	 messe team 	'messe' 'team'
173	title	0	1	 messe team 	'messe' 'team'
204	filename	0	1	 89 jpg 	'89' 'jpg'
204	extension	0	1	 jpg 	'jpg'
204	kind	0	1	 image 	'image'
204	slug	0	1		
204	title	0	1	 89 	'89'
204	filename	0	2	 89 jpg 	'89' 'jpg'
177	slug	0	2	 presse 	'presse'
177	title	0	2	 presse 	'presse'
177	slug	0	1	 presse 	'presse'
177	title	0	1	 presse 	'presse'
204	extension	0	2	 jpg 	'jpg'
204	kind	0	2	 image 	'image'
180	slug	0	2	 schieblehre 	'schieblehre'
180	title	0	2	 schieblehre 	'schieblehre'
180	slug	0	1	 schieblehre 	'schieblehre'
180	title	0	1	 schieblehre 	'schieblehre'
181	slug	0	2	 emo news 	'emo' 'news'
181	title	0	2	 emo news 	'emo' 'news'
181	slug	0	1	 emo news 	'emo' 'news'
181	title	0	1	 emo news 	'emo' 'news'
204	slug	0	2		
204	title	0	2	 89 	'89'
138	slug	0	2	 target groups 	'groups' 'target'
138	title	0	2	 target groups 	'groups' 'target'
138	slug	0	1	 zielgruppen 	'zielgruppen'
138	title	0	1	 zielgruppen 	'zielgruppen'
138	slug	0	3	 zielgruppen 	'zielgruppen'
138	title	0	3	 zielgruppen 	'zielgruppen'
200	filename	0	1	 9 jpg 	'9' 'jpg'
140	slug	0	1	 besucher 	'besucher'
140	title	0	1	 besucher 	'besucher'
140	slug	0	2	 besucher 	'besucher'
140	title	0	2	 besucher 	'besucher'
140	slug	0	3	 besucher 	'besucher'
140	title	0	3	 besucher 	'besucher'
200	extension	0	1	 jpg 	'jpg'
200	kind	0	1	 image 	'image'
200	slug	0	1		
200	title	0	1	 9 	'9'
142	slug	0	1	 dienstleister 	'dienstleister'
142	title	0	1	 dienstleister 	'dienstleister'
142	slug	0	2	 dienstleister 	'dienstleister'
142	title	0	2	 dienstleister 	'dienstleister'
142	slug	0	3	 dienstleister 	'dienstleister'
142	title	0	3	 dienstleister 	'dienstleister'
200	filename	0	2	 9 jpg 	'9' 'jpg'
200	extension	0	2	 jpg 	'jpg'
200	kind	0	2	 image 	'image'
200	slug	0	2		
144	slug	0	1	 konferrenz 	'konferrenz'
144	title	0	1	 konferrenz 	'konferrenz'
144	slug	0	2	 konferrenz 	'konferrenz'
144	title	0	2	 konferrenz 	'konferrenz'
144	slug	0	3	 konferrenz 	'konferrenz'
144	title	0	3	 konferrenz 	'konferrenz'
200	title	0	2	 9 	'9'
146	slug	0	1	 sonderschau 	'sonderschau'
146	title	0	1	 sonderschau 	'sonderschau'
146	slug	0	2	 sonderschau 	'sonderschau'
146	title	0	2	 sonderschau 	'sonderschau'
146	slug	0	3	 sonderschau 	'sonderschau'
146	title	0	3	 sonderschau 	'sonderschau'
164	slug	0	2	 elektrotechnik und elektronik 	'elektronik' 'elektrotechnik' 'und'
164	title	0	2	 elektrotechnik und elektronik 	'elektronik' 'elektrotechnik' 'und'
164	slug	0	1	 elektrotechnik und elektronik 	'elektronik' 'elektrotechnik' 'und'
164	title	0	1	 elektrotechnik und elektronik 	'elektronik' 'elektrotechnik' 'und'
166	slug	0	2	 bearbeitung und verarbeitung neuer werkstoffe 	'bearbeitung' 'neuer' 'und' 'verarbeitung' 'werkstoffe'
166	title	0	2	 bearbeitung und verarbeitung neuer werkstoffe 	'bearbeitung' 'neuer' 'und' 'verarbeitung' 'werkstoffe'
166	slug	0	1	 bearbeitung und verarbeitung neuer werkstoffe 	'bearbeitung' 'neuer' 'und' 'verarbeitung' 'werkstoffe'
166	title	0	1	 bearbeitung und verarbeitung neuer werkstoffe 	'bearbeitung' 'neuer' 'und' 'verarbeitung' 'werkstoffe'
168	slug	0	2	 persona 	'persona'
168	title	0	2	 persona 	'persona'
168	slug	0	1	 persona 	'persona'
168	title	0	1	 persona 	'persona'
170	slug	0	2	 speaker 	'speaker'
170	title	0	2	 speaker 	'speaker'
170	slug	0	1	 speaker 	'speaker'
170	title	0	1	 speaker 	'speaker'
172	slug	0	2	 redakteur 	'redakteur'
172	title	0	2	 redakteur 	'redakteur'
172	slug	0	1	 redakteur 	'redakteur'
172	title	0	1	 redakteur 	'redakteur'
211	slug	0	1	 craft graphql mutations 	'craft' 'graphql' 'mutations'
211	title	0	1	 asdsa updated 	'asdsa' 'updated'
211	slug	0	2	 craft graphql mutations 	'craft' 'graphql' 'mutations'
211	title	0	2	 asdsa updated 	'asdsa' 'updated'
197	slug	0	2	 drehmaschinen 	'drehmaschinen'
197	title	0	2	 drehmaschinen 	'drehmaschinen'
197	slug	0	1	 drehmaschinen 	'drehmaschinen'
197	title	0	1	 drehmaschinen 	'drehmaschinen'
\.


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sections (id, "structureId", name, handle, type, "enableVersioning", "propagationMethod", "previewTargets", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
6	\N	Downloads & Medien	downloads	channel	f	all	[{"label":"Primäre eintrag Seite","urlFormat":"{url}","refresh":"1"}]	2021-01-25 15:00:30	2021-01-25 15:00:30	\N	f65cbcf7-3ede-40b8-b09e-b3a8e1a4674c
7	\N	Personen	persons	channel	t	all	[{"label":"Primäre eintrag Seite","urlFormat":"{url}","refresh":"1"}]	2021-01-25 15:30:00	2021-01-25 15:30:00	\N	0daaa545-d1a0-4655-a507-2bac8b560f1d
8	\N	Artikelbeitrag	articles	channel	t	all	[{"label":"Primäre eintrag Seite","urlFormat":"{url}","refresh":"1"}]	2021-01-25 16:24:39	2021-01-25 16:31:13	\N	9b5bd243-bb29-4fea-81a4-e597852129b7
4	\N	Informationsseite	pages	channel	t	none	[{"label":"Primäre eintrag Seite","urlFormat":"/p/preview/{slug}","refresh":"1"}]	2021-01-22 14:48:20	2021-01-25 16:31:16	\N	ea25caf0-a9ce-415f-91f4-7c047d9b1933
9	\N	Veranstaltungen	events	channel	t	all	[{"label":"Primäre eintrag Seite","urlFormat":"{url}","refresh":"1"}]	2021-01-25 16:56:45	2021-01-25 16:56:45	\N	06745480-8d8c-4976-934e-dc80b2ab5632
10	\N	Aussteller	exhibitors	channel	f	all	[{"label":"Primäre eintrag Seite","urlFormat":"{url}","refresh":"1"}]	2021-01-27 13:24:47	2021-01-27 13:24:47	\N	1b0aae41-58ef-4c4b-8749-6e8a8c98221d
11	\N	Produkte	products	channel	f	all	[{"label":"Primäre eintrag Seite","urlFormat":"{url}","refresh":"1"}]	2021-01-27 15:06:55	2021-01-27 15:06:55	\N	2a038e37-6c48-4746-8b6d-b27fabf7972f
\.


--
-- Data for Name: sections_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sections_sites (id, "sectionId", "siteId", "hasUrls", "uriFormat", template, "enabledByDefault", "dateCreated", "dateUpdated", uid) FROM stdin;
7	4	2	t	p/{slug}	\N	t	2021-01-22 14:48:20	2021-01-22 14:48:20	0e1641aa-5b69-4207-b635-e2f3fa594834
8	4	1	t	p/{slug}	\N	t	2021-01-22 14:48:20	2021-01-22 14:48:20	a5cd9115-cfd5-4d32-bfe3-271948d00ab5
11	6	2	t	downloads-medien/{slug}	\N	t	2021-01-25 15:00:30	2021-01-25 15:00:30	93a7d709-fd74-40bf-9467-2c6a39faa70c
12	6	1	t	downloads-medien/{slug}	\N	t	2021-01-25 15:00:30	2021-01-25 15:00:30	4367cd3f-ee90-474e-8f29-62b417d88cc1
13	7	2	t	personen/{slug}	\N	t	2021-01-25 15:30:00	2021-01-25 15:30:00	5b25921e-0cec-4941-b703-da861da00d82
14	7	1	t	personen/{slug}	\N	t	2021-01-25 15:30:00	2021-01-25 15:30:00	005c8903-3715-4300-8da8-0e1fe7611a2b
15	8	2	t	a/{slug}	\N	t	2021-01-25 16:24:39	2021-01-25 16:24:39	68b00125-a42e-4ce9-be0e-02989545c84a
16	8	1	t	a/{slug}	\N	t	2021-01-25 16:24:39	2021-01-25 16:24:39	b055db6f-a430-42af-ab6e-264d9f7b0e42
17	9	2	t	events/{slug}	\N	t	2021-01-25 16:56:45	2021-01-25 16:56:45	0fab1673-8eca-4799-a369-2caec1e34fcb
18	9	1	t	events/{slug}	\N	t	2021-01-25 16:56:45	2021-01-25 16:56:45	604beee2-2519-46d0-9a1a-86cfe290ca24
19	10	2	t	exhibitors/{slug}	\N	t	2021-01-27 13:24:47	2021-01-27 13:24:47	9b0650a0-4283-4be6-9fa5-deeeb6671f48
20	10	1	t	aussteller/{slug}	\N	t	2021-01-27 13:24:47	2021-01-27 13:24:47	19619c8e-97f1-4fa8-8dd0-559072cd2f67
21	11	2	t	products/{slug}	\N	t	2021-01-27 15:06:55	2021-01-27 15:06:55	c5e5c8fe-59f0-492a-82dc-d91996625a19
22	11	1	t	produkte/{slug}	\N	t	2021-01-27 15:06:55	2021-01-27 15:06:55	0a60ec2a-3c01-4d6a-9dc5-8dfa596f9ff0
\.


--
-- Data for Name: sequences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sequences (name, next) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, "userId", token, "dateCreated", "dateUpdated", uid) FROM stdin;
48	16	ngfO_mpL81kXQAshPJRu2IzuzQrCtq2T_y61HXsp7SQUlCAwIF0T1nAT8WdGod_w7rVnvP9n-qM_veLPlF9M5tkw1defsQiHCjWB	2021-01-29 14:36:09	2021-01-29 16:48:49	3f54e9c0-d6d6-4c5c-a7ed-82f29cd8f6b8
1	1	xOBzKkf-fO6eVwECqS0hteY6IEvIHiKCJC5Ksd2TzVM-D3skxFDmbOS6wmOuNgRl6QOyFk8aK-UNg4hWROEoBMe-n-3pzkZ5rf_U	2020-11-25 10:32:44	2020-11-25 10:35:30	61d8f933-786f-45b3-a267-395b9e8f5be7
36	16	YvlkzLBSeGLdZavVQiPqrgBLv7A6yAdFJQT36FtRa8UD27iA1Z-TJzD3paKW57lL-UhquvPemklwowm9DirxM3HOaMGv_VzbV50-	2021-01-18 15:08:02	2021-01-18 15:20:53	475b3539-43b4-4dd6-8a0d-a899d334f7bf
37	16	sME0ehpPjpBtYwx_gVUvWrTX34O4FYAlWZpq-r_WjWjE1OFdOqr71YfTIkPDoTObqhop7gBerMZ90mBCD7J8IbidrDSIBwuEWNIF	2021-01-18 15:20:54	2021-01-18 15:20:54	881734cc-c64e-4ceb-9b94-1d0f7867c2e5
40	16	v7YnJIwm4vPhNesaTMKEkQMx1vjiabm3IkdNd129fLJeowwm4xZgduuIsQ2q48uBj8S2tvB1gNRPLOP77lvv0KpKgthThq2eiGU_	2021-01-22 13:54:42	2021-01-22 16:47:05	bb839b16-3456-47a1-8905-5093e97a5349
49	16	Dz0WgNYAtv_xeTbcuc-a5pI8ens3B4AWlqW7EbnqBRfjTcPGJOKKDIiFIPL8FtzI3VLKKx_iK-q1y90u_FZXMMibgjvR6ykLbu03	2021-02-01 15:24:35	2021-02-01 16:02:06	92375d9a-994e-430e-9a56-e865194d36e1
45	16	GMgwpr0-jglHgyws_PORfkJqyMP_NG3J9gdCoypoCTqOpfwm0axi-henNWogtlJQIZymB9-14lylli_reLKi_3dlfIOIIyB9wmzX	2021-01-27 16:35:43	2021-01-27 17:12:32	01beb0be-c60b-448a-8ad0-fb75c5dd533e
39	16	1I9MViqwiTsqlMjiaR-aRSfvTYocETft5J5kNyGEo_prWHzxqp6UjuOpGelC67qTG2NHgCR0umAkV7CdqYWrUvMEBqLUrWBjNZEg	2021-01-18 15:29:22	2021-01-18 16:38:48	4747cb3d-13c7-45e6-a0ac-a8eba774cbaf
41	16	Ui_XIJTofYYugZ4KGYLH849uLHULQA8oE9mJAX0bN8sFS66zpfeqnlZCL_wdgyN1Xv8SkHXf8vDD-6xy8C3wVKmhYmksuDEezm9d	2021-01-25 13:43:55	2021-01-25 17:07:29	4d56003c-e2e2-44ae-a89f-f79c77a9ea9b
\.


--
-- Data for Name: shunnedmessages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shunnedmessages (id, "userId", message, "expiryDate", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: sitegroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sitegroups (id, name, "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
1	EMO	2020-11-25 10:32:42	2021-01-27 16:25:18	\N	541d1036-b8ff-48fd-b44b-f39fd928f44e
\.


--
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sites (id, "groupId", "primary", enabled, name, handle, language, "hasUrls", "baseUrl", "sortOrder", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
2	1	f	t	EMO English	emoEnglish	en	t	$EN_BASE_URL	2	2020-12-16 15:11:16	2020-12-16 15:11:16	\N	34380f2c-988a-43d1-9723-8633250a5237
1	1	t	t	EMO Deutsch	emoDeutsch	de	t	$DE_BASE_URL	1	2020-11-25 10:32:42	2020-12-16 15:12:00	\N	ff97e19b-a38b-48c6-b4a8-4ed14019ec07
\.


--
-- Data for Name: structureelements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.structureelements (id, "structureId", "elementId", root, lft, rgt, level, "dateCreated", "dateUpdated", uid) FROM stdin;
3	1	139	1	3	4	2	2021-01-22 14:36:57	2021-01-22 14:36:57	7ae6ad73-7521-4297-bab2-984109599fff
22	2	\N	22	1	18	0	2021-01-25 14:34:47	2021-01-25 14:37:04	cb5a844e-03b5-4564-b86f-d859e7ab15e9
26	2	177	22	8	9	1	2021-01-25 14:34:55	2021-01-25 14:37:04	e2844d42-2603-479b-8099-aa4b494f4162
12	1	164	1	21	22	2	2021-01-25 14:32:52	2021-01-25 14:33:10	8c5474d9-754e-49d9-b291-0b1a5a72f65f
27	2	178	22	10	11	1	2021-01-25 14:34:58	2021-01-25 14:37:04	32dacaac-f844-4833-9c6d-85b226ebc458
28	2	179	22	12	13	1	2021-01-25 14:35:01	2021-01-25 14:37:04	fe75a85a-5672-48be-9436-f0b5a5a9f0cb
29	2	180	22	14	15	1	2021-01-25 14:35:03	2021-01-25 14:37:04	3f251d3f-e805-4eed-9a0d-3acb3f36d9ae
30	2	181	22	16	17	1	2021-01-25 14:35:08	2021-01-25 14:37:04	aa1ec3a2-0635-410c-aafd-88cb58309eb5
25	2	176	22	6	7	1	2021-01-25 14:34:52	2021-01-25 14:37:04	3299e7a7-fc77-4dbb-9152-a616a7b83c3b
24	2	175	22	4	5	1	2021-01-25 14:34:50	2021-01-25 14:37:04	2b9d04f0-a449-4203-a949-3cf3fb7ccc1c
31	3	\N	31	1	4	0	2021-01-27 15:42:26	2021-01-27 15:42:26	2e78c862-e1bc-4ba3-877e-9089e0b4f245
32	3	197	31	2	3	1	2021-01-27 15:42:26	2021-01-27 15:42:26	77dd9c83-263f-4fcd-b04c-456aab342d14
13	1	165	1	23	24	2	2021-01-25 14:32:55	2021-01-25 14:33:11	6fdd85c3-c79b-47ea-a4e9-9f773ebc1d44
14	1	166	1	25	26	2	2021-01-25 14:32:59	2021-01-25 14:33:12	2cc40099-ce8b-453b-b95e-24dcd3949b6f
11	1	163	1	20	29	1	2021-01-25 14:32:38	2021-01-25 14:33:13	4f1e1c1a-7c75-4a7a-b8b6-dbc01653ce70
15	1	167	1	27	28	2	2021-01-25 14:33:02	2021-01-25 14:33:13	d8c7bdd8-20cc-4591-b637-a859da270cdc
17	1	169	1	31	32	2	2021-01-25 14:33:21	2021-01-25 14:33:40	35ad3ce0-9ca9-4ed8-a9a7-cdad33d109cb
23	2	174	22	2	3	1	2021-01-25 14:34:47	2021-01-25 14:37:02	f29e844e-59ac-4c18-8d8f-fa0ed04ce866
18	1	170	1	33	34	2	2021-01-25 14:33:25	2021-01-25 14:33:42	bdcb92f3-4762-4175-b059-33ff4ce30f11
19	1	171	1	35	36	2	2021-01-25 14:33:28	2021-01-25 14:33:43	40d76ac8-c8e0-493d-b947-8f82da7f613f
20	1	172	1	37	38	2	2021-01-25 14:33:30	2021-01-25 14:33:44	1dff34b1-97d3-4e85-a63a-dabd79f5599f
16	1	168	1	30	41	1	2021-01-25 14:33:18	2021-01-25 14:33:45	10017524-3e84-4530-bb0d-d6412a5762e5
21	1	173	1	39	40	2	2021-01-25 14:33:33	2021-01-25 14:33:45	c9a0dab6-b52b-43be-940f-400830351a0d
5	1	141	1	7	8	2	2021-01-22 14:37:36	2021-01-22 14:38:49	72d94104-dd52-4e24-9732-5fc7621ea49a
1	1	\N	1	1	42	0	2021-01-22 14:35:35	2021-01-25 14:33:45	3731ae7c-a296-47c2-9520-8f1a4b61f911
4	1	140	1	5	6	2	2021-01-22 14:37:31	2021-01-22 14:38:49	df698754-ff36-4339-85aa-60452efa4c1c
2	1	138	1	2	11	1	2021-01-22 14:35:35	2021-01-22 14:38:55	6237f673-d788-4f89-8d95-41d407d0ad8a
8	1	144	1	13	14	2	2021-01-22 14:37:54	2021-01-22 14:38:55	8b6f48c3-e616-4a46-8852-563652768a61
9	1	145	1	15	16	2	2021-01-22 14:37:57	2021-01-22 14:38:55	c594b7b9-5223-4425-8540-5c349ea2ae36
7	1	143	1	12	19	1	2021-01-22 14:37:51	2021-01-22 14:38:55	e7c01fc5-ba29-4cb9-a561-149c48e69ba7
10	1	146	1	17	18	2	2021-01-22 14:38:01	2021-01-22 14:38:55	ff431c16-8062-4dc3-9909-aeea65008d24
6	1	142	1	9	10	2	2021-01-22 14:37:42	2021-01-22 14:38:55	a5e020aa-e09d-4814-a3fd-a2c8de6d9c50
\.


--
-- Data for Name: structures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.structures (id, "maxLevels", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
1	2	2021-01-22 14:35:05	2021-01-22 14:35:05	\N	cee94a14-2190-4dc1-a129-1ccafd44ed14
2	1	2021-01-25 14:34:23	2021-01-25 14:36:53	\N	8a65445b-9e49-450e-a60e-190e1b0b5de8
3	2	2021-01-27 15:40:44	2021-01-27 15:40:44	\N	6ce3fefa-8060-4e69-8df4-0e550b537554
\.


--
-- Data for Name: systemmessages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.systemmessages (id, language, key, subject, body, "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: taggroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taggroups (id, name, handle, "fieldLayoutId", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, "groupId", "deletedWithGroup", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: templatecacheelements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.templatecacheelements (id, "cacheId", "elementId") FROM stdin;
\.


--
-- Data for Name: templatecachequeries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.templatecachequeries (id, "cacheId", type, query) FROM stdin;
\.


--
-- Data for Name: templatecaches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.templatecaches (id, "siteId", "cacheKey", path, "expiryDate", body) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tokens (id, token, route, "usageLimit", "usageCount", "expiryDate", "dateCreated", "dateUpdated", uid) FROM stdin;
11	pKYvsLb4cSjfNTbic1lYVdjO6vLJizTL	["preview/preview",{"elementType":"craft\\\\elements\\\\Entry","sourceId":44,"siteId":1,"draftId":null,"revisionId":null}]	\N	\N	2020-12-17 08:42:44	2020-12-16 08:42:44	2020-12-16 08:42:44	a90b45e6-6b71-44f4-8e9d-3a2762a1b463
12	FTGEV2FHbViDUJHszLXjcixEYlEtcM6y	["preview/preview",{"elementType":"craft\\\\elements\\\\Entry","sourceId":44,"siteId":1,"draftId":10,"revisionId":null}]	\N	\N	2020-12-17 08:50:21	2020-12-16 08:50:21	2020-12-16 08:50:21	41e235a8-9428-4b1a-9507-3e1a3a4226d2
13	cZy0pBnv6hWSr_Mgxp1mM-RxyiwFcG4y	["preview/preview",{"elementType":"craft\\\\elements\\\\Entry","sourceId":44,"siteId":1,"draftId":10,"revisionId":null}]	\N	\N	2020-12-17 09:09:58	2020-12-16 09:09:58	2020-12-16 09:09:58	d1b5fe6a-78ca-4caf-a106-aebe7d4cdc8d
14	98d6ly3XdvC3SQfVyK-kFpVQZHqhmgKq	["preview/preview",{"elementType":"craft\\\\elements\\\\Entry","sourceId":44,"siteId":1,"draftId":10,"revisionId":null}]	\N	\N	2020-12-17 13:56:54	2020-12-16 13:56:54	2020-12-16 13:56:54	bd21c3b4-27e5-44ad-a628-082567f5376a
\.


--
-- Data for Name: usergroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usergroups (id, name, handle, description, "dateCreated", "dateUpdated", uid) FROM stdin;
1	Registriert	registered	Start Benutzergruppe nach einer Registrierung	2020-11-30 12:01:44	2020-11-30 12:01:44	b3ebc429-1aaf-4077-9b55-732d13785f99
2	Redakteure	redactor		2020-12-09 11:43:44	2020-12-09 11:43:44	0144de20-93d5-432d-ba93-f08f4a599148
\.


--
-- Data for Name: usergroups_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usergroups_users (id, "groupId", "userId", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: userpermissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userpermissions (id, name, "dateCreated", "dateUpdated", uid) FROM stdin;
1	accesscp	2020-11-30 14:45:38	2020-11-30 14:45:38	0af6ae1b-0e9b-43a1-8093-cb1cf13337f8
\.


--
-- Data for Name: userpermissions_usergroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userpermissions_usergroups (id, "permissionId", "groupId", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: userpermissions_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userpermissions_users (id, "permissionId", "userId", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: userpreferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userpreferences ("userId", preferences) FROM stdin;
1	{"language":"de","locale":null,"weekStartDay":null,"useShapes":false,"underlineLinks":false,"showFieldHandles":false,"enableDebugToolbarForSite":false,"enableDebugToolbarForCp":false,"showExceptionView":false,"profileTemplates":false}
16	{"language":"de","locale":null,"weekStartDay":"1","useShapes":false,"underlineLinks":false,"showFieldHandles":true,"enableDebugToolbarForSite":true,"enableDebugToolbarForCp":true,"showExceptionView":true,"profileTemplates":true}
206	{"language":null,"locale":null,"weekStartDay":null,"useShapes":false,"underlineLinks":false,"showFieldHandles":false,"enableDebugToolbarForSite":false,"enableDebugToolbarForCp":false,"showExceptionView":false,"profileTemplates":false}
207	{"language":null,"locale":null,"weekStartDay":null,"useShapes":false,"underlineLinks":false,"showFieldHandles":false,"enableDebugToolbarForSite":false,"enableDebugToolbarForCp":false,"showExceptionView":false,"profileTemplates":false}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, "photoId", "firstName", "lastName", email, password, admin, locked, suspended, pending, "lastLoginDate", "lastLoginAttemptIp", "invalidLoginWindowStart", "invalidLoginCount", "lastInvalidLoginDate", "lockoutDate", "hasDashboard", "verificationCode", "verificationCodeIssuedDate", "unverifiedEmail", "passwordResetRequired", "lastPasswordChangeDate", "dateCreated", "dateUpdated", uid) FROM stdin;
1	dev@industryarena.com	\N	Laura	Meister	dev@industryarena.com	$2y$13$abTk6ieORhAkhC89GVJWEeEetlvbUcsKZ1T.q0sv6jQ1hxkgrRkSe	t	f	f	f	2020-12-14 16:35:07	\N	2020-11-25 10:52:16	1	2020-11-25 10:52:16	\N	t	\N	\N	\N	f	2020-11-25 10:32:44	2020-11-25 10:32:44	2020-12-14 16:35:07	99eaed5c-b753-4364-9efa-7601bc916d12
206	stefan.schwaneck	\N	Stefan	Schwaneck	s.schwaneck@vdw.de	\N	t	f	f	t	\N	\N	\N	\N	\N	\N	f	$2y$13$ce.QKNXA/U/iQgh1Ah3DC.Ak4w3CAAgpqGn8HA225V44xwGLuIDtG	2021-01-29 13:25:14	s.schwaneck@vdw.de	f	\N	2021-01-29 13:25:13	2021-01-29 13:25:14	3db1a70d-6e0b-442f-b085-72a96bcfd8b7
207	sebastian.noell	\N	Sebastian	Nöll	noell@4ft.de	\N	t	f	f	t	\N	\N	\N	\N	\N	\N	f	$2y$13$zRwZD48fMTGJDIygUx0ILeiU/3WCumQ2rTsTa7gBxF9tk8YnOpdo2	2021-01-29 13:25:49	noell@4ft.de	f	\N	2021-01-29 13:25:49	2021-01-29 13:25:49	d46e5f1a-8f70-43f2-aaa3-d486bd4544fc
16	alexej.kloos	\N	Alexej	Kloos	alexej.kloos@industryarena.com	$2y$13$o4yh.kHn5t3OVg9vYzf72eF2ilhulO1ZzWjK0M.olWrOOzrBxjGj2	t	f	f	f	2021-02-01 15:24:35	\N	\N	\N	\N	\N	t	\N	\N	\N	f	2021-01-18 15:01:55	2020-11-25 10:51:51	2021-02-01 15:24:35	24affce9-7b24-4247-9d84-a1f8b95a3436
\.


--
-- Data for Name: volumefolders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.volumefolders (id, "parentId", "volumeId", name, path, "dateCreated", "dateUpdated", uid) FROM stdin;
3	\N	\N	Temporäre Quelle	\N	2020-11-25 10:38:02	2020-11-25 10:38:02	addc979a-49ce-46bf-a249-56ee893754d4
4	3	\N	user_1	user_1/	2020-11-25 10:38:02	2020-11-25 10:38:02	0d56368d-2536-4d77-aba2-021162c34d23
5	3	\N	user_16	user_16/	2020-11-25 12:11:42	2020-11-25 12:11:42	611bdd59-4103-4f64-b463-5c7dd55b2f9a
1	\N	1	Personen 2019		2020-11-25 10:32:43	2021-01-27 08:54:56	8118825a-da70-4b7e-b208-5e6bf49d6718
2	\N	2	Seiten 2019		2020-11-25 10:32:43	2021-01-27 08:56:30	dff56429-3388-4875-8fd2-ab5bd662c8b8
6	\N	3	Artikel 2019		2021-01-27 08:57:12	2021-01-27 08:57:12	84010411-4d86-4ee0-adf2-a0c6b1f82ab8
\.


--
-- Data for Name: volumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.volumes (id, "fieldLayoutId", name, handle, type, "hasUrls", url, settings, "sortOrder", "dateCreated", "dateUpdated", "dateDeleted", uid, "titleTranslationMethod", "titleTranslationKeyFormat") FROM stdin;
1	2	Personen 2019	persons_2019	craft\\volumes\\Local	t	@web/persons_2019	{"path":"@webroot/persons_2019"}	1	2020-11-25 10:32:43	2021-01-27 08:54:56	\N	24c25c8a-80ea-4d24-ad72-d168a19e07cd	site	\N
2	3	Seiten 2019	pages_2019	craft\\volumes\\Local	t	@web/pages_2019	{"path":"@webroot/pages_2019"}	2	2020-11-25 10:32:43	2021-01-27 09:07:05	\N	6d6fb726-ec98-4924-a4c4-0d5e30359a91	site	\N
3	18	Artikel 2019	article_2019	craft\\volumes\\Local	t	@web/article_2019	{"path":"@webroot/article_2019"}	3	2021-01-27 08:57:12	2021-01-27 09:17:28	\N	6ccb6428-fc6d-4868-a8e1-17eefa4bfbb7	site	\N
\.


--
-- Data for Name: widgets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.widgets (id, "userId", type, "sortOrder", colspan, settings, enabled, "dateCreated", "dateUpdated", uid) FROM stdin;
1	1	craft\\widgets\\RecentEntries	1	\N	{"siteId":1,"section":"*","limit":10}	t	2020-11-25 10:35:24	2020-11-25 10:35:24	f11c7a2a-6f8a-4757-938e-110400c619a4
2	1	craft\\widgets\\CraftSupport	2	\N	[]	t	2020-11-25 10:35:24	2020-11-25 10:35:24	62adfb95-0861-4b98-8742-6d5121daa340
3	1	craft\\widgets\\Updates	3	\N	[]	t	2020-11-25 10:35:24	2020-11-25 10:35:24	0d2184e6-242c-4d78-84ec-ff40780faf58
4	1	craft\\widgets\\Feed	4	\N	{"url":"https://craftcms.com/news.rss","title":"Craft News","limit":5}	t	2020-11-25 10:35:25	2020-11-25 10:35:25	87084524-a54f-4642-8eb3-431af7bda593
5	16	craft\\widgets\\RecentEntries	1	\N	{"siteId":1,"section":"*","limit":10}	t	2020-11-25 12:11:12	2020-11-25 12:11:12	51c322ca-fc65-4084-8967-baad12de4959
6	16	craft\\widgets\\CraftSupport	2	\N	[]	t	2020-11-25 12:11:12	2020-11-25 12:11:12	5c3fc455-ad00-4428-9ca1-bf75a0d0c57a
7	16	craft\\widgets\\Updates	3	\N	[]	t	2020-11-25 12:11:12	2020-11-25 12:11:12	26c0fcb0-e6c3-4325-8801-688f44def6d2
8	16	craft\\widgets\\Feed	4	\N	{"url":"https://craftcms.com/news.rss","title":"Craft News","limit":5}	t	2020-11-25 12:11:12	2020-11-25 12:11:12	cf22ffcb-0f30-432a-89c5-ee4d045b7ce1
\.


--
-- Name: assetindexdata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assetindexdata_id_seq', 5, true);


--
-- Name: assettransformindex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assettransformindex_id_seq', 1, false);


--
-- Name: assettransforms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assettransforms_id_seq', 1, false);


--
-- Name: categorygroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorygroups_id_seq', 3, true);


--
-- Name: categorygroups_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorygroups_sites_id_seq', 7, true);


--
-- Name: content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.content_id_seq', 303, true);


--
-- Name: craftidtokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.craftidtokens_id_seq', 1, true);


--
-- Name: deprecationerrors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deprecationerrors_id_seq', 1, false);


--
-- Name: drafts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.drafts_id_seq', 41, true);


--
-- Name: elementindexsettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.elementindexsettings_id_seq', 21, true);


--
-- Name: elements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.elements_id_seq', 212, true);


--
-- Name: elements_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.elements_sites_id_seq', 365, true);


--
-- Name: entrytypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entrytypes_id_seq', 13, true);


--
-- Name: fieldgroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fieldgroups_id_seq', 15, true);


--
-- Name: fieldlayoutfields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fieldlayoutfields_id_seq', 457, true);


--
-- Name: fieldlayouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fieldlayouts_id_seq', 22, true);


--
-- Name: fieldlayouttabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fieldlayouttabs_id_seq', 135, true);


--
-- Name: fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fields_id_seq', 53, true);


--
-- Name: globalsets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.globalsets_id_seq', 1, false);


--
-- Name: gqlschemas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gqlschemas_id_seq', 5, true);


--
-- Name: gqltokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gqltokens_id_seq', 75, true);


--
-- Name: info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.info_id_seq', 1, false);


--
-- Name: matrixblocktypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.matrixblocktypes_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 182, true);


--
-- Name: plugins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plugins_id_seq', 4, true);


--
-- Name: queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.queue_id_seq', 446, true);


--
-- Name: relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.relations_id_seq', 113, true);


--
-- Name: revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.revisions_id_seq', 33, true);


--
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sections_id_seq', 11, true);


--
-- Name: sections_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sections_sites_id_seq', 22, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sessions_id_seq', 49, true);


--
-- Name: shunnedmessages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shunnedmessages_id_seq', 1, false);


--
-- Name: sitegroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sitegroups_id_seq', 1, true);


--
-- Name: sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sites_id_seq', 3, true);


--
-- Name: structureelements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.structureelements_id_seq', 32, true);


--
-- Name: structures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.structures_id_seq', 3, true);


--
-- Name: systemmessages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.systemmessages_id_seq', 1, false);


--
-- Name: taggroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taggroups_id_seq', 2, true);


--
-- Name: templatecacheelements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.templatecacheelements_id_seq', 1, false);


--
-- Name: templatecachequeries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.templatecachequeries_id_seq', 1, false);


--
-- Name: templatecaches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.templatecaches_id_seq', 1, false);


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tokens_id_seq', 14, true);


--
-- Name: usergroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usergroups_id_seq', 2, true);


--
-- Name: usergroups_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usergroups_users_id_seq', 2, true);


--
-- Name: userpermissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userpermissions_id_seq', 1, true);


--
-- Name: userpermissions_usergroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userpermissions_usergroups_id_seq', 1, false);


--
-- Name: userpermissions_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userpermissions_users_id_seq', 52, true);


--
-- Name: userpreferences_userId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."userpreferences_userId_seq"', 1, false);


--
-- Name: volumefolders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.volumefolders_id_seq', 6, true);


--
-- Name: volumes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.volumes_id_seq', 3, true);


--
-- Name: widgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.widgets_id_seq', 8, true);


--
-- Name: assetindexdata assetindexdata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assetindexdata
    ADD CONSTRAINT assetindexdata_pkey PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: assettransformindex assettransformindex_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assettransformindex
    ADD CONSTRAINT assettransformindex_pkey PRIMARY KEY (id);


--
-- Name: assettransforms assettransforms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assettransforms
    ADD CONSTRAINT assettransforms_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categorygroups categorygroups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorygroups
    ADD CONSTRAINT categorygroups_pkey PRIMARY KEY (id);


--
-- Name: categorygroups_sites categorygroups_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorygroups_sites
    ADD CONSTRAINT categorygroups_sites_pkey PRIMARY KEY (id);


--
-- Name: changedattributes changedattributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changedattributes
    ADD CONSTRAINT changedattributes_pkey PRIMARY KEY ("elementId", "siteId", attribute);


--
-- Name: changedfields changedfields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT changedfields_pkey PRIMARY KEY ("elementId", "siteId", "fieldId");


--
-- Name: content content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_pkey PRIMARY KEY (id);


--
-- Name: craftidtokens craftidtokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.craftidtokens
    ADD CONSTRAINT craftidtokens_pkey PRIMARY KEY (id);


--
-- Name: deprecationerrors deprecationerrors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deprecationerrors
    ADD CONSTRAINT deprecationerrors_pkey PRIMARY KEY (id);


--
-- Name: drafts drafts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT drafts_pkey PRIMARY KEY (id);


--
-- Name: elementindexsettings elementindexsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elementindexsettings
    ADD CONSTRAINT elementindexsettings_pkey PRIMARY KEY (id);


--
-- Name: elements elements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_pkey PRIMARY KEY (id);


--
-- Name: elements_sites elements_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements_sites
    ADD CONSTRAINT elements_sites_pkey PRIMARY KEY (id);


--
-- Name: entries entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT entries_pkey PRIMARY KEY (id);


--
-- Name: entrytypes entrytypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrytypes
    ADD CONSTRAINT entrytypes_pkey PRIMARY KEY (id);


--
-- Name: fieldgroups fieldgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldgroups
    ADD CONSTRAINT fieldgroups_pkey PRIMARY KEY (id);


--
-- Name: fieldlayoutfields fieldlayoutfields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayoutfields
    ADD CONSTRAINT fieldlayoutfields_pkey PRIMARY KEY (id);


--
-- Name: fieldlayouts fieldlayouts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayouts
    ADD CONSTRAINT fieldlayouts_pkey PRIMARY KEY (id);


--
-- Name: fieldlayouttabs fieldlayouttabs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayouttabs
    ADD CONSTRAINT fieldlayouttabs_pkey PRIMARY KEY (id);


--
-- Name: fields fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);


--
-- Name: globalsets globalsets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.globalsets
    ADD CONSTRAINT globalsets_pkey PRIMARY KEY (id);


--
-- Name: gqlschemas gqlschemas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gqlschemas
    ADD CONSTRAINT gqlschemas_pkey PRIMARY KEY (id);


--
-- Name: gqltokens gqltokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gqltokens
    ADD CONSTRAINT gqltokens_pkey PRIMARY KEY (id);


--
-- Name: info info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.info
    ADD CONSTRAINT info_pkey PRIMARY KEY (id);


--
-- Name: matrixblocks matrixblocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT matrixblocks_pkey PRIMARY KEY (id);


--
-- Name: matrixblocktypes matrixblocktypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matrixblocktypes
    ADD CONSTRAINT matrixblocktypes_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: plugins plugins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_pkey PRIMARY KEY (id);


--
-- Name: projectconfig projectconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectconfig
    ADD CONSTRAINT projectconfig_pkey PRIMARY KEY (path);


--
-- Name: queue queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.queue
    ADD CONSTRAINT queue_pkey PRIMARY KEY (id);


--
-- Name: relations relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT relations_pkey PRIMARY KEY (id);


--
-- Name: resourcepaths resourcepaths_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resourcepaths
    ADD CONSTRAINT resourcepaths_pkey PRIMARY KEY (hash);


--
-- Name: revisions revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT revisions_pkey PRIMARY KEY (id);


--
-- Name: searchindex searchindex_elementId_attribute_fieldId_siteId_unq_idx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.searchindex
    ADD CONSTRAINT "searchindex_elementId_attribute_fieldId_siteId_unq_idx" PRIMARY KEY ("elementId", attribute, "fieldId", "siteId");


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: sections_sites sections_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections_sites
    ADD CONSTRAINT sections_sites_pkey PRIMARY KEY (id);


--
-- Name: sequences sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sequences
    ADD CONSTRAINT sequences_pkey PRIMARY KEY (name);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: shunnedmessages shunnedmessages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shunnedmessages
    ADD CONSTRAINT shunnedmessages_pkey PRIMARY KEY (id);


--
-- Name: sitegroups sitegroups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sitegroups
    ADD CONSTRAINT sitegroups_pkey PRIMARY KEY (id);


--
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);


--
-- Name: structureelements structureelements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structureelements
    ADD CONSTRAINT structureelements_pkey PRIMARY KEY (id);


--
-- Name: structures structures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structures
    ADD CONSTRAINT structures_pkey PRIMARY KEY (id);


--
-- Name: systemmessages systemmessages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systemmessages
    ADD CONSTRAINT systemmessages_pkey PRIMARY KEY (id);


--
-- Name: taggroups taggroups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taggroups
    ADD CONSTRAINT taggroups_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: templatecacheelements templatecacheelements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecacheelements
    ADD CONSTRAINT templatecacheelements_pkey PRIMARY KEY (id);


--
-- Name: templatecachequeries templatecachequeries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecachequeries
    ADD CONSTRAINT templatecachequeries_pkey PRIMARY KEY (id);


--
-- Name: templatecaches templatecaches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecaches
    ADD CONSTRAINT templatecaches_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: usergroups usergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_pkey PRIMARY KEY (id);


--
-- Name: usergroups_users usergroups_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroups_users
    ADD CONSTRAINT usergroups_users_pkey PRIMARY KEY (id);


--
-- Name: userpermissions userpermissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions
    ADD CONSTRAINT userpermissions_pkey PRIMARY KEY (id);


--
-- Name: userpermissions_usergroups userpermissions_usergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions_usergroups
    ADD CONSTRAINT userpermissions_usergroups_pkey PRIMARY KEY (id);


--
-- Name: userpermissions_users userpermissions_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions_users
    ADD CONSTRAINT userpermissions_users_pkey PRIMARY KEY (id);


--
-- Name: userpreferences userpreferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpreferences
    ADD CONSTRAINT userpreferences_pkey PRIMARY KEY ("userId");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: volumefolders volumefolders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volumefolders
    ADD CONSTRAINT volumefolders_pkey PRIMARY KEY (id);


--
-- Name: volumes volumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volumes
    ADD CONSTRAINT volumes_pkey PRIMARY KEY (id);


--
-- Name: widgets widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.widgets
    ADD CONSTRAINT widgets_pkey PRIMARY KEY (id);


--
-- Name: assetindexdata_sessionId_volumeId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "assetindexdata_sessionId_volumeId_idx" ON public.assetindexdata USING btree ("sessionId", "volumeId");


--
-- Name: assetindexdata_volumeId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "assetindexdata_volumeId_idx" ON public.assetindexdata USING btree ("volumeId");


--
-- Name: assets_filename_folderId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "assets_filename_folderId_idx" ON public.assets USING btree (filename, "folderId");


--
-- Name: assets_folderId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "assets_folderId_idx" ON public.assets USING btree ("folderId");


--
-- Name: assets_volumeId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "assets_volumeId_idx" ON public.assets USING btree ("volumeId");


--
-- Name: assettransformindex_volumeId_assetId_location_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "assettransformindex_volumeId_assetId_location_idx" ON public.assettransformindex USING btree ("volumeId", "assetId", location);


--
-- Name: assettransforms_handle_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX assettransforms_handle_idx ON public.assettransforms USING btree (handle);


--
-- Name: assettransforms_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX assettransforms_name_idx ON public.assettransforms USING btree (name);


--
-- Name: categories_groupId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "categories_groupId_idx" ON public.categories USING btree ("groupId");


--
-- Name: categorygroups_dateDeleted_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "categorygroups_dateDeleted_idx" ON public.categorygroups USING btree ("dateDeleted");


--
-- Name: categorygroups_fieldLayoutId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "categorygroups_fieldLayoutId_idx" ON public.categorygroups USING btree ("fieldLayoutId");


--
-- Name: categorygroups_handle_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX categorygroups_handle_idx ON public.categorygroups USING btree (handle);


--
-- Name: categorygroups_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX categorygroups_name_idx ON public.categorygroups USING btree (name);


--
-- Name: categorygroups_sites_groupId_siteId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "categorygroups_sites_groupId_siteId_unq_idx" ON public.categorygroups_sites USING btree ("groupId", "siteId");


--
-- Name: categorygroups_sites_siteId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "categorygroups_sites_siteId_idx" ON public.categorygroups_sites USING btree ("siteId");


--
-- Name: categorygroups_structureId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "categorygroups_structureId_idx" ON public.categorygroups USING btree ("structureId");


--
-- Name: changedattributes_elementId_siteId_dateUpdated_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "changedattributes_elementId_siteId_dateUpdated_idx" ON public.changedattributes USING btree ("elementId", "siteId", "dateUpdated");


--
-- Name: changedfields_elementId_siteId_dateUpdated_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "changedfields_elementId_siteId_dateUpdated_idx" ON public.changedfields USING btree ("elementId", "siteId", "dateUpdated");


--
-- Name: content_elementId_siteId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "content_elementId_siteId_unq_idx" ON public.content USING btree ("elementId", "siteId");


--
-- Name: content_siteId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "content_siteId_idx" ON public.content USING btree ("siteId");


--
-- Name: content_title_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_title_idx ON public.content USING btree (title);


--
-- Name: deprecationerrors_key_fingerprint_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX deprecationerrors_key_fingerprint_unq_idx ON public.deprecationerrors USING btree (key, fingerprint);


--
-- Name: elementindexsettings_type_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX elementindexsettings_type_unq_idx ON public.elementindexsettings USING btree (type);


--
-- Name: elements_archived_dateCreated_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "elements_archived_dateCreated_idx" ON public.elements USING btree (archived, "dateCreated");


--
-- Name: elements_archived_dateDeleted_draftId_revisionId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "elements_archived_dateDeleted_draftId_revisionId_idx" ON public.elements USING btree (archived, "dateDeleted", "draftId", "revisionId");


--
-- Name: elements_dateDeleted_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "elements_dateDeleted_idx" ON public.elements USING btree ("dateDeleted");


--
-- Name: elements_enabled_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX elements_enabled_idx ON public.elements USING btree (enabled);


--
-- Name: elements_fieldLayoutId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "elements_fieldLayoutId_idx" ON public.elements USING btree ("fieldLayoutId");


--
-- Name: elements_sites_elementId_siteId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "elements_sites_elementId_siteId_unq_idx" ON public.elements_sites USING btree ("elementId", "siteId");


--
-- Name: elements_sites_enabled_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX elements_sites_enabled_idx ON public.elements_sites USING btree (enabled);


--
-- Name: elements_sites_siteId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "elements_sites_siteId_idx" ON public.elements_sites USING btree ("siteId");


--
-- Name: elements_sites_slug_siteId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "elements_sites_slug_siteId_idx" ON public.elements_sites USING btree (slug, "siteId");


--
-- Name: elements_sites_uri_siteId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "elements_sites_uri_siteId_idx" ON public.elements_sites USING btree (lower((uri)::text), "siteId");


--
-- Name: elements_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX elements_type_idx ON public.elements USING btree (type);


--
-- Name: entries_authorId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entries_authorId_idx" ON public.entries USING btree ("authorId");


--
-- Name: entries_expiryDate_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entries_expiryDate_idx" ON public.entries USING btree ("expiryDate");


--
-- Name: entries_postDate_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entries_postDate_idx" ON public.entries USING btree ("postDate");


--
-- Name: entries_sectionId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entries_sectionId_idx" ON public.entries USING btree ("sectionId");


--
-- Name: entries_typeId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entries_typeId_idx" ON public.entries USING btree ("typeId");


--
-- Name: entrytypes_dateDeleted_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entrytypes_dateDeleted_idx" ON public.entrytypes USING btree ("dateDeleted");


--
-- Name: entrytypes_fieldLayoutId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entrytypes_fieldLayoutId_idx" ON public.entrytypes USING btree ("fieldLayoutId");


--
-- Name: entrytypes_handle_sectionId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entrytypes_handle_sectionId_idx" ON public.entrytypes USING btree (handle, "sectionId");


--
-- Name: entrytypes_name_sectionId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entrytypes_name_sectionId_idx" ON public.entrytypes USING btree (name, "sectionId");


--
-- Name: entrytypes_sectionId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "entrytypes_sectionId_idx" ON public.entrytypes USING btree ("sectionId");


--
-- Name: fieldgroups_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fieldgroups_name_idx ON public.fieldgroups USING btree (name);


--
-- Name: fieldlayoutfields_fieldId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fieldlayoutfields_fieldId_idx" ON public.fieldlayoutfields USING btree ("fieldId");


--
-- Name: fieldlayoutfields_layoutId_fieldId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "fieldlayoutfields_layoutId_fieldId_unq_idx" ON public.fieldlayoutfields USING btree ("layoutId", "fieldId");


--
-- Name: fieldlayoutfields_sortOrder_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fieldlayoutfields_sortOrder_idx" ON public.fieldlayoutfields USING btree ("sortOrder");


--
-- Name: fieldlayoutfields_tabId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fieldlayoutfields_tabId_idx" ON public.fieldlayoutfields USING btree ("tabId");


--
-- Name: fieldlayouts_dateDeleted_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fieldlayouts_dateDeleted_idx" ON public.fieldlayouts USING btree ("dateDeleted");


--
-- Name: fieldlayouts_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fieldlayouts_type_idx ON public.fieldlayouts USING btree (type);


--
-- Name: fieldlayouttabs_layoutId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fieldlayouttabs_layoutId_idx" ON public.fieldlayouttabs USING btree ("layoutId");


--
-- Name: fieldlayouttabs_sortOrder_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fieldlayouttabs_sortOrder_idx" ON public.fieldlayouttabs USING btree ("sortOrder");


--
-- Name: fields_context_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fields_context_idx ON public.fields USING btree (context);


--
-- Name: fields_groupId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fields_groupId_idx" ON public.fields USING btree ("groupId");


--
-- Name: fields_handle_context_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fields_handle_context_idx ON public.fields USING btree (handle, context);


--
-- Name: globalsets_fieldLayoutId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "globalsets_fieldLayoutId_idx" ON public.globalsets USING btree ("fieldLayoutId");


--
-- Name: globalsets_handle_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX globalsets_handle_idx ON public.globalsets USING btree (handle);


--
-- Name: globalsets_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX globalsets_name_idx ON public.globalsets USING btree (name);


--
-- Name: gqltokens_accessToken_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "gqltokens_accessToken_unq_idx" ON public.gqltokens USING btree ("accessToken");


--
-- Name: gqltokens_name_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX gqltokens_name_unq_idx ON public.gqltokens USING btree (name);


--
-- Name: matrixblocks_fieldId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "matrixblocks_fieldId_idx" ON public.matrixblocks USING btree ("fieldId");


--
-- Name: matrixblocks_ownerId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "matrixblocks_ownerId_idx" ON public.matrixblocks USING btree ("ownerId");


--
-- Name: matrixblocks_sortOrder_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "matrixblocks_sortOrder_idx" ON public.matrixblocks USING btree ("sortOrder");


--
-- Name: matrixblocks_typeId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "matrixblocks_typeId_idx" ON public.matrixblocks USING btree ("typeId");


--
-- Name: matrixblocktypes_fieldId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "matrixblocktypes_fieldId_idx" ON public.matrixblocktypes USING btree ("fieldId");


--
-- Name: matrixblocktypes_fieldLayoutId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "matrixblocktypes_fieldLayoutId_idx" ON public.matrixblocktypes USING btree ("fieldLayoutId");


--
-- Name: matrixblocktypes_handle_fieldId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "matrixblocktypes_handle_fieldId_idx" ON public.matrixblocktypes USING btree (handle, "fieldId");


--
-- Name: matrixblocktypes_name_fieldId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "matrixblocktypes_name_fieldId_idx" ON public.matrixblocktypes USING btree (name, "fieldId");


--
-- Name: migrations_track_name_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX migrations_track_name_unq_idx ON public.migrations USING btree (track, name);


--
-- Name: plugins_handle_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX plugins_handle_unq_idx ON public.plugins USING btree (handle);


--
-- Name: queue_channel_fail_timeUpdated_delay_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "queue_channel_fail_timeUpdated_delay_idx" ON public.queue USING btree (channel, fail, "timeUpdated", delay);


--
-- Name: queue_channel_fail_timeUpdated_timePushed_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "queue_channel_fail_timeUpdated_timePushed_idx" ON public.queue USING btree (channel, fail, "timeUpdated", "timePushed");


--
-- Name: relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx" ON public.relations USING btree ("fieldId", "sourceId", "sourceSiteId", "targetId");


--
-- Name: relations_sourceId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "relations_sourceId_idx" ON public.relations USING btree ("sourceId");


--
-- Name: relations_sourceSiteId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "relations_sourceSiteId_idx" ON public.relations USING btree ("sourceSiteId");


--
-- Name: relations_targetId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "relations_targetId_idx" ON public.relations USING btree ("targetId");


--
-- Name: revisions_sourceId_num_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "revisions_sourceId_num_unq_idx" ON public.revisions USING btree ("sourceId", num);


--
-- Name: searchindex_keywords_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX searchindex_keywords_idx ON public.searchindex USING btree (keywords);


--
-- Name: searchindex_keywords_vector_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX searchindex_keywords_vector_idx ON public.searchindex USING gin (keywords_vector) WITH (fastupdate=yes);


--
-- Name: sections_dateDeleted_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "sections_dateDeleted_idx" ON public.sections USING btree ("dateDeleted");


--
-- Name: sections_handle_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sections_handle_idx ON public.sections USING btree (handle);


--
-- Name: sections_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sections_name_idx ON public.sections USING btree (name);


--
-- Name: sections_sites_sectionId_siteId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "sections_sites_sectionId_siteId_unq_idx" ON public.sections_sites USING btree ("sectionId", "siteId");


--
-- Name: sections_sites_siteId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "sections_sites_siteId_idx" ON public.sections_sites USING btree ("siteId");


--
-- Name: sections_structureId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "sections_structureId_idx" ON public.sections USING btree ("structureId");


--
-- Name: sessions_dateUpdated_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "sessions_dateUpdated_idx" ON public.sessions USING btree ("dateUpdated");


--
-- Name: sessions_token_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_token_idx ON public.sessions USING btree (token);


--
-- Name: sessions_uid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_uid_idx ON public.sessions USING btree (uid);


--
-- Name: sessions_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "sessions_userId_idx" ON public.sessions USING btree ("userId");


--
-- Name: shunnedmessages_userId_message_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "shunnedmessages_userId_message_unq_idx" ON public.shunnedmessages USING btree ("userId", message);


--
-- Name: sitegroups_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sitegroups_name_idx ON public.sitegroups USING btree (name);


--
-- Name: sites_dateDeleted_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "sites_dateDeleted_idx" ON public.sites USING btree ("dateDeleted");


--
-- Name: sites_handle_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sites_handle_idx ON public.sites USING btree (handle);


--
-- Name: sites_sortOrder_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "sites_sortOrder_idx" ON public.sites USING btree ("sortOrder");


--
-- Name: structureelements_elementId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "structureelements_elementId_idx" ON public.structureelements USING btree ("elementId");


--
-- Name: structureelements_level_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX structureelements_level_idx ON public.structureelements USING btree (level);


--
-- Name: structureelements_lft_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX structureelements_lft_idx ON public.structureelements USING btree (lft);


--
-- Name: structureelements_rgt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX structureelements_rgt_idx ON public.structureelements USING btree (rgt);


--
-- Name: structureelements_root_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX structureelements_root_idx ON public.structureelements USING btree (root);


--
-- Name: structureelements_structureId_elementId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "structureelements_structureId_elementId_unq_idx" ON public.structureelements USING btree ("structureId", "elementId");


--
-- Name: structures_dateDeleted_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "structures_dateDeleted_idx" ON public.structures USING btree ("dateDeleted");


--
-- Name: systemmessages_key_language_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX systemmessages_key_language_unq_idx ON public.systemmessages USING btree (key, language);


--
-- Name: systemmessages_language_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX systemmessages_language_idx ON public.systemmessages USING btree (language);


--
-- Name: taggroups_dateDeleted_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "taggroups_dateDeleted_idx" ON public.taggroups USING btree ("dateDeleted");


--
-- Name: taggroups_handle_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX taggroups_handle_idx ON public.taggroups USING btree (handle);


--
-- Name: taggroups_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX taggroups_name_idx ON public.taggroups USING btree (name);


--
-- Name: tags_groupId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "tags_groupId_idx" ON public.tags USING btree ("groupId");


--
-- Name: templatecacheelements_cacheId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templatecacheelements_cacheId_idx" ON public.templatecacheelements USING btree ("cacheId");


--
-- Name: templatecacheelements_elementId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templatecacheelements_elementId_idx" ON public.templatecacheelements USING btree ("elementId");


--
-- Name: templatecachequeries_cacheId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templatecachequeries_cacheId_idx" ON public.templatecachequeries USING btree ("cacheId");


--
-- Name: templatecachequeries_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX templatecachequeries_type_idx ON public.templatecachequeries USING btree (type);


--
-- Name: templatecaches_cacheKey_siteId_expiryDate_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templatecaches_cacheKey_siteId_expiryDate_idx" ON public.templatecaches USING btree ("cacheKey", "siteId", "expiryDate");


--
-- Name: templatecaches_cacheKey_siteId_expiryDate_path_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templatecaches_cacheKey_siteId_expiryDate_path_idx" ON public.templatecaches USING btree ("cacheKey", "siteId", "expiryDate", path);


--
-- Name: templatecaches_siteId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templatecaches_siteId_idx" ON public.templatecaches USING btree ("siteId");


--
-- Name: tokens_expiryDate_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "tokens_expiryDate_idx" ON public.tokens USING btree ("expiryDate");


--
-- Name: tokens_token_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tokens_token_unq_idx ON public.tokens USING btree (token);


--
-- Name: usergroups_handle_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX usergroups_handle_idx ON public.usergroups USING btree (handle);


--
-- Name: usergroups_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX usergroups_name_idx ON public.usergroups USING btree (name);


--
-- Name: usergroups_users_groupId_userId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "usergroups_users_groupId_userId_unq_idx" ON public.usergroups_users USING btree ("groupId", "userId");


--
-- Name: usergroups_users_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "usergroups_users_userId_idx" ON public.usergroups_users USING btree ("userId");


--
-- Name: userpermissions_name_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX userpermissions_name_unq_idx ON public.userpermissions USING btree (name);


--
-- Name: userpermissions_usergroups_groupId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "userpermissions_usergroups_groupId_idx" ON public.userpermissions_usergroups USING btree ("groupId");


--
-- Name: userpermissions_usergroups_permissionId_groupId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "userpermissions_usergroups_permissionId_groupId_unq_idx" ON public.userpermissions_usergroups USING btree ("permissionId", "groupId");


--
-- Name: userpermissions_users_permissionId_userId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "userpermissions_users_permissionId_userId_unq_idx" ON public.userpermissions_users USING btree ("permissionId", "userId");


--
-- Name: userpermissions_users_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "userpermissions_users_userId_idx" ON public.userpermissions_users USING btree ("userId");


--
-- Name: users_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_email_idx ON public.users USING btree (lower((email)::text));


--
-- Name: users_uid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_uid_idx ON public.users USING btree (uid);


--
-- Name: users_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_username_idx ON public.users USING btree (lower((username)::text));


--
-- Name: users_verificationCode_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "users_verificationCode_idx" ON public.users USING btree ("verificationCode");


--
-- Name: volumefolders_name_parentId_volumeId_unq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "volumefolders_name_parentId_volumeId_unq_idx" ON public.volumefolders USING btree (name, "parentId", "volumeId");


--
-- Name: volumefolders_parentId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "volumefolders_parentId_idx" ON public.volumefolders USING btree ("parentId");


--
-- Name: volumefolders_volumeId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "volumefolders_volumeId_idx" ON public.volumefolders USING btree ("volumeId");


--
-- Name: volumes_dateDeleted_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "volumes_dateDeleted_idx" ON public.volumes USING btree ("dateDeleted");


--
-- Name: volumes_fieldLayoutId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "volumes_fieldLayoutId_idx" ON public.volumes USING btree ("fieldLayoutId");


--
-- Name: volumes_handle_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX volumes_handle_idx ON public.volumes USING btree (handle);


--
-- Name: volumes_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX volumes_name_idx ON public.volumes USING btree (name);


--
-- Name: widgets_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "widgets_userId_idx" ON public.widgets USING btree ("userId");


--
-- Name: assetindexdata assetindexdata_volumeId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assetindexdata
    ADD CONSTRAINT "assetindexdata_volumeId_fk" FOREIGN KEY ("volumeId") REFERENCES public.volumes(id) ON DELETE CASCADE;


--
-- Name: assets assets_folderId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT "assets_folderId_fk" FOREIGN KEY ("folderId") REFERENCES public.volumefolders(id) ON DELETE CASCADE;


--
-- Name: assets assets_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_id_fk FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: assets assets_uploaderId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT "assets_uploaderId_fk" FOREIGN KEY ("uploaderId") REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: assets assets_volumeId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT "assets_volumeId_fk" FOREIGN KEY ("volumeId") REFERENCES public.volumes(id) ON DELETE CASCADE;


--
-- Name: categories categories_groupId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "categories_groupId_fk" FOREIGN KEY ("groupId") REFERENCES public.categorygroups(id) ON DELETE CASCADE;


--
-- Name: categories categories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_id_fk FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: categories categories_parentId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "categories_parentId_fk" FOREIGN KEY ("parentId") REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: categorygroups categorygroups_fieldLayoutId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorygroups
    ADD CONSTRAINT "categorygroups_fieldLayoutId_fk" FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: categorygroups_sites categorygroups_sites_groupId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorygroups_sites
    ADD CONSTRAINT "categorygroups_sites_groupId_fk" FOREIGN KEY ("groupId") REFERENCES public.categorygroups(id) ON DELETE CASCADE;


--
-- Name: categorygroups_sites categorygroups_sites_siteId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorygroups_sites
    ADD CONSTRAINT "categorygroups_sites_siteId_fk" FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: categorygroups categorygroups_structureId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorygroups
    ADD CONSTRAINT "categorygroups_structureId_fk" FOREIGN KEY ("structureId") REFERENCES public.structures(id) ON DELETE CASCADE;


--
-- Name: changedattributes changedattributes_elementId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changedattributes
    ADD CONSTRAINT "changedattributes_elementId_fk" FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: changedattributes changedattributes_siteId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changedattributes
    ADD CONSTRAINT "changedattributes_siteId_fk" FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: changedattributes changedattributes_userId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changedattributes
    ADD CONSTRAINT "changedattributes_userId_fk" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: changedfields changedfields_elementId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT "changedfields_elementId_fk" FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: changedfields changedfields_fieldId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT "changedfields_fieldId_fk" FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: changedfields changedfields_siteId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT "changedfields_siteId_fk" FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: changedfields changedfields_userId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT "changedfields_userId_fk" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: content content_elementId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT "content_elementId_fk" FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: content content_siteId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT "content_siteId_fk" FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: craftidtokens craftidtokens_userId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.craftidtokens
    ADD CONSTRAINT "craftidtokens_userId_fk" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: drafts drafts_creatorId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT "drafts_creatorId_fk" FOREIGN KEY ("creatorId") REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: drafts drafts_sourceId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT "drafts_sourceId_fk" FOREIGN KEY ("sourceId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: elements elements_draftId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT "elements_draftId_fk" FOREIGN KEY ("draftId") REFERENCES public.drafts(id) ON DELETE CASCADE;


--
-- Name: elements elements_fieldLayoutId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT "elements_fieldLayoutId_fk" FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: elements elements_revisionId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT "elements_revisionId_fk" FOREIGN KEY ("revisionId") REFERENCES public.revisions(id) ON DELETE CASCADE;


--
-- Name: elements_sites elements_sites_elementId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements_sites
    ADD CONSTRAINT "elements_sites_elementId_fk" FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: elements_sites elements_sites_siteId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements_sites
    ADD CONSTRAINT "elements_sites_siteId_fk" FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: entries entries_authorId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT "entries_authorId_fk" FOREIGN KEY ("authorId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: entries entries_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT entries_id_fk FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: entries entries_parentId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT "entries_parentId_fk" FOREIGN KEY ("parentId") REFERENCES public.entries(id) ON DELETE SET NULL;


--
-- Name: entries entries_sectionId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT "entries_sectionId_fk" FOREIGN KEY ("sectionId") REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: entries entries_typeId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT "entries_typeId_fk" FOREIGN KEY ("typeId") REFERENCES public.entrytypes(id) ON DELETE CASCADE;


--
-- Name: entrytypes entrytypes_fieldLayoutId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrytypes
    ADD CONSTRAINT "entrytypes_fieldLayoutId_fk" FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: entrytypes entrytypes_sectionId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrytypes
    ADD CONSTRAINT "entrytypes_sectionId_fk" FOREIGN KEY ("sectionId") REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: fieldlayoutfields fieldlayoutfields_fieldId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayoutfields
    ADD CONSTRAINT "fieldlayoutfields_fieldId_fk" FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: fieldlayoutfields fieldlayoutfields_layoutId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayoutfields
    ADD CONSTRAINT "fieldlayoutfields_layoutId_fk" FOREIGN KEY ("layoutId") REFERENCES public.fieldlayouts(id) ON DELETE CASCADE;


--
-- Name: fieldlayoutfields fieldlayoutfields_tabId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayoutfields
    ADD CONSTRAINT "fieldlayoutfields_tabId_fk" FOREIGN KEY ("tabId") REFERENCES public.fieldlayouttabs(id) ON DELETE CASCADE;


--
-- Name: fieldlayouttabs fieldlayouttabs_layoutId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fieldlayouttabs
    ADD CONSTRAINT "fieldlayouttabs_layoutId_fk" FOREIGN KEY ("layoutId") REFERENCES public.fieldlayouts(id) ON DELETE CASCADE;


--
-- Name: fields fields_groupId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT "fields_groupId_fk" FOREIGN KEY ("groupId") REFERENCES public.fieldgroups(id) ON DELETE CASCADE;


--
-- Name: globalsets globalsets_fieldLayoutId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.globalsets
    ADD CONSTRAINT "globalsets_fieldLayoutId_fk" FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: globalsets globalsets_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.globalsets
    ADD CONSTRAINT globalsets_id_fk FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: gqltokens gqltokens_schemaId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gqltokens
    ADD CONSTRAINT "gqltokens_schemaId_fk" FOREIGN KEY ("schemaId") REFERENCES public.gqlschemas(id) ON DELETE SET NULL;


--
-- Name: matrixblocks matrixblocks_fieldId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT "matrixblocks_fieldId_fk" FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: matrixblocks matrixblocks_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT matrixblocks_id_fk FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: matrixblocks matrixblocks_ownerId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT "matrixblocks_ownerId_fk" FOREIGN KEY ("ownerId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: matrixblocks matrixblocks_typeId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT "matrixblocks_typeId_fk" FOREIGN KEY ("typeId") REFERENCES public.matrixblocktypes(id) ON DELETE CASCADE;


--
-- Name: matrixblocktypes matrixblocktypes_fieldId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matrixblocktypes
    ADD CONSTRAINT "matrixblocktypes_fieldId_fk" FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: matrixblocktypes matrixblocktypes_fieldLayoutId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matrixblocktypes
    ADD CONSTRAINT "matrixblocktypes_fieldLayoutId_fk" FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: relations relations_fieldId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT "relations_fieldId_fk" FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: relations relations_sourceId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT "relations_sourceId_fk" FOREIGN KEY ("sourceId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: relations relations_sourceSiteId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT "relations_sourceSiteId_fk" FOREIGN KEY ("sourceSiteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: relations relations_targetId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT "relations_targetId_fk" FOREIGN KEY ("targetId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: revisions revisions_creatorId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT "revisions_creatorId_fk" FOREIGN KEY ("creatorId") REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: revisions revisions_sourceId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT "revisions_sourceId_fk" FOREIGN KEY ("sourceId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: sections_sites sections_sites_sectionId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections_sites
    ADD CONSTRAINT "sections_sites_sectionId_fk" FOREIGN KEY ("sectionId") REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: sections_sites sections_sites_siteId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections_sites
    ADD CONSTRAINT "sections_sites_siteId_fk" FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sections sections_structureId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT "sections_structureId_fk" FOREIGN KEY ("structureId") REFERENCES public.structures(id) ON DELETE SET NULL;


--
-- Name: sessions sessions_userId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT "sessions_userId_fk" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: shunnedmessages shunnedmessages_userId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shunnedmessages
    ADD CONSTRAINT "shunnedmessages_userId_fk" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: sites sites_groupId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT "sites_groupId_fk" FOREIGN KEY ("groupId") REFERENCES public.sitegroups(id) ON DELETE CASCADE;


--
-- Name: structureelements structureelements_elementId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structureelements
    ADD CONSTRAINT "structureelements_elementId_fk" FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: structureelements structureelements_structureId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structureelements
    ADD CONSTRAINT "structureelements_structureId_fk" FOREIGN KEY ("structureId") REFERENCES public.structures(id) ON DELETE CASCADE;


--
-- Name: taggroups taggroups_fieldLayoutId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taggroups
    ADD CONSTRAINT "taggroups_fieldLayoutId_fk" FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: tags tags_groupId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT "tags_groupId_fk" FOREIGN KEY ("groupId") REFERENCES public.taggroups(id) ON DELETE CASCADE;


--
-- Name: tags tags_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_id_fk FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: templatecacheelements templatecacheelements_cacheId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecacheelements
    ADD CONSTRAINT "templatecacheelements_cacheId_fk" FOREIGN KEY ("cacheId") REFERENCES public.templatecaches(id) ON DELETE CASCADE;


--
-- Name: templatecacheelements templatecacheelements_elementId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecacheelements
    ADD CONSTRAINT "templatecacheelements_elementId_fk" FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: templatecachequeries templatecachequeries_cacheId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecachequeries
    ADD CONSTRAINT "templatecachequeries_cacheId_fk" FOREIGN KEY ("cacheId") REFERENCES public.templatecaches(id) ON DELETE CASCADE;


--
-- Name: templatecaches templatecaches_siteId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatecaches
    ADD CONSTRAINT "templatecaches_siteId_fk" FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usergroups_users usergroups_users_groupId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroups_users
    ADD CONSTRAINT "usergroups_users_groupId_fk" FOREIGN KEY ("groupId") REFERENCES public.usergroups(id) ON DELETE CASCADE;


--
-- Name: usergroups_users usergroups_users_userId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroups_users
    ADD CONSTRAINT "usergroups_users_userId_fk" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: userpermissions_usergroups userpermissions_usergroups_groupId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions_usergroups
    ADD CONSTRAINT "userpermissions_usergroups_groupId_fk" FOREIGN KEY ("groupId") REFERENCES public.usergroups(id) ON DELETE CASCADE;


--
-- Name: userpermissions_usergroups userpermissions_usergroups_permissionId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions_usergroups
    ADD CONSTRAINT "userpermissions_usergroups_permissionId_fk" FOREIGN KEY ("permissionId") REFERENCES public.userpermissions(id) ON DELETE CASCADE;


--
-- Name: userpermissions_users userpermissions_users_permissionId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions_users
    ADD CONSTRAINT "userpermissions_users_permissionId_fk" FOREIGN KEY ("permissionId") REFERENCES public.userpermissions(id) ON DELETE CASCADE;


--
-- Name: userpermissions_users userpermissions_users_userId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpermissions_users
    ADD CONSTRAINT "userpermissions_users_userId_fk" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: userpreferences userpreferences_userId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userpreferences
    ADD CONSTRAINT "userpreferences_userId_fk" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_fk FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: users users_photoId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_photoId_fk" FOREIGN KEY ("photoId") REFERENCES public.assets(id) ON DELETE SET NULL;


--
-- Name: volumefolders volumefolders_parentId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volumefolders
    ADD CONSTRAINT "volumefolders_parentId_fk" FOREIGN KEY ("parentId") REFERENCES public.volumefolders(id) ON DELETE CASCADE;


--
-- Name: volumefolders volumefolders_volumeId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volumefolders
    ADD CONSTRAINT "volumefolders_volumeId_fk" FOREIGN KEY ("volumeId") REFERENCES public.volumes(id) ON DELETE CASCADE;


--
-- Name: volumes volumes_fieldLayoutId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volumes
    ADD CONSTRAINT "volumes_fieldLayoutId_fk" FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: widgets widgets_userId_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.widgets
    ADD CONSTRAINT "widgets_userId_fk" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

