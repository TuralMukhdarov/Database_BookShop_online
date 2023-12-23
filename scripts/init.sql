--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: book; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA book;


ALTER SCHEMA book OWNER TO postgres;

--
-- Name: hr; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hr;


ALTER SCHEMA hr OWNER TO postgres;

--
-- Name: person; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA person;


ALTER SCHEMA person OWNER TO postgres;

--
-- Name: production; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA production;


ALTER SCHEMA production OWNER TO postgres;

--
-- Name: sales; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sales;


ALTER SCHEMA sales OWNER TO postgres;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: email; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.email AS character varying(300) NOT NULL
	CONSTRAINT email_check CHECK (((VALUE)::text ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::text));


ALTER DOMAIN public.email OWNER TO postgres;

--
-- Name: phone; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.phone AS character varying(25) NOT NULL
	CONSTRAINT phone_check CHECK (((VALUE)::text ~ '^(\+7)?[\s\-]?\(?[1-9][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$'::text));


ALTER DOMAIN public.phone OWNER TO postgres;

--
-- Name: update_modified_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    new.modified_at = now();
    return new;
end;
$$;


ALTER FUNCTION public.update_modified_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: authors; Type: TABLE; Schema: book; Owner: postgres
--

CREATE TABLE book.authors (
    author_id integer NOT NULL,
    author_name character varying(100) NOT NULL
);


ALTER TABLE book.authors OWNER TO postgres;

--
-- Name: authors_author_id_seq; Type: SEQUENCE; Schema: book; Owner: postgres
--

CREATE SEQUENCE book.authors_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE book.authors_author_id_seq OWNER TO postgres;

--
-- Name: authors_author_id_seq; Type: SEQUENCE OWNED BY; Schema: book; Owner: postgres
--

ALTER SEQUENCE book.authors_author_id_seq OWNED BY book.authors.author_id;


--
-- Name: book_authors; Type: TABLE; Schema: book; Owner: postgres
--

CREATE TABLE book.book_authors (
    book_id integer NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE book.book_authors OWNER TO postgres;

--
-- Name: book_categories; Type: TABLE; Schema: book; Owner: postgres
--

CREATE TABLE book.book_categories (
    book_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE book.book_categories OWNER TO postgres;

--
-- Name: books; Type: TABLE; Schema: book; Owner: postgres
--

CREATE TABLE book.books (
    book_id integer NOT NULL,
    title character varying(100) NOT NULL,
    description text,
    published_date date,
    publisher_id integer NOT NULL,
    isbn character varying(30) NOT NULL,
    page_count integer NOT NULL,
    language_id integer NOT NULL,
    url_photo character varying(100),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE book.books OWNER TO postgres;

--
-- Name: books_book_id_seq; Type: SEQUENCE; Schema: book; Owner: postgres
--

CREATE SEQUENCE book.books_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE book.books_book_id_seq OWNER TO postgres;

--
-- Name: books_book_id_seq; Type: SEQUENCE OWNED BY; Schema: book; Owner: postgres
--

ALTER SEQUENCE book.books_book_id_seq OWNED BY book.books.book_id;


--
-- Name: categories; Type: TABLE; Schema: book; Owner: postgres
--

CREATE TABLE book.categories (
    category_id integer NOT NULL,
    category_name character varying(50) NOT NULL
);


ALTER TABLE book.categories OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: book; Owner: postgres
--

CREATE SEQUENCE book.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE book.categories_category_id_seq OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: book; Owner: postgres
--

ALTER SEQUENCE book.categories_category_id_seq OWNED BY book.categories.category_id;


--
-- Name: languages; Type: TABLE; Schema: book; Owner: postgres
--

CREATE TABLE book.languages (
    language_id integer NOT NULL,
    language_code character varying(10) NOT NULL,
    language_name character varying(25) NOT NULL
);


ALTER TABLE book.languages OWNER TO postgres;

--
-- Name: languages_language_id_seq; Type: SEQUENCE; Schema: book; Owner: postgres
--

CREATE SEQUENCE book.languages_language_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE book.languages_language_id_seq OWNER TO postgres;

--
-- Name: languages_language_id_seq; Type: SEQUENCE OWNED BY; Schema: book; Owner: postgres
--

ALTER SEQUENCE book.languages_language_id_seq OWNED BY book.languages.language_id;


--
-- Name: publishers; Type: TABLE; Schema: book; Owner: postgres
--

CREATE TABLE book.publishers (
    publisher_id integer NOT NULL,
    publisher_name character varying(50) NOT NULL
);


ALTER TABLE book.publishers OWNER TO postgres;

--
-- Name: publishers_publisher_id_seq; Type: SEQUENCE; Schema: book; Owner: postgres
--

CREATE SEQUENCE book.publishers_publisher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE book.publishers_publisher_id_seq OWNER TO postgres;

--
-- Name: publishers_publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: book; Owner: postgres
--

ALTER SEQUENCE book.publishers_publisher_id_seq OWNED BY book.publishers.publisher_id;


--
-- Name: v_books; Type: VIEW; Schema: book; Owner: postgres
--

CREATE VIEW book.v_books AS
 SELECT b.book_id,
    b.title,
    b.description,
    b.published_date,
    a.author_name,
    c.category_name,
    p.publisher_name,
    b.isbn,
    b.page_count,
    l.language_name,
    b.url_photo
   FROM ((((book.books b
     LEFT JOIN ( SELECT b_1.book_id,
            array_agg(c_1.category_name) AS category_name
           FROM ((book.categories c_1
             JOIN book.book_categories bk ON ((c_1.category_id = bk.category_id)))
             JOIN book.books b_1 ON ((bk.book_id = b_1.book_id)))
          GROUP BY b_1.book_id) c USING (book_id))
     LEFT JOIN ( SELECT b_1.book_id,
            array_agg(a_1.author_name) AS author_name
           FROM ((book.authors a_1
             JOIN book.book_authors ba ON ((a_1.author_id = ba.author_id)))
             JOIN book.books b_1 ON ((ba.book_id = b_1.book_id)))
          GROUP BY b_1.book_id) a USING (book_id))
     JOIN book.languages l USING (language_id))
     JOIN book.publishers p USING (publisher_id))
  ORDER BY b.book_id;


ALTER VIEW book.v_books OWNER TO postgres;

--
-- Name: employees; Type: TABLE; Schema: hr; Owner: postgres
--

CREATE TABLE hr.employees (
    employee_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    middle_name character varying(100),
    date_of_birth date NOT NULL,
    phone_number public.phone NOT NULL,
    employment_date date NOT NULL,
    dismissal_date date,
    position_id integer NOT NULL,
    url_photo character varying(100),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE hr.employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: hr; Owner: postgres
--

CREATE SEQUENCE hr.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hr.employees_employee_id_seq OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: hr; Owner: postgres
--

ALTER SEQUENCE hr.employees_employee_id_seq OWNED BY hr.employees.employee_id;


--
-- Name: positions; Type: TABLE; Schema: hr; Owner: postgres
--

CREATE TABLE hr.positions (
    position_id integer NOT NULL,
    position_name character varying(50) NOT NULL
);


ALTER TABLE hr.positions OWNER TO postgres;

--
-- Name: positions_position_id_seq; Type: SEQUENCE; Schema: hr; Owner: postgres
--

CREATE SEQUENCE hr.positions_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hr.positions_position_id_seq OWNER TO postgres;

--
-- Name: positions_position_id_seq; Type: SEQUENCE OWNED BY; Schema: hr; Owner: postgres
--

ALTER SEQUENCE hr.positions_position_id_seq OWNED BY hr.positions.position_id;


--
-- Name: addresses; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.addresses (
    address_id integer NOT NULL,
    address character varying(300) NOT NULL,
    postal_code character varying(20),
    city character varying(50) NOT NULL,
    region_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.addresses OWNER TO postgres;

--
-- Name: addresses_address_id_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.addresses_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE person.addresses_address_id_seq OWNER TO postgres;

--
-- Name: addresses_address_id_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.addresses_address_id_seq OWNED BY person.addresses.address_id;


--
-- Name: countries; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.countries (
    country_code character varying(25) NOT NULL,
    country_name character varying(50) NOT NULL
);


ALTER TABLE person.countries OWNER TO postgres;

--
-- Name: customer_addresses; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.customer_addresses (
    customer_id integer NOT NULL,
    address_id integer NOT NULL,
    is_current_address boolean DEFAULT true NOT NULL
);


ALTER TABLE person.customer_addresses OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.customers (
    customer_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    middle_name character varying(100),
    date_of_birth date,
    phone_number public.phone NOT NULL,
    email_address public.email NOT NULL,
    is_email_notification boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_date_of_birth CHECK ((date_of_birth >= '1900-01-01'::date))
);


ALTER TABLE person.customers OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE person.customers_customer_id_seq OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.customers_customer_id_seq OWNED BY person.customers.customer_id;


--
-- Name: passwords; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.passwords (
    customer_id integer NOT NULL,
    password_hash text NOT NULL,
    salt character varying(100) DEFAULT public.gen_salt('bf'::text) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.passwords OWNER TO postgres;

--
-- Name: regions; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.regions (
    region_id integer NOT NULL,
    region_code character varying(25) NOT NULL,
    country_code character varying(25) NOT NULL,
    region_name character varying(50) NOT NULL
);


ALTER TABLE person.regions OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.regions_region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE person.regions_region_id_seq OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.regions_region_id_seq OWNED BY person.regions.region_id;


--
-- Name: products; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.products (
    product_id integer NOT NULL,
    unit_price double precision NOT NULL,
    units_in_stock integer NOT NULL,
    weight integer NOT NULL,
    bonuses integer NOT NULL,
    sell_start_date date NOT NULL,
    sell_end_date date,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.products OWNER TO postgres;

--
-- Name: credit_cards; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.credit_cards (
    card_id integer NOT NULL,
    card_type character varying(30) NOT NULL,
    card_number character varying(25) NOT NULL,
    exp_month smallint NOT NULL,
    exp_year smallint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.credit_cards OWNER TO postgres;

--
-- Name: credit_cards_card_id_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.credit_cards_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sales.credit_cards_card_id_seq OWNER TO postgres;

--
-- Name: credit_cards_card_id_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.credit_cards_card_id_seq OWNED BY sales.credit_cards.card_id;


--
-- Name: customer_bonus_cards; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.customer_bonus_cards (
    customer_id integer NOT NULL,
    barcode character varying(25) NOT NULL,
    balance double precision NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.customer_bonus_cards OWNER TO postgres;

--
-- Name: customer_credit_cards; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.customer_credit_cards (
    customer_id integer NOT NULL,
    card_id integer NOT NULL,
    is_current_card boolean DEFAULT true NOT NULL
);


ALTER TABLE sales.customer_credit_cards OWNER TO postgres;

--
-- Name: customer_personal_promocodes; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.customer_personal_promocodes (
    promocode_id integer NOT NULL,
    customer_id integer NOT NULL,
    promocode character varying(25) NOT NULL,
    rate integer NOT NULL,
    valid_from date NOT NULL,
    valid_to date NOT NULL,
    used boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.customer_personal_promocodes OWNER TO postgres;

--
-- Name: customer_personal_promocodes_promocode_id_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.customer_personal_promocodes_promocode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sales.customer_personal_promocodes_promocode_id_seq OWNER TO postgres;

--
-- Name: customer_personal_promocodes_promocode_id_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.customer_personal_promocodes_promocode_id_seq OWNED BY sales.customer_personal_promocodes.promocode_id;


--
-- Name: method_deliveries; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.method_deliveries (
    delivery_id integer NOT NULL,
    delivery_name character varying(50) NOT NULL
);


ALTER TABLE sales.method_deliveries OWNER TO postgres;

--
-- Name: method_deliveries_delivery_id_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.method_deliveries_delivery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sales.method_deliveries_delivery_id_seq OWNER TO postgres;

--
-- Name: method_deliveries_delivery_id_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.method_deliveries_delivery_id_seq OWNED BY sales.method_deliveries.delivery_id;


--
-- Name: method_payments; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.method_payments (
    payment_id integer NOT NULL,
    payment_name character varying(50) NOT NULL
);


ALTER TABLE sales.method_payments OWNER TO postgres;

--
-- Name: method_payments_payment_id_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.method_payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sales.method_payments_payment_id_seq OWNER TO postgres;

--
-- Name: method_payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.method_payments_payment_id_seq OWNED BY sales.method_payments.payment_id;


--
-- Name: order_lines; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.order_lines (
    line_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    unit_price double precision NOT NULL,
    weight integer NOT NULL,
    bonuses integer NOT NULL,
    quantity integer NOT NULL,
    line_total double precision NOT NULL,
    line_weight integer NOT NULL,
    line_bonuses integer NOT NULL
);


ALTER TABLE sales.order_lines OWNER TO postgres;

--
-- Name: order_lines_line_id_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.order_lines_line_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sales.order_lines_line_id_seq OWNER TO postgres;

--
-- Name: order_lines_line_id_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.order_lines_line_id_seq OWNED BY sales.order_lines.line_id;


--
-- Name: order_statuses; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.order_statuses (
    status_id integer NOT NULL,
    status_name character varying(25) NOT NULL
);


ALTER TABLE sales.order_statuses OWNER TO postgres;

--
-- Name: order_statuses_status_id_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.order_statuses_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sales.order_statuses_status_id_seq OWNER TO postgres;

--
-- Name: order_statuses_status_id_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.order_statuses_status_id_seq OWNED BY sales.order_statuses.status_id;


--
-- Name: orders; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.orders (
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    employee_id integer NOT NULL,
    order_number character varying(20) GENERATED ALWAYS AS (('ON-'::text || ((order_id)::character varying)::text)) STORED NOT NULL,
    total_sum double precision NOT NULL,
    total_weight integer NOT NULL,
    total_bonuses integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    credit_card_id integer,
    method_payment_id integer NOT NULL,
    method_delivery_id integer NOT NULL,
    address_delivery_id integer NOT NULL,
    promocode character varying(25),
    comment character varying(100),
    status_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sales.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.orders_order_id_seq OWNED BY sales.orders.order_id;


--
-- Name: authors author_id; Type: DEFAULT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.authors ALTER COLUMN author_id SET DEFAULT nextval('book.authors_author_id_seq'::regclass);


--
-- Name: books book_id; Type: DEFAULT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.books ALTER COLUMN book_id SET DEFAULT nextval('book.books_book_id_seq'::regclass);


--
-- Name: categories category_id; Type: DEFAULT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.categories ALTER COLUMN category_id SET DEFAULT nextval('book.categories_category_id_seq'::regclass);


--
-- Name: languages language_id; Type: DEFAULT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.languages ALTER COLUMN language_id SET DEFAULT nextval('book.languages_language_id_seq'::regclass);


--
-- Name: publishers publisher_id; Type: DEFAULT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.publishers ALTER COLUMN publisher_id SET DEFAULT nextval('book.publishers_publisher_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: hr; Owner: postgres
--

ALTER TABLE ONLY hr.employees ALTER COLUMN employee_id SET DEFAULT nextval('hr.employees_employee_id_seq'::regclass);


--
-- Name: positions position_id; Type: DEFAULT; Schema: hr; Owner: postgres
--

ALTER TABLE ONLY hr.positions ALTER COLUMN position_id SET DEFAULT nextval('hr.positions_position_id_seq'::regclass);


--
-- Name: addresses address_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.addresses ALTER COLUMN address_id SET DEFAULT nextval('person.addresses_address_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.customers ALTER COLUMN customer_id SET DEFAULT nextval('person.customers_customer_id_seq'::regclass);


--
-- Name: regions region_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.regions ALTER COLUMN region_id SET DEFAULT nextval('person.regions_region_id_seq'::regclass);


--
-- Name: credit_cards card_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.credit_cards ALTER COLUMN card_id SET DEFAULT nextval('sales.credit_cards_card_id_seq'::regclass);


--
-- Name: customer_personal_promocodes promocode_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer_personal_promocodes ALTER COLUMN promocode_id SET DEFAULT nextval('sales.customer_personal_promocodes_promocode_id_seq'::regclass);


--
-- Name: method_deliveries delivery_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.method_deliveries ALTER COLUMN delivery_id SET DEFAULT nextval('sales.method_deliveries_delivery_id_seq'::regclass);


--
-- Name: method_payments payment_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.method_payments ALTER COLUMN payment_id SET DEFAULT nextval('sales.method_payments_payment_id_seq'::regclass);


--
-- Name: order_lines line_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.order_lines ALTER COLUMN line_id SET DEFAULT nextval('sales.order_lines_line_id_seq'::regclass);


--
-- Name: order_statuses status_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.order_statuses ALTER COLUMN status_id SET DEFAULT nextval('sales.order_statuses_status_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders ALTER COLUMN order_id SET DEFAULT nextval('sales.orders_order_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: book; Owner: postgres
--

COPY book.authors (author_id, author_name) FROM stdin;
1	Petar Tahchiev
2	Martien Verbruggen
3	Steven J. Gutz
4	Robert Kabacoff
5	Haleh Mahbod
6	Richard Siddaway
7	Daryl Harms
8	Philippe Mougin
9	Galina Landres
10	Kimberly Tripp
11	John Mitchell
12	Alex Benton
13	Brian Christeson
14	Cédric Champeau
15	Merlin Hughes
16	Bear Bibeault with Tom Locke
17	Bruce A. Tate
18	Contributions from 53 SQL Server MVPs
19	Paul Sanghera
20	Saša Juric´
21	Dhanji R. Prasanna
22	Otis Gospodnetic
23	Mike Cantelon
24	Robin Anil
25	Robert Chapman
26	Erik Keller
27	Ryan Breidenbach
28	Samuel M. Breed
29	Jothy Rosenberg
30	Ted Lewis
31	Jeremy Anderson
32	Ken Rimple
33	Dave Crane
34	Shannon Appelcline
35	Mario Fusco
36	Martin Conte Mac Donell
37	Peter Armstrong
38	Ashley Atkins
39	Matthew Farwell
40	Paul A. Boag
41	Greg Smith
42	Jack Gambol
43	Mark Combellack
44	Francisco Canedo
45	Stephen C. Drye
46	Radu Gheorghe
47	Timothy Binkley-Jones
48	Jason J.W. Williams
49	Jason R. Weiss
50	Chris Cunningham
51	Felipe Leme
52	Matthew E. Hodges
53	Chris Garrard
54	Rod Colledge
55	Warren Sande
56	John C. Bland II
57	Nilanjan Raychaudhuri
58	Adam Machanic
59	Ted G. Lewis
60	Timothy Perrett
61	Joseph Hocking
62	Assaf Arkin
63	Joshua D. Suereth
64	James P. White
65	Tim Jenness
66	Dmitry Babenko
67	Donald Brown
68	Gabe Zichermann
69	Jr.
70	Paul S. Hethmon
71	Joakim Sunden
72	Andrew Schmidt
73	Ian Gilman
74	Ricardo Alcocer
75	Nathan Weizenbaum
76	Richard S. Hall
77	Andres Almiray
78	Carlos M. Sessa
79	and Steve Klabnik
80	Nick Swan
81	Chris Buckett
82	Evan Rosen
83	Martin Logan
84	Yvonne M. Harryman
85	Srini Penchikala
86	Joey Lott
87	Raoul-Gabriel Urma
88	Bradley Austin Davis
89	Peter Pathirana
90	Robert A. Rice Jr.
91	Alvaro Videla
92	Kermit Project at Columbia University
93	Simon Holmes
94	friends
95	Roman Shaposhnik
96	Joseph Richards
97	Prakash Sankaran
98	editors
99	Patroklos P. Papapetrou
100	Josiah Carlson
101	Margaret M. Burnett
102	Sietse de Kaper
103	Bob Lee
104	Ted Neward
105	Joe McGinn
106	Timothy D. Korson
107	Brendan G. Lim
108	Peter M. Brown
109	Ivan Porto Carrero
110	Contributions from 53 SQL Server MVPs; Edited by Paul Nielsen
111	Rob Williams
112	Compiled
113	Eric Pascarello with Darren James
114	Robi Sen
115	Peter J. Kovach
116	Gregory M. Travis
117	Anthony Briggs
118	Andrew L. Farris
119	Dierk Koenig with Andrew Glover
120	Christopher Allen
121	Phillip Whisenhunt
122	Matthew Robinson
123	David Dossot
124	Tariq Ahmed with Jon Hirschi
125	T.J. Holowaychuk
126	David Savage
127	Josh C. Powell
128	Pavel Vorobiev
129	Ryan Bigg
130	Itamar Syn-Hershko
131	Shawn Bayern
132	Richard Sezov
133	Tomas Petricek with Jon Skeet
134	Jason C. Helmick
135	Kevin Hazzard
136	Rene Rubalcava
137	Matthias Kaeppler
138	Chris Houser
139	Tim Maher
140	Mark B. Whipple
141	Richard L. Saltzer
142	Timothy Ward
143	Patrick Lightbody
144	Steven Brown
145	David A. Hemphill
146	William Back
147	Fergal Grimes
148	Andy Piper
149	Trygve Reenskaug
150	Timothy Potter
151	Clayton Donley
152	Brandon Mathis
153	Alex Young
154	Anton Kovalyov
155	Erik Pragt
156	Jonathan Campos
157	Oren Eini writing as Ayende Rahien
158	Marcin Kawalerowicz
159	Norman Maurer
160	Holly Cummins
161	Galina
162	Jamil Azher
163	Michael McCandless
164	Raymond Roestenburg
165	II
166	Warren D. Sande
167	Chris Gray
168	Arnaud Cogoluegnes
169	Qusay H. Mahmoud
170	Adam Tacy
171	Brian Ford
172	Vikram Goyal
173	Theodore J. (T.J.) VanToll III
174	Thomas B. Passin
175	Grant S. Ingersoll
176	J. B. Rainsberger with contributions by Scott Stirling
177	Henrik Brink
178	Raymond Feng
179	Simon Laws
180	Patrick Peak
181	Ellen Friedman
182	Noel Yuhanna
183	Jon Skeet
184	Louis Davidson
185	David Nicolette
186	Alan R. Williamson
187	Debu Panda
188	Ashish Sarin
189	John Griffin
190	Peter Hilton
191	Ross A. Baker
192	Jay Brown
193	Sean Allen
194	Mark A. Kolb
195	Marco De Sanctis
196	Kyle Banker
197	Greg Low
198	Matthew Jankowski
199	Jason Bock
200	Vijay K. Vaishnavi
201	Stephan Hesmer
202	Mark Seemann
203	Craig Walls with Ryan Breidenbach
204	Naomi R. Ceder
205	Kyle Baley
206	Danno Ferrin
207	Erik Hatcher
208	Maria Winslow
209	Emmit A. Scott
210	John Resig
211	Luke Ruth
212	Brandon Trebitowski
213	Peter Small
214	Javid Jamae
215	Keith B. Wood
216	Ann M. Kelly
217	Rúnar Bjarnason
218	Michael Fogus
219	Joshua Noble
220	Laurent Mihalkovic
221	Peter Ledbrook
222	Noel Rappin
223	Aleksa Vukotic
224	Mala Gupta
225	Christopher R. Mitchell
226	Richard Scott Mark
227	Joe Lennon
228	Amit Rathore
229	Foreword by Paul Gaffney
230	Isidor Rivera
231	Jr
232	Eric Merritt
233	Martijn Dashorst
234	Max Carlson with Glenn MacEwen
235	Gojko Adzic
236	Levi Asher
237	Norman Klein
238	Richard Jacob
239	Eric Hexter
240	Donald Belcham
241	Jerome Louvel
242	David Sean Taylor
243	Rob Allen
244	Matthew Lee Hinman
245	Norris P. Smith
246	David Winterfeldt
247	Hanumant Deshmukh
248	John Stockton
249	Dagfinn Reiersøl with Marcus Baker
250	Stephen Holder
251	Kenneth P. Birman
252	Anna Tökke
253	Stuart McCulloch
254	Paul Randal
255	Regina Obe
256	Nicholas Dimiduk
257	Dave Johnson
258	Marsha Zaidman
259	Steve Loughran
260	Daniel Selman
261	Kenneth A. Kousen
262	Eelco Hillenius
263	Leo Hsu
264	Oliver Drobnik
265	Gary Gregory
266	Anthony Williams
267	Courtney Robinson
268	Teo Lachev
269	Claus Ibsen
270	Elijah Meeks
271	Marcus Hammarberg
272	Nicolas Leroux
273	Spencer Salazar
274	John Mount
275	JD \\Illiad\\ Frazer
276	Lasse Koskela
277	Ian W. Stirk
278	Jonathan Levine
279	Nick Heudecker
280	Daniel C. Lynch
281	Jason Carreira
282	introduced by Ted Lewis
283	Wynn Netherland
284	Joachim Haagen Skeie
285	Marc Harter
286	Stefano Mostarda
287	Chuck Lam
288	Jonathan Anstey
289	Balaji D Loganathan
290	Paul Nielsen
291	Guillaume Laforge
292	Scott Stanlick
293	Istvan Szegedi
294	Julian Hyde
295	Mike McQuaid
296	Nina Zumel
297	Thierry Boileau
298	Yehuda Katz
299	Wictor Wilén
300	Haralambos Marmanis
301	Benjamin L. Kovitz
302	Hamlet D'Arcy
303	Michael Hüttermann
304	Nathan Marz
305	Edited by Jeffery Hicks
306	Paul S. Randal
307	Thierry Templier
308	Jocelyn Harrington
309	David Cross
310	Kathryn Rotondo
311	Brian Ketelsen
312	MIchael Barlotta
313	Sean Owen
314	Nick Lo
315	Steven Gutz
316	Jignesh Malavia
317	Philipp K. Janert
318	Tomas Petricek
319	Karl Pauls
320	Ram Venkataraman
321	Greg Wanish
322	Clinton Begin
323	Norman Richards
324	Florian Müller
325	Oisin Grehan
326	Chris A. Mattmann
327	Ola Ellnestam
328	Benjamin G. Sullins
329	Tom Cervenka
330	Cole Krumbholz
331	Jacob K. Andresen
332	Kyle Lussier
333	Robert I. Kabacoff
334	Ramnivas Laddad
335	Michael S. Mikowski
336	Arthur Mateos
337	Simon Nash
338	Bruce Trask
339	Ben Vinegar
340	Erik St. Martin
341	Patrick Lee
342	Richard Brooks
343	Alex Holmes
344	Gal Shachor
345	with Michael Hausenblas
346	Perry Cook
347	Jonas Partner
348	Roland Kuhn
349	William Kennedy
350	William C. Wake
351	Joel Hooks
352	Dan Allen
353	Don Jones
354	Carl Simmons
355	Bruce Snyder
356	Bruce Simpson
357	Damian Conway
358	Jeffrey Palermo
359	Paula Beer
360	Leo S. Hsu
361	Benjamin Muschko
362	Alexandre de Castro Alves
363	Iain Shigeoka
364	Matthew Carver
365	Mike Clark
366	Peter Johnson
367	Ajay Kapur
368	Vlad Landres
369	Glen Smith
370	James Bannan
371	Simon Morris
372	James P. Gray
373	Charlie Collins
374	Dierk König
375	Derek Lane
376	Dejan Bosanac
377	Bruce Payette
378	Pierre Henri Kuate
379	Peter Fischer
380	Steven Haines
381	Tim Hawkins
382	Michael D. Galpin
383	Chad Michael Davis
384	Faisal Abid
385	Karen Bryla
386	Steve Eichert
387	Barry J. Shepherd
388	C. Wayne Brown
389	Simon Cozens
390	Duane K. Fields
391	Stefan Hepper
392	Jim Wooley
393	Stefan Ollinger
394	Julio C. Ody
395	Thomas W. Golway
396	Ge Wang
397	Matthew Hinze
398	Aleksandar Nikolic
399	Tariq Ahmed
400	Phillip Trelford
401	Paul Messick
402	George Franciscus
403	Jeremy Skinner
404	Monsur Hossain
405	Jesus Garcia
406	Jos Dirksen
407	Howard M. Lewis Ship
408	Robert Cooper
409	Adele Goldberg
410	Brendan G. Lim with Jerry Cheung
411	Bret Updegraff
412	Adam Chace
413	Matthew Scarpino
414	Gavin M. Roy
415	Kenneth McDonald
416	Ted Dunning
417	Brett Lonsdale
418	Matt Pearson
419	Edited by Paul Nielsen
420	Gavin King
421	Christian Crumlish
422	Tijs Rademakers
423	Alan Dennis
424	Paul King
425	Tim Hatton
426	John F. Smart
427	Jack Herrington
428	Bernerd Allmon
429	Michael Barlotta
430	Joe Walker
431	William R. Cockayne and Michael Zyda
432	Douglas W. Bennett
433	Alan Mycroft
434	Matthew D. Groves
435	Adam Benoit
436	Bear Bibeault
437	Dave Hrycyszyn
438	Dimitri Aivaliotis
439	Early Stephens
440	Kalen Delaney
441	Daniel Minoli
442	Andrew L. Johnson
443	Bruce Murray
444	Shaun Verch
445	Evan M. Hahn
446	Amanda Laucher
447	Prasad A. Chodavarapu
448	Jord Sonneveld and Bear Bibeault with Ted Goddard
449	Michael J. Barlotta
450	Reza Rahman
451	Michael Shoffner
452	G. Ann Campbell
453	Vikas Hazrati
454	Brandon Goodin
455	Fabrice Marguerie
456	Satnam Alag
457	Chris Hay
458	Dean Alan Hume
459	Vincent Massol
460	Anthony Patton
461	Tobin Harris
462	Rob Bakker
463	Jon Barrilleaux
464	Eric Pulier and Hugh Taylor
465	Trey Grainger
466	John D'Emic
467	Chris Eppstein
468	Grgur Grisogono
469	Rick Umali
470	Angel Roman
471	Chris Richardson
472	Bear P. Cahill
473	David Wood
474	Daniel G. McCreary
475	Pete Brown
476	Aslam Khan
477	Willie Wheeler with Joshua White
478	Jeffery D. Hicks
479	Harold Lorin
480	Peter Bakkum
481	Jeff Davis
482	Ryan Cuprak
483	Nicolas G. Bevacqua
484	Sam Ahn
485	Jamie Allen
486	Larry Meadors
487	Victor Romero
488	Chad A. Campbell
489	Jeremy McAnally
490	Michael Remijan
491	Jordan Hochenbaum
492	Emmanuel Bernard
493	Nishant Sivakumar
494	Robin Dunn
495	Regina O. Obe
496	Lawrence H. Rodrigues
497	Jared Armstrong
498	Dan Orlando
499	Cedric Dumoulin
500	James Warren
501	Christian Bauer
502	Marq Singer
503	Bruce Tate
504	Avi Pfeffer
505	Jeffery Hicks
506	Amandeep Khurana
507	Brad McGehee
508	Jimmy Bogard
509	Roy Osherove
510	Rob Davies
511	Richard Carlsson
512	Vincent Massol with Ted Husted
513	Kito D. Mann
514	Bruno Lowagie
515	Ted N. Husted
516	Tony DeLia
517	Jeff Potts
518	Paul Chiusano
519	Erik Bakker
520	Nicki Watt
521	Olivier Bazoud
522	Charles Collins
523	Massimo Perga
524	Ben Scheirman
525	Kimberly L. Tripp
526	Mark Wilson
527	Chris Shiflett
528	Ramarao Kanneganti
529	Douglas Garrett
530	Arnon Rotem-Gal-Oz
531	Cody Bumgardner
532	Claudio Martella
533	W. Frank Ableson
534	Michael Rosing
535	Aurelio De Rosa
536	Tracey Wilson
537	Nicholas Goodman
538	Ronny Richardson
539	Martin Evans
540	David A. Black
541	Robert Hanson
542	Ajamu A. Wesley
543	Rob Crowther
544	Kevin O'Malley
545	Craig Walls
546	Thomas S. Morton
547	Jason Essington
548	Daniele Bochicchio
549	James Shingler
550	Phil Wicklund
551	Magnus Rydin
552	Jeffrey Machols
553	Daniel Brolund
554	Lukas Ruebbelke
555	Michael Sync
556	Patrick Linskey
557	Ash Blue
558	Peter Harrington
559	Jim Jackson
560	Dionysios Logothetis
561	Darren Neimke
562	Randy Abernethy
563	Nathan Rajlich
564	and Edward Rabinovitch
565	Joshua Suereth
566	Craig Berntson
567	Theo Petersen
568	C. Enrique Ortiz
569	Rehan Zaidi
570	Carter Sande
571	Gary Scott Malkin
572	Derek Hamner
573	Stanford Ng
574	Brian H. Prince
575	Ahmed Sidky
576	Jukka L. Zitting
577	John E. Grayson
578	Chris King
\.


--
-- Data for Name: book_authors; Type: TABLE DATA; Schema: book; Owner: postgres
--

COPY book.book_authors (book_id, author_id) FROM stdin;
1	533
1	373
1	114
2	533
2	114
3	235
4	124
4	384
5	399
5	498
5	56
5	351
6	172
7	164
7	462
7	111
7	380
8	456
9	243
9	314
9	144
10	428
10	31
11	77
11	206
11	549
12	362
13	131
14	295
15	37
16	37
17	236
17	421
18	162
19	168
19	307
19	148
20	205
20	240
21	196
22	449
23	312
23	429
24	172
25	172
26	141
26	293
27	449
27	49
28	463
29	501
29	420
30	501
30	420
31	501
31	420
32	172
33	172
34	322
34	454
34	486
35	432
36	492
36	189
37	436
37	298
38	436
38	298
39	251
40	540
41	540
42	40
43	548
43	286
43	195
44	117
45	215
46	342
47	388
47	387
48	101
48	409
48	59
49	472
50	120
50	34
51	33
51	113
52	488
52	248
53	204
54	329
55	25
56	431
56	98
57	172
58	54
59	137
59	373
59	373
59	382
59	382
59	137
60	357
61	408
61	522
62	172
63	172
64	33
64	448
64	167
64	320
64	430
65	33
65	16
66	471
67	309
68	543
69	352
70	233
70	262
71	481
72	67
72	383
72	292
73	516
73	9
73	230
73	97
74	423
75	172
76	247
76	316
76	413
77	32
77	85
78	406
79	257
80	151
81	123
81	466
82	45
82	350
83	172
84	172
85	172
86	577
87	147
88	369
88	221
89	315
90	224
91	271
91	71
92	465
92	150
93	76
93	319
93	253
93	126
94	541
94	170
95	7
95	415
96	84
97	207
97	259
98	261
99	207
99	22
100	207
100	22
100	163
101	425
102	425
103	425
104	474
104	216
105	312
105	429
106	457
106	574
107	453
107	289
108	135
108	199
109	391
109	379
109	201
109	238
109	242
110	427
111	70
112	369
112	221
113	303
114	15
114	451
114	572
115	515
115	499
115	402
115	246
116	269
116	288
117	175
117	546
117	118
118	129
118	298
118	79
119	214
119	366
120	317
121	65
121	389
122	308
122	212
122	120
122	34
123	442
124	353
124	478
125	353
126	333
127	137
127	373
127	382
127	137
127	373
127	382
128	528
128	447
129	129
129	298
130	115
131	158
131	566
132	26
133	92
134	237
134	234
135	301
136	119
136	424
136	291
136	183
137	374
137	291
137	424
137	14
137	302
137	155
137	183
138	106
138	200
139	276
140	276
141	434
142	353
142	505
143	378
143	461
143	501
143	420
144	268
145	334
146	334
147	83
147	232
147	511
148	287
149	161
149	368
150	9
150	368
151	446
152	179
152	43
152	178
152	5
152	337
153	112
153	282
154	30
154	94
155	407
156	143
156	281
157	410
157	489
158	422
159	324
159	192
159	517
160	401
161	6
162	417
162	80
163	479
164	86
164	310
164	484
164	38
165	259
165	207
166	241
166	297
166	8
167	514
168	514
169	332
170	280
170	372
170	564
170	98
171	552
172	545
173	327
173	553
174	139
175	169
176	571
177	513
178	455
178	386
178	392
179	157
180	226
181	300
181	66
182	512
183	326
183	576
184	489
184	62
185	105
186	364
187	458
188	565
188	39
189	401
190	441
190	395
190	245
191	441
191	72
192	371
193	286
193	195
193	548
194	561
195	305
195	6
195	325
195	398
196	361
197	283
197	75
197	467
197	152
198	104
199	104
200	104
201	525
201	306
201	18
201	58
201	197
201	419
201	440
201	290
201	440
201	525
201	306
201	197
201	58
201	197
201	58
201	440
201	110
201	306
201	525
202	191
202	109
202	437
202	393
202	497
203	197
203	58
203	290
203	440
203	110
203	440
203	58
203	440
203	197
203	419
203	525
203	58
203	306
203	197
203	306
203	18
203	306
203	525
203	525
204	440
204	525
204	110
204	306
204	197
204	58
204	58
204	306
204	525
204	197
204	290
204	440
204	440
204	197
204	58
204	419
204	306
204	525
204	18
205	495
205	360
206	544
207	509
208	313
208	24
208	416
208	181
209	554
209	171
210	185
211	358
211	524
211	508
212	358
212	524
212	508
212	239
212	397
213	358
213	508
213	239
213	397
213	403
214	187
214	450
214	375
215	187
215	450
215	482
215	490
216	318
216	400
217	174
218	460
219	460
220	377
221	377
222	183
223	255
223	263
224	4
225	475
226	475
227	180
227	279
228	418
229	47
229	523
229	555
230	60
231	567
232	218
232	138
233	133
234	558
235	21
236	464
236	229
237	422
237	406
238	176
239	222
239	494
240	228
241	57
242	149
243	249
243	527
244	328
244	140
245	210
246	538
247	122
247	128
249	496
250	82
251	29
251	336
252	170
252	541
252	547
252	252
253	177
253	96
254	534
255	530
256	166
256	570
257	19
258	188
259	347
259	223
259	520
260	173
261	413
261	250
261	573
261	220
262	413
263	72
263	441
264	202
265	260
266	132
266	231
267	225
268	518
268	217
269	344
269	412
269	551
270	363
271	538
271	451
271	502
271	443
271	42
272	6
273	6
274	356
274	11
274	13
274	569
274	278
275	493
276	183
277	183
278	213
279	41
279	575
280	190
280	519
280	44
281	355
281	376
281	510
282	439
283	277
284	63
285	328
285	140
286	1
286	51
286	459
286	265
287	17
288	503
288	365
288	103
288	556
289	521
289	168
289	307
289	265
290	116
291	212
291	120
291	34
292	411
293	153
293	285
294	275
295	2
296	91
296	48
297	545
297	323
298	545
298	27
299	203
300	452
300	99
301	108
302	545
303	477
304	64
304	145
305	550
306	299
307	266
308	81
309	186
310	526
310	536
311	182
312	68
312	50
313	160
313	142
314	405
314	468
314	331
315	533
315	114
315	578
315	568
316	134
317	146
317	537
317	294
318	414
319	483
320	539
320	219
320	491
321	23
321	285
321	125
321	563
322	339
322	154
323	52
324	390
324	194
325	3
326	208
327	542
328	3
332	247
332	316
333	338
333	470
334	304
334	500
335	341
336	440
336	184
336	197
336	507
336	290
336	254
336	10
337	543
337	227
337	557
337	321
338	501
338	420
338	265
339	343
340	256
340	506
341	156
342	559
342	165
342	73
343	78
344	505
344	353
344	6
345	90
346	394
347	473
347	258
347	211
347	345
348	123
348	466
348	487
349	335
349	127
350	509
351	272
351	102
352	55
352	570
353	81
354	100
355	225
356	107
356	36
357	359
357	354
358	284
359	159
359	267
360	130
361	224
362	28
362	330
362	121
363	228
364	296
364	274
366	136
367	46
367	244
368	370
369	367
369	346
369	273
369	396
370	426
371	47
371	523
371	555
371	435
372	74
373	95
373	560
373	532
374	540
375	311
375	340
375	349
376	562
377	476
378	404
379	348
379	485
380	193
380	89
380	198
381	87
381	35
381	433
382	20
383	529
383	196
383	480
383	381
383	444
384	93
385	436
385	298
385	535
386	270
387	353
388	53
389	264
390	438
391	343
392	385
392	88
392	12
393	531
394	353
394	505
394	6
395	504
396	61
397	445
398	469
399	209
399	69
\.


--
-- Data for Name: book_categories; Type: TABLE DATA; Schema: book; Owner: postgres
--

COPY book.book_categories (book_id, category_id) FROM stdin;
1	18
1	6
2	28
3	32
4	35
5	35
6	28
8	35
9	34
10	35
11	28
12	28
13	35
15	34
16	35
17	21
18	16
19	28
20	33
21	9
22	5
23	37
23	5
24	28
25	28
27	5
28	28
28	26
29	28
30	28
31	28
32	28
33	28
34	34
35	17
35	14
36	28
37	34
38	28
39	29
39	36
40	34
41	19
42	35
43	16
44	12
46	5
47	26
48	19
49	11
50	34
51	4
51	35
52	16
53	12
54	5
55	23
56	35
57	28
58	33
59	11
59	11
60	3
60	14
61	34
62	28
63	28
64	34
65	34
66	28
67	8
68	35
69	28
70	34
71	28
72	28
73	37
74	35
74	16
75	28
76	35
77	28
78	25
79	35
80	35
81	32
81	28
82	28
83	28
84	28
85	28
86	12
87	16
88	28
89	28
93	35
94	28
94	35
95	12
96	16
97	28
97	35
98	28
99	28
100	28
100	18
101	5
102	28
103	5
105	37
105	5
106	16
107	32
108	13
109	28
110	19
111	35
113	32
114	28
115	28
115	35
116	28
117	32
119	28
120	26
121	8
122	11
123	8
125	16
126	32
127	11
127	11
128	32
129	35
130	26
131	16
132	23
133	35
133	29
133	20
134	34
135	32
135	36
136	28
137	28
138	1
139	32
140	28
143	16
144	16
145	28
146	28
147	19
148	28
149	23
149	37
150	23
150	37
151	16
152	28
153	37
154	14
155	28
155	35
156	24
157	19
158	32
162	16
163	23
163	32
164	34
165	28
166	35
167	34
168	28
169	26
170	32
170	36
171	28
174	8
175	28
176	35
177	28
178	16
179	16
180	35
181	34
182	28
183	28
184	19
185	23
189	19
190	37
190	29
191	37
191	29
192	28
193	16
194	33
197	34
198	19
199	19
200	28
200	37
200	35
201	16
201	16
201	16
203	16
203	16
203	16
204	16
204	16
204	16
205	35
206	19
207	32
208	28
211	16
212	16
213	16
214	28
215	28
217	35
217	36
217	4
218	23
219	28
220	33
221	33
225	16
226	33
226	31
227	28
228	15
229	11
230	28
231	8
231	37
233	16
234	32
235	16
236	36
237	23
238	28
239	12
240	28
241	28
242	14
243	27
244	28
245	28
246	23
247	28
248	28
248	35
249	28
250	29
251	35
252	28
254	36
255	10
256	19
256	12
257	28
258	28
261	28
262	19
263	35
263	29
264	16
265	28
265	35
265	30
266	35
269	28
269	35
270	35
270	28
271	28
272	16
273	16
274	28
274	23
275	33
276	16
277	16
278	35
278	36
279	32
281	28
282	23
282	37
283	16
284	28
285	28
286	28
287	28
287	23
287	22
288	28
288	35
289	2
290	28
290	35
291	11
292	33
294	21
295	26
295	8
296	32
297	4
297	28
298	28
299	28
302	28
303	28
303	7
304	28
304	35
305	16
306	16
307	16
309	28
309	35
310	4
310	35
311	37
311	29
312	34
321	34
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: book; Owner: postgres
--

COPY book.books (book_id, title, description, published_date, publisher_id, isbn, page_count, language_id, url_photo, created_at, modified_at) FROM stdin;
133	Kermit 95+	\N	2003-01-01	1	1930110057	406	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kermit.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
43	ASP.NET 4.0 in Practice	ASP.NET 4.0 in Practice contains real world techniques from well-known professionals who have been using ASP.NET since the first previews.	2011-05-15	1	1935182463	850	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bochicchio.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
44	Hello! Python	Hello! Python fully covers the building blocks of Python programming and gives you a gentle introduction to more advanced topics such as object oriented programming, functional programming, network programming, and program design. New (or nearly new) programmers will learn most of what they need to know to start using Python immediately.	2012-02-13	1	1935182080	716	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/briggs.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
1	Unlocking Android	Unlocking Android: A Developer's Guide provides concise, hands-on instruction for the Android operating system and development tools. This book teaches important architectural concepts in a straightforward writing style and builds on this with practical and useful examples throughout.	2009-04-01	1	1933988673	748	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ableson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
2	Android in Action, Second Edition	Android in Action, Second Edition is a comprehensive tutorial for Android developers. Taking you far beyond "Hello Android," this fast-paced book puts you in the driver's seat as you learn important architectural concepts and implementation strategies. You'll master the SDK, build WebKit apps using HTML 5, and even learn to extend or replace Android's built-in features by building useful and intriguing examples. 	2011-01-14	1	1935182722	764	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ableson2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
3	Specification by Example	\N	2011-06-03	1	1617290084	1041	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/adzic.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
4	Flex 3 in Action	\N	2009-02-02	1	1933988746	835	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ahmed.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
5	Flex 4 in Action	\N	2010-11-15	1	1935182420	403	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ahmed2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
6	Handling Protocols with the Net Component	\N	2005-03-01	1	1932394524c-e	804	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
7	Akka in Action	\N	\N	1	1617291013	809	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/roestenburg.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
8	Collective Intelligence in Action	\N	2008-10-01	1	1933988312	699	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/alag.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
9	Zend Framework in Action	Zend Framework in Action is a comprehensive tutorial that shows how to use the Zend Framework to create web-based applications and web services. This book takes you on an over-the-shoulder tour of the components of the Zend Framework as you build a high quality, real-world web application.	2008-12-01	1	1933988320	539	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/allen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
10	Flex on Java	   A beautifully written book that is a must have for every Java Developer.       Ashish Kulkarni, Technical Director, E-Business Software Solutions Ltd.	2010-10-15	1	1933988797	868	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/allmon.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
11	Griffon in Action	Griffon in Action is a comprehensive tutorial written for Java developers who want a more productive approach to UI development. In this book, you'll immediately dive into Griffon. After a Griffon orientation and a quick Groovy tutorial, you'll start building examples that explore Griffon's high productivity approach to Swing development. One of the troublesome parts of Swing development is the amount of Java code that is required to get a simple application off the ground.	2012-06-04	1	1935182234	789	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/almiray.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
12	OSGi in Depth	Enterprise OSGi shows a Java developer how to develop to the OSGi Service Platform Enterprise specification, an emerging Java-based technology for developing modular enterprise applications. Enterprise OSGi addresses several shortcomings of existing enterprise platforms, such as allowing the creation of better maintainable and extensible applications, and provide a simpler, easier-to-use, light-weight solution to enterprise software development.	2011-12-12	1	193518217X	407	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/alves.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
13	JSTL in Action	\N	2002-07-01	1	1930110529	850	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bayern.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
14	Git in Practice	\N	\N	1	1617291978	836	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mcquaid.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
15	Flexible Rails	"Flexible Rails created a standard to which I hold other technical books. You definitely get your money's worth."	2008-01-01	1	1933988509	1093	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/armstrong.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
16	Hello! Flex 4	Hello! Flex 4 progresses through 26 self-contained examples selected so you can progressively master Flex. They vary from small one-page apps, to a 3D rotating haiku, to a Connect Four-like game. And in the last chapter you'll learn to build a full Flex application called SocialStalkr   a mashup that lets you follow your friends by showing their tweets on a Yahoo map.	2009-11-01	1	1933988762	496	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/armstrong3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
17	Coffeehouse	Coffeehouse is an anthology of stories, poems and essays originally published on the World Wide Web.	1997-07-01	1	1884777384	405	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/asher.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
18	Team Foundation Server 2008 in Action	\N	2008-12-01	1	1933988592	1052	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/azher.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
19	Spring Dynamic Modules in Action	Spring Dynamic Modules in Action introduces Spring DM and OSGi to Java EE developers and architects. It presents the fundamental concepts of OSGi-based apps and maps them to the familiar ideas of the Spring framework. Then, it engages you with the techniques and concepts you'll need to develop stable, flexible enterprise apps. You'll learn how to embed a Spring container inside an OSGi bundle, and how Spring DM lets you blend Spring strengths like dependency injection with OSGi-based services. Along the way, you'll see how Spring DM handles data access and web-based components, and you'll explore topics like unit testing and configuration in an OSGi-based environment.	2010-09-04	1	1935182307	967	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/cogoluegnes.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
45	Extending jQuery	\N	2013-08-12	1	161729103X	495	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/wood.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
20	Brownfield Application Development in .NET	Brownfield Application Development in .Net shows you how to approach legacy applications with the state-of-the-art concepts, patterns, and tools you've learned to apply to new projects. Using an existing application as an example, this book guides you in applying the techniques and best practices you need to make it more maintainable and receptive to change.	2010-04-16	1	1933988711	1031	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/baley.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
21	MongoDB in Action	MongoDB In Action is a comprehensive guide to MongoDB for application developers. The book begins by explaining what makes MongoDB unique and describing its ideal use cases. A series of tutorials designed for MongoDB mastery then leads into detailed examples for leveraging MongoDB in e-commerce, social networking, analytics, and other common applications.	2011-12-12	1	1935182870	808	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/banker.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
22	Distributed Application Development with PowerBuilder 6.0	\N	1998-06-01	1	1884777686	1063	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
23	Jaguar Development with PowerBuilder 7	Jaguar Development with PowerBuilder 7 is the definitive guide to distributed application development with PowerBuilder. It is the only book dedicated to preparing PowerBuilder developers for Jaguar applications and has been approved by Sybase engineers and product specialists who build the tools described in the book.	1999-08-01	1	1884777864	762	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/barlotta2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
24	XML Parsing with Digester	\N	2005-03-01	1	1932394524d-e	597	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal4.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
25	JXPath and Betwixt: Working with XML	\N	2005-03-01	1	1932394524e-e	1072	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal5.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
26	Impala in Action	\N	\N	1	1617291986	994	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/saltzer.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
27	Taming Jaguar	\N	2000-07-01	1	1884777687	836	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/barlotta3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
28	3D User Interfaces with Java 3D	\N	2000-08-01	1	1884777902	1095	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/barrilleaux.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
29	Hibernate in Action	"2005 Best Java Book!" -- Java Developer's Journal	2004-08-01	1	193239415X	514	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bauer.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
30	Hibernate in Action (Chinese Edition)	\N	1999-06-01	1	9781932394153	849	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bauer-cn.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
31	Java Persistence with Hibernate	"...this book is the ultimate solution. If you are going to use Hibernate in your application, you have no other choice, go rush to the store and get this book." --JavaLobby	2006-11-01	1	1932394885	754	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bauer2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
32	Validating Data with Validator	\N	2005-03-01	1	1932394524f-e	632	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal6.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
33	Enhancing Java Core Libraries with Collections	\N	2005-03-01	1	1932394524g-e	572	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal7.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
34	iBATIS in Action	   Gets new users going and gives experienced users in-depth coverage of advanced features.       Jeff Cunningham, The Weather Channel Interactive	2007-01-01	1	1932394826	958	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/begin.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
35	Designing Hard Software	"This book is well written ... The author does not fear to be controversial. In doing so, he writes a coherent book." --Dr. Frank J. van der Linden, Phillips Research Laboratories	1997-02-01	1	133046192	615	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
36	Hibernate Search in Action	"A great resource for true database independent full text search." --Aaron Walker, base2Services	2008-12-21	1	1933988649	704	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bernard.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
37	jQuery in Action	"The best-thought-out and researched piece of literature on the jQuery library." --From the forward by John Resig, Creator of jQuery	2008-01-01	1	1933988355	959	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bibeault.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
38	jQuery in Action, Second Edition	jQuery in Action, Second Edition is a fast-paced introduction to jQuery that will take your JavaScript programming to the next level. An in-depth rewrite of the bestselling first edition, this edition provides deep and practical coverage of the latest jQuery and jQuery UI releases. The book's unique "lab pages" anchor the explanation of each new concept in a practical example. You'll learn how to traverse HTML documents, handle events, perform animations, and add Ajax to your web pages. This comprehensive guide also teaches you how jQuery interacts with other tools and frameworks and how to build jQuery plugins. 	2010-06-01	1	1935182323	591	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bibeault2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
39	Building Secure and Reliable Network Applications	"... tackles the difficult problem of building reliable distributed computing systems in a way that not only presents the principles but also describes proven practical solutions." --John Warne, BNR Europe	1996-01-01	1	1884777295	366	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/birman.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
40	Ruby for Rails	The word is out: with Ruby on Rails you can build powerful Web applications easily and quickly! And just like the Rails framework itself, Rails applications are Ruby programs. That means you can   t tap into the full power of Rails unless you master the Ruby language.	2006-05-01	1	1932394699	427	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/black.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
41	The Well-Grounded Rubyist	What would appear to be the most complex topic of the book is in fact surprisingly easy to assimilate, and one realizes that the efforts of the author to gradually lead us to a sufficient knowledge of Ruby in order to tackle without pain the most difficult subjects, bears its fruit.       Eric Grimois, Developpez.com	2009-04-01	1	1933988657	339	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/black2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
42	Website Owner's Manual	Website Owner's Manual helps you form a vision for your site, guides you through the process of selecting a web design agency, and gives you enough background information to make intelligent decisions throughout the development process. This book provides a jargon-free overview of web design, including accessibility, usability, online marketing, and web development techniques. You'll gain a practical understanding of the technologies, processes, and ideas that drive a successful website.	2009-10-01	1	1933988452	616	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/boag.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
46	PFC Programmer's Reference Manual	\N	1998-06-01	1	1884777554	408	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/brooks.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
47	Graphics File Formats	\N	1995-06-01	1	133034054	1076	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/brown.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
48	Visual Object Oriented Programming	\N	1995-02-01	1	131723979	358	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/burnett.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
49	iOS in Practice	\N	2013-11-01	1	1617291269	722	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/cahill.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
50	iPhone in Action	   There is not another iPhone title that does such a great coverage of both Web and SDK topics under one roof, thus providing a well-rounded developer education.       Vladimir Pasman, Cocoacast.com	2008-12-01	1	193398886X	959	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/callen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
51	Ajax in Action	\N	2005-10-01	1	1932394613	617	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/crane.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
52	Silverlight 2 in Action	   Silverlight 2 in Action gives you a solid, well-thought out and coherent foundation for building RIA web applications, and provides you with lots of technical details without ever becoming cloudy.       Golo Roden, author, trainer and speaker for .NET technologies	2008-10-31	1	1933988428	828	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/campbell.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
53	The Quick Python Book, Second Edition	This revision of Manning's popular The Quick Python Book offers a clear, crisp introduction to the elegant Python programming language and its famously easy-to-read syntax. Written for programmers new to Python, this updated edition covers features common to other languages concisely, while introducing Python's comprehensive standard functions library and unique features in detail.	2010-01-01	1	193518220X	482	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ceder.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
54	Internet and Intranet Applications with PowerBuilder 6	\N	2000-12-01	1	1884777600	1024	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/cervenka.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
55	Practical Methods for Your Year 2000 Problem	Practical Methods for Your Year 2000 Problem gives the Year 2000 project team a step-by-step methodology for addressing the Year 2000 problem.	1998-01-01	1	188477752X	681	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
56	Mobile Agents	Mobile Agents is the first book to give the reader the ability to create and use powerful mobile agents on the Internet.	1997-03-01	1	1884777368	725	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/cockayne.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
57	Command-line Processing with CLI	\N	2005-03-01	1	1932394524l-e	756	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal12.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
58	SQL Server 2008 Administration in Action	\N	2009-08-01	1	193398872X	701	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/colledge.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
59	Android in Practice	Android in Practice is treasure trove of Android goodness, with over 100 tested, ready-to-use techniques including complete end-to-end example applications and practical tips for real world mobile application developers. Written by real world Android developers, this book addresses the trickiest questions raised in forums and mailing lists. Using an easy-to-follow problem/solution/discussion format, it dives into important topics not covered in other Android books, like advanced drawing and graphics, testing and instrumentation, building and deploying applications, using alternative languages, and native development.	2011-09-30	1	1935182927	332	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/collins.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
60	Object Oriented Perl	\N	1999-08-01	1	1884777791	826	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/conway.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
61	GWT in Practice	\N	2008-04-01	1	1933988290	758	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/cooper.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
62	Understanding and Using Chain	\N	2005-03-01	1	1932394524m-e	1065	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal13.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
63	Working with the Logging and Discovery Components	\N	2005-03-01	1	1932394524n-e	845	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal14.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
64	Ajax in Practice	\N	2007-06-01	1	1932394990	337	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/crane2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
65	Prototype and Scriptaculous in Action	\N	2007-04-01	1	1933988037	353	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/crane3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
66	POJOs in Action	"POJOs in Action is required reading for battle-weary EJB developers and for new developers who want to avoid the sins of the fathers by using lightweight frameworks.    -- C# Online.NET	2006-01-01	1	1932394583	915	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/crichardson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
67	Data Munging with Perl	\N	2001-01-01	1	1930110006	407	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/cross.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
68	Hello! HTML5 & CSS3	Quick and Easy HTML5 and CSS3 is written for the web designer or developer who wants a fast, example-oriented introduction to the new HTML and CSS features. After a quick review of the basics, you'll turn to what's new. Start by learning to apply important new elements and attributes by building your first real HTML5 pages. You'll then take a quick tour through the new APIs: Form Validation, Canvas, Drag & Drop, Geolocation and Offline Applications. You'll also discover how to include video and audio on your pages without plug-ins, and how to draw interactive vector graphics with SVG.	2012-10-17	1	1935182897	1012	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/crowther.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
69	Seam in Action	Seam in Action goes into great detail on the ways in which Seam helps reduce the burden of integration with different technologies such as Hibernate and JSF, allowing the developer to focus on the core business objective at hand.       Shobana Jayaraman, Digital Infrastructure Analyst, University of Texas Southwestern Medical Center Library, The Tech Static	2008-08-01	1	1933988401	445	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dallen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
70	Wicket in Action	\N	2008-08-01	1	1932394982	1053	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dashorst.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
71	Open Source SOA	\N	2009-05-01	1	1933988541	578	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/davis.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
72	Struts 2 in Action	\N	2008-05-01	1	193398807X	504	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dbrown.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
73	Essential Guide to Peoplesoft Development and Customization	\N	2000-08-01	1	1884777929	544	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/delia.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
74	.NET Multithreading	\N	2002-11-01	1	1930110545	587	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dennis.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
75	Uploading files with FileUpload	\N	2005-03-01	1	1932394524b-e	692	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
76	SCWCD Exam Study Kit Second Edition	\N	2005-05-01	1	1932394389	624	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/deshmukh2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
77	Spring Roo in Action	\N	2012-04-13	1	193518296X	470	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rimple.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
78	SOA Governance in Action	\N	2012-07-27	1	1617290270	363	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dirksen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
79	RSS and Atom in Action	\N	2006-03-01	1	1932394494	441	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dmjohnson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
80	LDAP Programming, Management and Integration	\N	2002-11-01	1	1930110405	493	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/donley.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
81	Mule in Action	\N	2009-07-01	1	1933988967	896	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dossot.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
82	Java Foundation Classes	\N	2001-10-01	1	1884777678	338	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/drye.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
83	Managing Components with Modeler	\N	2005-03-01	1	1932394524k-e	747	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal11.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
84	Enhancing Java Core Libraries with BeanUtils and Lang	\N	2005-03-01	1	1932394524h-e	955	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal8.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
85	Pool and DBCP: Creating and Using Object Pools	\N	2005-03-01	1	1932394524i-e	770	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal9.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
86	Python and Tkinter Programming	\N	2000-01-01	1	1884777813	915	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/grayson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
87	Microsoft.NET for Programmers	\N	2002-12-01	1	1930110197	970	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/grimes.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
88	Grails in Action	Grails in Action is a comprehensive guide to the Grails framework. First, the basics: the domain model, controllers, views, and services. Then, the fun! Dive into a Twitter-style app with features like AJAX/JSON, animation, search, wizards   even messaging and Jabber integration. Along the way, you'll discover loads of great plugins that'll make your app shine. Learn to integrate with existing Java systems using Spring and Hibernate. You'll need basic familiarity with Java and the web.	2009-05-01	1	1933988932	773	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/gsmith.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
89	Up to Speed with Swing, Second Edition	Now in its Second Edition, Up to Speed with Swing is for you if you want to get on the fast track to Java Swing. The second edition has been extensively updated to cover Java 1.2 with additional code examples and illustrations.	1999-10-01	1	1884777759	1099	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/gutz2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
90	OCA Java SE 7 Programmer I Certification Guide	\N	2013-04-02	1	1617291048	839	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/gupta.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
91	Kanban in Action	\N	2014-03-04	1	1617291056	608	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hammarberg.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
92	Solr in Action	\N	2014-03-25	1	1617291021	893	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/grainger.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
93	OSGi in Action	OSGi in Action is a comprehensive guide to OSGi with two primary goals. First, it provides a clear introduction to OSGi concepts with examples that are relevant both for architects and developers. The central idea of OSGi is modularity, so you start by learning about OSGi bundles. You'll then see how OSGi handles module lifecycles and follow up with how it promotes service-oriented interaction among application components.	2011-04-06	1	1933988916	675	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hall.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
94	GWT in Action	\N	2007-06-01	1	1933988231	691	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hanson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
95	The Quick Python Book	\N	1999-10-01	1	1884777740	426	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/harms.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
96	SharePoint 2010 Site Owner's Manual	SharePoint 2010 Site Owner's Manual starts by assuming you already have SharePoint installed on your system and are looking for ways to solve the problems you face every day in your organization. You'll learn to determine what type of SharePoint installation you have   Microsoft Office SharePoint Server (MOSS), Windows SharePoint Services (WSS), the "Fabulous 40" templates   and what features are at your disposal. Once you know the lay of the land, you'll discover what you can do yourself, when you need to call in some help, and when you should leave it to the developers.	2012-02-13	1	1933988754	509	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/harryman.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
97	Java Development with Ant	The most widely used build tool for Java projects, Ant is cross-platform, extensible, simple, and fast. It scales from small personal projects to large, multi-team J2EE projects. And, most important, it's easy to learn.	2002-08-01	1	1930110588	761	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hatcher.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
98	Making Java Groovy	Making Java Groovy is a practical handbook for developers who want to blend Groovy into their day-to-day work with Java. It starts by introducing the key differences between Java and Groovy   and how you can use them to your advantage. Then, it guides you step-by-step through realistic development challenges, from web applications to web services to desktop applications, and shows how Groovy makes them easier to put into production.	2013-09-19	1	1935182943	599	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kousen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
99	Lucene in Action	\N	2004-12-01	1	1932394281	996	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hatcher2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
100	Lucene in Action, Second Edition	With clear writing, reusable examples, and unmatched advice on best practices, Lucene in Action is still the definitive guide to developing with Lucene.	2010-07-09	1	1933988177	998	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hatcher3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
121	Extending and Embedding Perl	\N	2002-08-01	1	1930110820	703	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jenness.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
387	Learn SQL Server Administration in a Month of Lunches	\N	2014-05-02	1	1617292133	1023	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jones5.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
101	PowerBuilder 6.0 Questions & Answers	If you'd like to learn PowerBuilder--or enhance your skills-- this book is for you. Its hands-on approach will show you how to write real code. Each section takes a specific "How do I " topic and answers commonly asked questions in an easy-to-understand, conversational manner. It then shows you how the same technique can be used over and over again to decrease your overall code-writing time.	1998-07-01	1	1884777708	616	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hatton.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
102	The Awesome Power of PowerJ	The Awesome Power of PowerJ shows you how you can write Java programs the very first day with PowerJ, even if you don't know Java. Through a hands-on approach that makes liberal use of figures and code snippets, you will learn how to use PowerJ to build effective Java applets and applications.	1998-05-01	1	1884777538	759	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hatton2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
103	The Awesome Power of Power++	The Awesome Power of Power++ is for the beginning to intermediate Power++ programmer. It assumes that you have little or no knowledge of the C++ language but that you do know programming constructs. The purpose is to teach you how to use Power++ to build C++ applets and applications even if you are not a C++ expert. To this end it takes a hands-on approach and makes liberal use of figures and code snippets.	1998-06-01	1	1884777546	889	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hatton3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
104	Making Sense of NoSQL	\N	2013-09-03	1	1617291072	1071	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mccreary.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
105	Jaguar Development with PowerBuilder 7	\N	1999-08-09	1	1884777866	495	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
106	Azure in Action	Azure in Action is a fast-paced tutorial intended for architects and developers looking to develop on Windows Azure and the Windows Azure Platform. It's designed both for readers new to cloud concepts and for those familiar with cloud development but new to Azure. After a quick walk through the basics, it guides you all the way from your first app through more advanced concepts of the Windows Azure Platform.	2010-10-22	1	193518248X	490	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hay.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
107	Distributed Agile in Action	Distributed Agile in Action is the first book to directly address the unique task of going Agile in a distributed team. Rather than rehashing Agile theories, this book supplies the practical examples and step by step advice you need to help your distributed teams adopt and embrace Agile principles. It's a distilled and carefully organized learning aid for working in a distributed Agile environment, with in-depth focus on how to approach three critical components of development-People, Process and Technology.	\N	1	1935182412	420	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hazrati.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
108	Metaprogramming in .NET	\N	2012-12-31	1	1617290262	789	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hazzard.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
109	Portlets and Apache Portals	Portlets and Apache Portals was not published by Manning, but the manuscript is available for download from our website "as is."	2005-10-01	1	1932394540	453	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hepper.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
110	Code Generation in Action	Code Generation In Action covers building database access, user interface, remote procedure, test cases, and business logic code as well as code for other key system functions.	2003-07-01	1	1930110979	1046	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/herrington.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
111	Illustrated Guide to HTTP	\N	1997-03-01	1	138582262	510	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hethmon.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
112	Grails in Action, Second Edition	\N	\N	1	1617290963	417	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/gsmith2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
113	Agile ALM	Many software projects fail unnecessarily because of unclear objectives, redundant and unproductive work, cost overruns, and a host of other avoidable process problems. In response, agile processes and lightweight tooling have begun to replace traditional engineering processes throughout the development lifecycle. An agile approach to application lifecycle management improves product quality, reduces time to market, and makes for happier developers.    Agile ALM is a guide for Java developers who want to integrate flexible agile practices and lightweight tooling along all phases of the software development process. The book introduces a new vision for managing change in requirements and process more efficiently and flexibly. You'll learn powerful practices like task-based Development, where you align activities into tasks resulting in traceable artifacts, Continuous Integration, in which you frequently and systematically integrate, build, and test an application in development and using Scrum as an agile approach to release management. The effect is a more comprehensive and practical approach to build, configuration, deployment, release, test, quality, integration, and requirements management.    This book synthesizes technical and functional elements to provide a comprehensive approach to software development. You'll learn to see the whole scope of the development process as a set of defined tasks, many of which are repeated daily, and then master the tools and practices you need to accomplish each of those tasks efficiently.    Because efficient tool chains can radically improve the speed and fluidity of the development process, this book demonstrates how to integrate state-of-the-art lightweight tools. Many of the tools and examples are Java-based, but the Agile ALM principles apply to all development platforms. As well, the many examples show how you can bridge different languages and systems.	2011-08-20	1	1935182633	461	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/huettermann.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
114	Java Network Programming, Second Edition	\N	1999-05-01	1	188477749X	499	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hughes.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
115	Struts in Action	\N	2002-10-01	1	1932394249	744	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/husted.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
116	Camel in Action	Camel in Action is for developers working with integration of any kind. This highly practical book introduces Camel and shows examples of how to use it with the 45+ supported enterprise integration patterns. Written by the people who wrote the Camel code, it's up to date and distills details and insights that only people deeply involved with Camel could provide.	2011-01-04	1	1935182366	483	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ibsen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
117	Taming Text	Taming Text is a hands-on, example-driven guide to working with unstructured text in the context of real-world applications. This book explores how to automatically organize text using approaches such as full-text search, proper name recognition, clustering, tagging, information extraction, and summarization. The book guides you through examples illustrating each of these topics, as well as the foundations upon which they are built.	2012-12-31	1	193398838X	779	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ingersoll.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
118	Rails 4 in Action	\N	\N	1	1617291099	607	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bigg2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
119	JBoss in Action	\N	2009-01-01	1	1933988029	573	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jamae.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
120	Gnuplot in Action	\N	2009-08-01	1	1933988398	816	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/janert.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
122	iOS 4 in Action	iOS 4 in Action, written for Xcode 4, is a detailed, hands-on guide that goes from setting up your development environment, through your first coding steps, all the way to creating a polished, commercial iOS 4 application. You'll run through examples from a variety of areas including a chat client, a video game, an interactive map, and background audio. You'll also learn how the new iOS 4 features apply to your existing iOS 3 based apps. This book will help you become a confident, well-rounded iOS 4 developer.	2011-06-09	1	1617290017	447	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jharrington.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
123	Elements of Programming with Perl	\N	1999-10-01	1	1884777805	1083	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/johnson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
124	Learn Windows PowerShell in a Month of Lunches, Second Edition	\N	2012-11-12	1	1617291080	603	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jones3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
125	Learn Windows PowerShell in a Month of Lunches	Learn Windows PowerShell in a Month of Lunches is an innovative tutorial designed for busy administrators. Author Don Jones has taught thousands of administrators to use PowerShell, and now he'll teach you, bringing his years of training techniques to a concise, easy-to-follow book. Just set aside one hour a day   lunchtime would be perfect   for an entire month, and you'll be automating administrative tasks faster than you ever thought possible. Don combines his own in-the-trenches experience with years of PowerShell instruction to deliver the most important, effective, and engaging elements of PowerShell to you quickly and painlessly, setting you on the path to a career-boosting future.	2011-04-15	1	1617290211	911	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jones.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
126	R in Action	R in Action is the first book to present both the R system and the use cases that make it such a compelling package for business developers. The book begins by introducing the R language, including the development environment. As you work through various examples illustrating R's features, you'll also get a crash course in practical statistics, including basic and advanced models for normal and non-normal data, longitudinal and survival data, and a wide variety of multivariate methods. Both data mining methodologies and approaches to messy and incomplete data are included.	2011-08-15	1	1935182390	532	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kabacoff.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
127	Android in Practice	\N	\N	1	9781935182924	779	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kaeppler.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
128	SOA Security	\N	2007-12-01	1	1932394680	1072	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kanneganti.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
129	Rails 3 in Action	Rails 3 in Action will provide a thorough introduction to Ruby-based web development using Rails. Like Rails 3 itself, this book combines Merb and Rails in the form of authors Yehuda Katz, Merb Lead Developer.	2011-09-20	1	1935182277	530	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/katz.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
130	The Awesome Power of Direct3D/DirectX	The Awesome Power of Direct3D/DirectX shows you how to build a complete working 3D application, including 3D sound, joystick input, animation, textures, shadows, and even collision detection.	2002-12-01	1	1884777473	737	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kovach.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
131	Continuous Integration in .NET	Continuous Integration in .NET is a tutorial for developers and team leads that teaches you to reimagine your development strategy by creating a consistent continuous integration process. This book shows you how to build on the tools you already know--.NET Framework and Visual Studio and to use powerful software like MSBuild, Subversion, TFS 2010, Team City, CruiseControl.NET, NUnit, and Selenium.	2011-03-14	1	1935182552	951	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kawalerowicz.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
132	Technology Paradise Lost	In Technology Paradise Lost Keller describes how the new thinking is working inside some of the country's most complex and successful organizations, including Merrill Lynch, JetBlue, Harrah's, and Motorola which have cut IT spending to gain a competitive edge, and experienced marked gains to their bottom lines.	2004-03-01	1	1932394133	603	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/keller.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
134	Laszlo in Action	\N	2008-01-01	1	1932394834	972	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/klein.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
135	Practical Software Requirements	\N	1998-09-01	1	1884777597	980	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kovitz.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
136	Groovy in Action	\N	2007-01-01	1	1932394842	835	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/koenig.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
137	Groovy in Action, Second Edition	Groovy in Action, Second Edition is a thoroughly-revised, comprehensive guide to Groovy programming. It introduces Java developers to the dynamic features that Groovy provides, and shows you how to apply Groovy to a range of tasks including building new apps, integration with existing code, and DSL development.	\N	1	1935182447	470	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/koenig2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
138	Object Technology Centers of Excellence	Object Technology Centers of Excellence provides guidance to those charged with managing the shift to object technology. It is the only book on the market aimed not at the project level but at the corporate level, with a focus on the infrastructures necessary for a successful transition.	1996-06-01	1	132612313	561	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/korson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
139	Test Driven	\N	2007-09-01	1	1932394850	591	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/koskela.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
140	Effective Unit Testing	\N	2013-02-04	1	1935182579	633	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/koskela2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
141	AOP in .NET	\N	2013-06-21	1	1617291145	904	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/groves.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
142	Learn PowerShell Toolmaking in a Month of Lunches	\N	2012-12-12	1	1617291161	783	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jones4.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
143	NHibernate in Action	\N	2009-02-01	1	1932394923	607	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kuate.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
144	Microsoft Reporting Services in Action	\N	2004-08-01	1	1932394222	320	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lachev.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
145	AspectJ in Action	\N	2003-07-01	1	1930110936	837	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/laddad.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
384	Getting MEAN with Mongo, Express, Angular, and Node	\N	\N	1	1617292036	990	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sholmes.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
146	AspectJ in Action, Second Edition	AspectJ in Action, Second Edition is a fully updated, major revision of Ramnivas Laddad's best-selling first edition. It's a hands-on guide for Java developers. After introducing the core principles of AOP, it shows you how to create reusable solutions using AspectJ 6 and Spring 3. You'll master key features including annotation-based syntax, load-time weaver, annotation-based crosscutting, and Spring-AspectJ integration. Building on familiar technologies such as JDBC, Hibernate, JPA, Spring Security, Spring MVC, and Swing, you'll apply AOP to common problems encountered in enterprise applications.	2009-09-01	1	1933988053	308	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/laddad2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
147	Erlang and OTP in Action	Erlang and OTP in Action teaches you to apply Erlang's shared-state model for concurrent programming--a completely different way of tackling the problem of parallel programming from the more common multi-threaded approach. This book walks you through the practical considerations and steps of building systems in Erlang and integrating them with real-world C/C++, Java, and .NET applications. Unlike other books on the market, Erlang and OTP in Action offers a comprehensive view of how concurrency relates to SOA and web technologies.	2010-11-16	1	1933988789	545	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/logan.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
148	Hadoop in Action	Hadoop in Action teaches readers how to use Hadoop and write MapReduce programs. The intended readers are programmers, architects, and project managers who have to process large amounts of data offline. Hadoop in Action will lead the reader from obtaining a copy of Hadoop to setting it up in a cluster and writing data analytic programs.	2010-12-01	1	1935182196	734	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lam.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
149	SQR in PeopleSoft and Other Applications	\N	2003-09-01	1	1884777775	603	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/landres.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
150	SQR in PeopleSoft and Other Applications, Second Edition	\N	2003-09-01	1	1932394001	770	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/landres2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
151	F# in Action	F# in Action introduces the F# language, but it goes well beyond the standard tutorial and reference approach. F# expert Amanda Laucher draws on her extensive experience deploying F#-based solutions to show you how to use F# in real, day-to-day work.	\N	1	1935182250	357	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/laucher.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
152	Tuscany SCA in Action	Tuscany in Action is a comprehensive, hands-on guide for developing technology agnostic, extensible applications using Apache Tuscany's lightweight SCA infrastructure. The book uses practical examples based on a travel booking scenario to demonstrate how to develop applications with Tuscany SCA. Apache Tuscany supports a variety of programming environments, data bindings and communication protocols "out of the box" and can be easily extended to support other technologies.	2011-02-12	1	1933988894	505	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/laws.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
153	Client/Server Yellow Pages	This unique guide covers software products and vendors active in the client/server marketplace. Over 200 products and over 250 vendors are included.	1995-01-01	1	1884777082	341	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lewis.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
154	Object Oriented Application Frameworks	Frameworks are object-oriented programming environments for vertical application areas. This book is the first to survey this exciting new technology, its concepts, and practical applications.	1995-04-01	1	1884777066	446	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lewis2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
155	Tapestry in Action	\N	2004-03-01	1	1932394117	769	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lewisship.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
156	WebWork in Action	\N	2005-09-01	1	1932394532	611	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lightbody.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
157	MacRuby in Action	\N	2012-04-11	1	1935182498	767	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lim.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
158	Activiti in Action	\N	2012-07-12	1	1617290122	1004	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rademakers2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
159	CMIS and Apache Chemistry in Action	\N	\N	1	1617291153	367	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mueller.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
160	Action Guide (aka VB .NET)	\N	\N	1	1930110324	609	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
161	Learn Active Directory Management in a Month of Lunches	\N	\N	1	1617291196	746	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/siddaway3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
162	SharePoint 2007 Developer's Guide to Business Data Catalog	SharePoint 2007 Developer's Guide to Business Data Catalog is a practical, example-rich guide to the features of the BDC and the techniques you need to build solutions for end users. The book starts with the basics   what the BDC is, what you can do with it, and how to pull together a BDC solution. With the fundamentals in hand, it explores the techniques and ideas you need to put BDC into use effectively in your organization.	2009-09-09	1	1933988819	608	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lonsdale.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
163	Doing IT Right	Doing IT Right explores IT in its full complexity. It explains fundamental issues of hardware and software structures; it illuminates central issues of networking and encapsulates the essence of client/server computing; its coverage of costing, risk assessment, and due diligence in making computing decisions is unique.	1995-12-01	1	133964256	758	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lorin.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
164	Adobe AIR in Action	\N	2008-07-01	1	1933988487	323	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lott.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
165	Ant in Action	The most widely used build tool for Java projects, Ant is cross-platform, extensible, simple, and fast. It scales from small personal projects to large, multi-team enterprise projects. And, most important, it   s easy to learn.	2007-07-01	1	193239480X	639	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/loughran.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
378	CORS in Action	\N	\N	1	161729182X	429	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hossain.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
379	Reactive Design Patterns	\N	\N	1	1617291803	360	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kuhn.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
382	Elixir in Action	\N	\N	1	161729201X	752	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/juric.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
385	jQuery in Action, Third Edition	\N	\N	1	1617292079	701	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/derosa.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
166	Restlet in Action	Restlet in Action gets you started with the Restlet Framework and the REST architecture style. You'll create and deploy applications in record time while learning to use popular RESTful Web APIs effectively. This book looks at the many faces of web development, including server- and client-side, along with cloud computing, mobile Android devices, and semantic web applications. It offers a particular focus on Google's innovative Google Web Toolkit, Google App Engine, and Android technologies.	2012-09-26	1	193518234X	968	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/louvel.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
167	iText in Action	"I've been using iText for over a year, but I still learnt an awful lot while reading this book." --JavaLobby	2006-11-01	1	1932394796	821	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lowagie.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
168	iText in Action, Second Edition	iText in Action, Second Edition offers an introduction and a practical guide to iText and the internals of PDF. While at the entry level iText is easy to learn, there's an astonishing range of things you can do once you dive below the surface. This book lowers the learning curve and, though numerous innovative and practical examples, unlocks the secrets hidden in Adobe's PDF Reference. The examples are in Java but they can be easily adapted to .NET using one of iText's .NET ports: iTextSharp or iText.NET.	2010-11-22	1	1935182617	467	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lowagie2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
169	Power-3D	\N	1997-10-01	1	138412146	570	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lussier.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
170	SNA and TCP/IP Enterprise Networking	SNA and TCP/IP Enterprise Networking shows the reader how enterprise networking evolved, what approaches and techniques can be used today, and where tomorrow's trends lie, illustrating among others Web-to-SNA connectivity and Java based integration approaches.	1997-09-01	1	131271687	427	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lynch.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
171	Subversion in Action	Learn all about this new open source version control application and why it is replacing CVS as the standard. Examples demonstrate how to customize features to deal with day-to-day problems.	2004-12-01	1	1932394478	375	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/machols.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
172	Spring in Action, Fourth Edition	\N	\N	1	161729120X	796	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/walls5.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
173	The Mikado Method	\N	2014-03-05	1	1617291218	397	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ellnestam.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
174	Minimal Perl	\N	2006-07-01	1	1932394508	956	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/maher.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
175	Distributed Programming with Java	\N	1999-09-01	1	1884777651	975	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mahmoud.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
176	Comprehensive Networking Glossary and Acronym Guide	This glossary offers a complete collection of technical terms and acronyms used in the networking industry.	1995-01-01	1	013319955X	403	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/malkin.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
177	JavaServer Faces in Action	\N	2004-11-01	1	1932394125	549	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mann.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
178	LINQ in Action	\N	2008-01-01	1	1933988169	586	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/marguerie.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
179	DSLs in Boo: Domain-Specific Languages in .NET	DSLs in Boo shows you how to design, extend, and evolve DSLs for .NET by focusing on approaches and patterns. You learn to define an app in terms that match the domain, and to use Boo to build DSLs that generate efficient executables. And you won't deal with the awkward XML-laden syntax many DSLs require. The book concentrates on writing internal (textual) DSLs that allow easy extensibility of the application and framework. And if you don't know Boo, don't worry   you'll learn right here all the techniques you need.  	2010-01-01	1	1933988606	914	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rahien.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
180	Internet BBSs	Internet BBSs: A Guided Tour provides in-depth coverage of the new world of true BBSs now available world-wide. It is a valuable resource for anyone currently using the Internet.	1996-10-01	1	132869985	1076	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mark.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
181	Algorithms of the Intelligent Web	\N	2009-05-29	1	1933988665	414	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/marmanis.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
182	JUnit in Action	\N	2003-10-01	1	1930110995	794	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/massol.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
183	Tika in Action	\N	2011-12-01	1	1935182854	975	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mattmann.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
184	Ruby in Practice	\N	2009-03-01	1	1933988479	360	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mcanally.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
185	Inside LotusScript	Develop Notes and Domino Web applications by providing advanced LotusScript code for direct use in your programs. This book emphasizes practical, useable code and solutions to common Notes programming problems.	1997-11-01	1	1884777481	851	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mcginn.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
186	The Responsive Web	\N	\N	1	1617291242	509	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/carver.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
187	Fast ASP.NET Websites	\N	2013-08-29	1	1617291250	1082	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hume.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
188	SBT in Action	\N	\N	1	1617291277	1001	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/suereth2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
189	Maximum MIDI	\N	1997-08-01	1	1884777449	806	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/messick.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
190	Planning and Managing ATM Networks	Planning and Managing ATM Networks covers strategic planning, initial deployment, overall management, and the day-to-day operation of ATM networks.	1997-06-01	1	132621894	901	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/minoli.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
191	Client/Server Applications on ATM Networks	Client/Server Appliactions on ATM Networks discusses ATM as the key technology for transforming the enterprise network from data-only to an integrated data, voice, video, image and multimedia corporate infrastructure.	1997-01-01	1	137353006	579	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/minoli2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
192	JavaFX in Action	\N	2009-10-01	1	1933988991	386	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/morris.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
193	Entity Framework 4 in Action	Microsoft Entity Framework in Action introduces the Entity Framework to developers working in .NET who already have some knowledge of ADO.NET. The book begins with a review of the core ideas behind the ORM model and shows how Entity Framework offers a smooth transition from a traditional ADO.NET approach. By presenting numerous small examples and a couple larger case studies, the book unfolds the Entity Framework story in clear, easy-to-follow detail. The infrastructure and inner workings will be highlighted only when there   s the need to understand a particular feature.	2011-05-01	1	1935182188	600	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mostarda.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
194	ASP.NET 2.0 Web Parts in Action	"ASP.NET Web Parts in Action is a must read book for every developer who wants to extend his knowledge of the ASP.NET framework." -- Simon Busoli, DotNetSlackers.com	2006-09-01	1	193239477X	758	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/neimke.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
195	PowerShell Deep Dives	\N	\N	1	1617291315	512	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hicks.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
196	Gradle in Action	\N	2014-02-18	1	1617291307	753	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/muschko.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
197	Sass and Compass in Action	Sass and Compass in Action is the definitive guide to stylesheet authoring using these two revolutionary tools. Written for both designers and developers, this book demonstrates the power of both Sass and Compass through a series of examples that address common pain points associated with traditional stylesheet authoring. The book begins with simple topics such as CSS resets and moves on to more involved topics such as grid frameworks and CSS3 vendor implementation differences.	2013-07-26	1	1617290149	929	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/netherland.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
198	Core OWL 5.0	Core OWL 5.0 dives under the surface and into the OWL source code itself. You'll see what new capabilities OWL 5.0 offers the OWL programmer. You'll gain a deeper understanding of what OWL does on your behalf such as the OWL messaging system and its message maps.	1997-12-01	1	1884777503	938	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/neward.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
199	Advanced OWL 5.0	Advanced OWL 5.0 covers advanced ways to make the OWL library do those tricky things you thought weren't possible. You'll get a long, exhaustive look at the new features introduced by the OWL 5.0 code. You'll find detailed explanations of how to extend the OWL objects themselves in new directions.	1998-01-01	1	1884777465	597	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/neward2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
200	Server-Based Java Programming	\N	2000-06-01	1	1884777716	1055	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/neward3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
201	SQL Server MVP Deep Dives	SQL Server MVP Deep Dives is organized into five parts: Design and Architecture, Development, Administration, Performance Tuning and Optimization, and Business Intelligence. In each, you'll find concise, brilliantly clear chapters that take on key topics like mobile data strategies, Dynamic Management Views, or query performance.	2009-11-01	1	1935182048	466	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/nielsen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
202	Scalatra in Action	\N	\N	1	1617291293	955	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/carrero2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
203	SQL Server MVP Deep Dives	SQL Server MVP Deep Dives is organized into five parts: Design and Architecture, Development, Administration, Performance Tuning and Optimization, and Business Intelligence. In each, you'll find concise, brilliantly clear chapters that take on key topics like mobile data strategies, Dynamic Management Views, or query performance.	2009-11-15	1	9781935182047	759	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/nielsenaw.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
204	SQL Server MVP Deep Dives	\N	2009-11-01	1	9781935182048	937	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/nielsonaw.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
205	PostGIS in Action	PostGIS in Action is the first book devoted entirely to PostGIS. It will help both new and experienced users write spatial queries to solve real-world problems. For those with experience in more traditional relational databases, this book provides a background in vector-based GIS so you can quickly move to analyzing, viewing, and mapping data.	2011-04-11	1	1935182269	1019	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/obe.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
206	Programming Mac OS X	"...an effective guide for Unix developers who want accurate information specifically on getting up to speed with Mac OS X and its software development environment, without having to sort through the morass of online information overload. ...If you've been a little skittish about Interface Builder, forget your worries now because the tutorial in the book is very good. ...The projects and examples are thorough and should provide even the most jaded intermediate programmer with a real taste of how challenging and satisfying it can be to code for OSX." - KickStartNews.com	2003-01-01	1	1930110855	822	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/omalley.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
207	The Art of Unit Testing	\N	2009-05-01	1	1933988274	841	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/osherove.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
208	Mahout in Action	\N	2011-10-05	1	1935182684	922	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/owen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
209	AngularJS in Action	\N	\N	1	1617291331	681	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bford.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
210	Software Development Metrics	\N	\N	1	1617291358	1056	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/nicolette.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
211	ASP.NET MVC in Action	ASP.NET MVC in Action is a guide to pragmatic MVC-based web development. After a thorough overview, it dives into issues of architecture and maintainability. The book assumes basic knowledge of ASP.NET (v. 3.5) and expands your expertise.	2009-09-01	1	1933988622	962	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/palermo.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
212	ASP.NET MVC 2 in Action	ASP.NET MVC 2 in Action is a fast-paced tutorial designed to introduce the MVC model to ASP.NET developers and show how to apply it effectively. After a high-speed ramp up, the book presents over 25 concise chapters exploring key topics like validation, routing, and data access. Each topic is illustrated with its own example so it's easy to dip into the book without reading in sequence. This book covers some high-value, high-end techniques you won't find anywhere else!	2010-06-01	1	193518279X	617	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/palermo2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
380	Storm Applied	\N	\N	1	1617291897	562	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/pathirana.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
386	D3.js in Action	\N	\N	1	1617292117	591	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/meeks.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
213	ASP.NET MVC 4 in Action	SP.NET MVC 3 in Action is a fast-paced tutorial designed to introduce ASP.NET MVC to .NET developers and show how to apply it effectively. After a high-speed ramp up, the book explores key topics like validation, routing, and data access. Each topic is illustrated with its own example so it's easy to dip into the book without reading in sequence. This book also covers some high-value, high-end techniques you won't find anywhere else!	2012-05-25	1	1617290416	755	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/palermo3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
214	EJB 3 in Action	\N	2007-04-01	1	1933988347	957	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/panda.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
215	EJB 3 in Action, Second Edition	Building on the bestselling first edition, EJB 3 in Action, Second Edition tackles EJB 3.1 head-on, through numerous code samples, real-life scenarios, and illustrations. This book is a fast-paced tutorial for Java EE 6 business component development using EJB 3.1, JPA 2 and CDI. Besides covering the basics of EJB 3.1, this book includes in-depth EJB 3.1 internal implementation details, best practices, design patterns, and performance tuning tips. The book also discusses using open source frameworks like Seam and Spring with EJB 3.1.	2014-04-07	1	1935182994	389	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/panda2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
216	F# Deep Dives	\N	\N	1	1617291323	1035	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/petricek_trelford.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
217	Explorer's Guide to the Semantic Web	"A thorough look at one vision of the Web's future ...particularly well written...Highly recommended." -- Choice Magazine	2004-06-01	1	1932394206	915	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/passin.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
218	Practical LotusScript	\N	1999-05-01	1	1884777767	1061	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/patton.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
219	Domino Development with Java	\N	2000-08-01	1	1930110049	686	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/patton2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
220	Windows PowerShell in Action	   If all it had going for it was the authoratative pedigree of the writer, it might be worth it, but it's also well-written, well-organized, and thorough, which I think makes it invaluable as both a learning tool and a reference.       Slashdot.org	2007-02-01	1	1932394907	867	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/payette.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
221	Windows PowerShell in Action, Second Edition	Windows PowerShell in Action, Second Edition is a completely revised edition of the best selling book on PowerShell, written by Bruce Payette, one of the founding members of the Windows PowerShell team, co-designer of the PowerShell language, and the principal author of the PowerShell language implementation.    This new edition preserves the crystal-clear introduction to PowerShell, showing sysadmins and developers how to build scripts and utilities to automate system tasks or create powerful system management tools to handle day-to-day tasks. It's rich with interesting examples that will spark your imagination. The book covers batch scripting and string processing, COM, WMI, remote management and jobs and even .NET programming including WinForms and WPF/XAML.	2011-05-15	1	1935182137	863	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/payette2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
222	C# in Depth, Third Edition	\N	2013-09-19	1	161729134X	602	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/skeet3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
223	PostGIS in Action, Second Edition	\N	\N	1	1617291390	1021	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/obe2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
224	R in Action, Second Edition	\N	\N	1	1617291382	411	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kabacoff2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
225	Silverlight 4 in Action, Revised Edition	Silverlight in Action, Revised Edition is a comprehensive guide to Silverlight, taking you from Hello World through the techniques you'll need to build sophisticated rich web apps. This new edition covers all the new features added in the latest versions of Silverlight, Visual Studio, and Expression Blend, along with the best practices emerging in the Silverlight community. With more than 50% new content, you'll take a mind-expanding trip through the technology, features, and techniques required to build applications ranging from media, to custom experiences, to business applications to games.	2010-10-04	1	1935182374	731	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/pbrown.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
226	Silverlight 5 in Action	\N	2012-06-01	1	1617290319	803	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/pbrown2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
227	Hibernate Quickly	"If you want to learn Hibernate quickly, this book shows you step by step." - Sang Shin, Java Technology Architect, Sun Microsystems	2005-08-01	1	1932394419	396	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/peak.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
228	Generative Art	\N	2011-06-30	1	1935182625	608	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/pearson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
229	Windows Phone 7 in Action	Windows Phone 7 in Action is a hands-on guide to building mobile applications for WP7 using Silverlight, C#, and XNA. Written for developers who already know their way around Visual Studio, this book zips through the basics, such as writing code to dial the phone, writing emails, and sending text messages, and moves on to the nuts and bolts of building great phone apps. By working through the numerous examples and tutorials, you'll master the APIs used to work with a phone's sensors and hardware, such as the accelerometer, camera, touch screen, GPS, and microphone. You'll also tackle web services and applications that use location and push notification services.	2012-08-21	1	1617290092	602	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/perga.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
230	Lift in Action	\N	2011-11-18	1	1935182803	893	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/perrett.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
231	Web Development with Apache and Perl	\N	2002-04-01	1	1930110065	641	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/petersen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
232	The Joy of Clojure, Second Edition	\N	2014-05-29	1	1617291412	850	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/fogus2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
233	Real-World Functional Programming	This book teaches the ideas and techniques of functional programming applied to real-world problems. You'll see how the functional way of thinking changes the game for .NET developers. Then, you'll tackle common issues using a functional approach. The book will also teach you the basics of the F# language and extend your C# skills into the functional domain. No prior experience with functional programming or F# is required.	2009-12-01	1	1933988924	804	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/petricek.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
388	Geoprocessing with Python	\N	\N	1	1617292141	814	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/garrard.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
234	Machine Learning in Action	Machine Learning in Action is a unique book that blends the foundational theories of machine learning with the practical realities of building tools for everyday data analysis. In it, you'll use the flexible Python programming language to build programs that implement algorithms for data classification, forecasting, recommendations, and higher-level features like summarization and simplification.	2012-04-04	1	1617290181	441	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/pharrington.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
235	Dependency Injection	   If you do large scale java apps, you probably want to have someone on the team have this book.       Michael Neale	2009-08-01	1	193398855X	910	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/prasanna.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
236	Understanding Enterprise SOA	"SOA is real ... Pulier is uniquely qualified to make [it] accessible to the general business audience." - Paul Gaffney, Staples, Inc., From the Foreword	2005-11-01	1	1932394591	1078	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/pulier.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
237	Open-Source ESBs in Action	\N	2008-09-01	1	1933988215	603	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rademakers.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
238	JUnit Recipes	\N	2004-07-01	1	1932394230	496	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rainsberger.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
239	wxPython in Action	"The book is easy to read and provides an approach to a very practical contemporary topic. The authors have organized their material well." -- Melissa Strange, Walden University, www.reviews.com	2006-03-01	1	1932394621	942	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rappin.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
240	Clojure in Action	Clojure in Action is a hands-on tutorial for the working programmer who has written code in a language like Java or Ruby, but has no prior experience with Lisp. It teaches Clojure from the basics to advanced topics using practical, real-world application examples. Blow through the theory and dive into practical matters like unit-testing, environment set up, all the way through building a scalable web-application using domain-specific languages, Hadoop, HBase, and RabbitMQ.	2011-11-15	1	1935182595	505	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rathore.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
241	Scala in Action	\N	2013-04-09	1	1935182757	355	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/raychaudhuri.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
242	Working with Objects	"The first method that deals realistically with reuse, and one of the few that comes close to describing what I do when I design." --Ralph Johnson, University of Illinois	1995-08-01	1	134529308	755	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/reenskaug.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
243	PHP in Action	"If there was ever a textbook for software development in PHP, this would be it."    Cal Evans, Podcast Review, Zend Developer Network	2007-07-01	1	1932394753	717	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/reiersol.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
244	EJB Cookbook	"This book provides a great reference for the average EJB developer. It provides recipes for most common tasks that an EJB developer would need." -- Computing Reviews, Nov. 2003	2003-05-01	1	1930110944	811	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sullins2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
245	Secrets of the JavaScript Ninja	   Secrets of the Javascript Ninja is definitely a book for anyone looking to significantly improve their Javascript knowledge and skills.       Ryan Doherty, Web Development Engineer, Mozilla	2012-12-27	1	193398869X	480	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/resig.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
246	Microsoft Office Essentials	Microsoft Office Essentials simply covers the things you really want to know and skips over all those esoteric features that 99 out of 100 readers never use.	1996-07-01	1	132623129	363	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/richardson2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
247	Swing	\N	1999-12-01	1	1884777848	373	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
248	Swing Second Edition	\N	2003-02-01	1	193011088X	993	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/robinson2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
249	The Awesome Power of Java Beans	\N	1998-05-01	1	1884777562	396	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rodrigues.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
250	Personal Videoconferencing	"Personal Videoconferencing is having an enormous impact on business. Evan Rosen has quantified that impact with examples of real world implementations and provided a primer on how businesses can achieve this competitive advantage for themselves."  --Frank Gill, Executive Vice President, Internet and Communications Group, Intel    "The book is very good: it is clear and the examples of user applications are excellent"  --Ralph Ungermann, CEO, First Virtual Corporation 	1996-06-01	1	013268327X	621	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rosen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
251	The Cloud at Your Service	\N	2010-11-22	1	1935182528	959	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rosenberg.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
252	GWT in Action, Second Edition	\N	2013-01-21	1	1935182846	617	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/tacy.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
253	Real-World Machine Learning	\N	\N	1	1617291927	785	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/brink.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
254	Implementing Elliptic Curve Cryptography	"The book provides all the theory and working programs needed to create real applications based on the latest IEEE P1363 standard."  --Reviewed in Cryptologia	1998-11-01	1	1884777694	1093	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rosing.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
255	SOA Patterns	In SOA Patterns, author Arnon Rotem-Gal-Oz provides detailed, technology-neutral solutions to these challenges, and many others. This book provides architectural guidance through patterns and anti-patterns. It shows you how to build real SOA services that feature flexibility, availability, and scalability.	2012-09-12	1	1933988266	907	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rotem.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
256	Hello World!	Hello World! provides a gentle but thorough introduction to the world of computer programming.	2009-03-01	1	1933988495	401	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sande.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
257	SCBCD Exam Study Kit	\N	2005-06-01	1	1932394400	616	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sanghera.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
282	Implementing PeopleSoft Financials	Implementing PeopleSoft Financials discusses the issues that arise and the pitfalls to avoid. Every member of the implementation team--from entry-level accounting clerk through MIS staff to executive sponsors--will benefit from reading this book.	1997-01-01	1	138411808	308	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/stephens.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
258	Portlets in Action	Portlets in Action is a comprehensive guide for Java developers with minimal or no experience working with portlets. Fully exploring the Portlet 2.0 API and using widely adopted frameworks like Spring 3.0 Portlet MVC, Hibernate, and DWR, it teaches you portal and portlet development by walking you through a Book Catalog portlet and Book Portal examples.	2011-09-16	1	1935182544	350	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sarin.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
259	Neo4j in Action	\N	\N	1	1617290769	991	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/partner.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
260	jQuery UI in Action	\N	\N	1	1617291935	579	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/vantoll.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
261	SWT/JFace in Action	Guides you through the process of developing Eclipse-based GUIs and shows how to build applications with features your users will love. Packed with examples and no fluff.	2004-11-01	1	1932394273	488	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/scarpino.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
262	OpenCL in Action	\N	2011-11-14	1	1617290173	995	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/scarpino2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
263	Multiprotocol over ATM	With the detailed coverage of the entire set of protocols in Multiprotocol over ATM, you can be equal to the task.	1998-03-01	1	138892709	791	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/schmidt.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
264	Dependency Injection in .NET	Dependency Injection in .NET is a comprehensive guide than introduces DI and provides an in-depth look at applying DI practices to .NET apps. In it, you will also learn to integrate DI together with such technologies as Windows Communication Foundation, ASP.NET MVC, Windows Presentation Foundation and other core .NET components.	2011-10-03	1	1935182501	852	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/seemann.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
265	Java 3D Programming	\N	2002-03-01	1	1930110359	306	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/selman.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
266	Liferay in Action	\N	2011-09-20	1	193518282X	314	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sezov.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
267	Programming the TI-83 Plus/TI-84 Plus	\N	2012-09-14	1	1617290777	493	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mitchell.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
268	Functional Programming in Scala	\N	\N	1	1617290653	327	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bjarnason.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
269	JSP Tag Libraries	\N	2001-05-01	1	193011009X	444	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/shachor.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
270	Instant Messaging in Java	This intermediate Java programming book provides Java programmers with the information and tools needed to create your own IM client and server software.	2002-03-01	1	1930110464	1013	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/shigeoka.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
271	Java Applets and Channels Without Programming	Java Applets and Channels Without Programming collects almost 100 applets on a CD with detailed instructions on how to use each applet. In addition, style issues are discussed in detail; not only will you learn how to use each applet, you will learn when and where it is appropriate to use each applet. The book also introduces the new concept of channels and shows how these can be used on your web site as well.  	1999-12-01	1	1884777392	658	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/shoffner.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
272	PowerShell in Practice	PowerShell in Practice is a hands-on, cookbook-style reference intended for administrators wanting to learn and use PowerShell. Written from an administrator's perspective, it concentrates on using PowerShell for practical tasks and automation. The book starts with an introduction that includes a rapid tutorial and a review of the key areas in which you'll use PowerShell.	2010-06-08	1	1935182005	358	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/siddaway.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
273	PowerShell and WMI	\N	2012-04-30	1	1617290114	802	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/siddaway2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
274	Making Sense of Java	Making Sense of Java clearly and concisely explains the concepts, features, benefits, potential, and limitations of Java.	1996-06-01	1	132632942	352	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/simpson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
275	C++/CLI in Action	   ... a great resource, an outstanding job, a must-read...        Ayman B. Shoukry, VC++ Team, Microsoft Corporation	2007-04-01	1	1932394818	1096	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sivakumar.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
276	C# in Depth	\N	2008-04-01	1	1933988363	935	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/skeet.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
277	C# in Depth, Second Edition	C# in Depth, Second Edition concentrates on the high-value features that make C# such a powerful and flexible development tool. Rather than re-hashing the core of C# that's essentially unchanged since it hit the scene nearly a decade ago, this book brings you up to speed with the features and practices that have changed with C# from version 2.0 onwards.	\N	1	1935182471	724	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/skeet2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
278	Magical A-Life Avatars	"Distinctive book explaining how to get intelligent software agents to work." --Clipcode.com	2000-12-01	1	1884777589	397	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/small.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
279	Becoming Agile	   Becoming Agile is not another book to be classified in the existing ones handling agile practices, it's one of the rare writings which will go with you in the adoption and setup/migration to an agile process...This real must-have agilist's bedside book reads very well and will accompany you in your migration agile practices...       Eric Siber, Developpez.com	2009-05-01	1	1933988258	673	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/smith.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
280	Play for Scala	\N	2013-10-03	1	1617290793	669	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hilton.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
281	ActiveMQ in Action	ActiveMQ is implemented in Java, but it supports client applications written in many other programming languages including C/C++, .NET, Ruby, Perl, PHP, Python, and more. It can be integrated with other open source frameworks including Tomcat, ServiceMix, JBoss, and can easily bridge to other JMS providers.  	2011-03-31	1	1933988940	860	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/snyder.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
334	Big Data	\N	\N	1	1617290343	1072	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/marz.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
335	CoffeeScript in Action	\N	2014-05-09	1	1617290629	675	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lee.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
283	SQL Server DMVs in Action	SQL Server DMVs in Action shows you how to obtain, interpret, and act on the information captured by DMVs to keep your system in top shape. The over 100 code examples help you master DMVs and give you an instantly reusable SQL library. You'll also learn to use Dynamic Management Functions (DMFs), which provide further details that enable you to improve your system's performance and health.	2011-05-09	1	1935182730	640	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/stirk.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
284	Scala in Depth	Scala in Depth is a unique new book designed to help you integrate Scala effectively into your development process. By presenting the emerging best practices and designs from the Scala community, it guides you though dozens of powerful techniques example by example. There's no heavy-handed theory here-just lots of crisp, practical guides for coding in Scala.    For example:        * Discover the "sweet spots" where object-oriented and functional programming intersect.      * Master advanced OO features of Scala, including type member inheritance, multiple inheritance and composition.      * Employ functional programming concepts like tail recursion, immutability, and monadic operations.      * Learn good Scala style to keep your code concise, expressive and readable.    As you dig into the book, you'll start to appreciate what makes Scala really shine. For instance, the Scala type system is very, very powerful; this book provides use case approaches to manipulating the type system and covers how to use type constraints to enforce design constraints. Java developers love Scala's deep integration with Java and the JVM Ecosystem, and this book shows you how to leverage it effectively and work around the rough spots.	2012-05-14	1	1935182706	987	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/suereth.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
285	JMX in Action	\N	2002-09-01	1	1930110561	416	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sullins.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
286	JUnit in Action, Second Edition	JUnit in Action, Second Edition is an up-to-date guide to unit testing Java applications (including Java EE applications) using the JUnit framework and its extensions. This book provides techniques for solving real-world problems such as testing AJAX applications, using mocks to achieve testing isolation, in-container testing for Java EE and database applications, and test automation.	2010-07-01	1	1935182021	478	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/tahchiev.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
287	Bitter Java	\N	2002-03-01	1	193011043X	544	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/tate.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
288	Bitter EJB	"The book's informal tone offers a refreshing change from the ubiquitous preachiness of other EJB tomes. It's pragmatic and doesn't tap dance around the fact that EJBs are often used incorrectly in enterprise development... it's an effective way to avoid the potholes that have forced developers off track in the past." -- Software Development Magazine	2003-05-01	1	1930110952	589	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/tate2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
289	Spring Batch in Action	\N	2011-10-01	1	1935182951	830	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/templier.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
290	JDK 1.4 Tutorial	\N	2002-03-01	1	1930110456	979	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/travis.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
291	iPhone and iPad in Action	Using many examples, the book covers core features like accelerometers, GPS, the Address Book, and much more. Along the way, you'll learn to leverage your iPhone skills to build attractive iPad apps. This is a revised and expanded edition of the original iPhone in Action.	2010-08-01	1	1935182587	744	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/trebitowski.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
292	SQL Server 2005 Reporting Services in Action	\N	2006-11-01	1	1932394761	869	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/updegraff.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
293	Node.js in Practice	\N	\N	1	1617290939	360	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/templier2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
294	Ten Years of UserFriendly.Org	This unique collector's volume includes every daily strip from November 17, 1997 to November 16, 2007. Many of the cartoons are annotated with comments from UserFriendly artist and creator JD    Illiad    Frazer.	2008-12-01	1	1935182129	957	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/userfriendly.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
295	Graphics Programming with Perl	\N	2002-05-01	1	1930110022	511	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/verbruggen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
296	RabbitMQ in Action	\N	2012-04-20	1	1935182978	1052	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/videla.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
297	XDoclet in Action	\N	2003-11-01	1	1932394052	959	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/walls.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
298	Spring in Action	Spring in Action introduces you to the ideas behind Spring and then quickly launches into a hands-on exploration of the framework. Combining short code snippets and an ongoing example developed throughout the book, it shows you how to build simple and efficient J2EE applications. You will see how to solve persistence problems using the leading open-source tools, and also how to integrate your application with the most popular web frameworks. You will learn how to use Spring to manage the bulk of your infrastructure code so you can focus on what really matters     your critical business needs.	2005-02-01	1	1932394354	738	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/walls2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
299	Spring in Action, Second Edition	\N	2007-08-01	1	1933988134	1010	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/walls3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
300	SonarQube in Action	\N	2013-10-30	1	1617290955	571	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/papapetrou.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
301	Windows Store App Development: C# and XAML	\N	2013-06-03	1	1617290947	419	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/pbrown3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
302	Spring in Action, Third Edition	Spring in Action, Third Edition has been completely revised to reflect the latest features, tools, practices Spring offers to java developers. It begins by introducing the core concepts of Spring and then quickly launches into a hands-on exploration of the framework. Combining short code snippets and an ongoing example developed throughout the book, it shows you how to build simple and efficient J2EE applications.	2011-06-21	1	1935182358	536	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/walls4.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
336	SQL Server MVP Deep Dives, Volume 2	\N	2011-10-13	1	1617290475	496	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/delaney.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
381	Java 8 in Action	\N	\N	1	1617291994	834	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/urma.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
303	Spring in Practice	Spring in Practice diverges from other cookbooks because it presents the background you need to understand the domain in which a solution applies before it offers the specific steps to solve the problem. You're never left with the feeling that you understand the answer, but find the question irrelevant. You can put the book to immediate use even if you don't have deep knowledge of every part of Spring Framework.	2013-05-09	1	1935182056	973	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/wheeler.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
304	Java 2 Micro Edition	\N	2002-03-01	1	1930110332	976	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/white.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
305	SharePoint 2010 Workflows in Action	SharePoint 2010 Workflows in Action is a hands-on guide for workflow application development in SharePoint. Power users are introduced to the simplicity of building and integrating workflows using SharePoint Designer, Visio, InfoPath, and Office. Developers will learn to build custom processes and use external data sources. They will learn about state machine workflows, ASP.NET forms, event handlers, and much more. This book requires no previous experience with workflow app development. 	2011-02-07	1	1935182714	411	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/wicklund.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
306	SharePoint 2010 Web Parts in Action	SharePoint 2010 Web Parts in Action is a comprehensive guide to deploying, customizing, and creating Web Parts. Countless examples walk you through everything from design, to development, deployment, troubleshooting, and upgrading. Because Web Parts are ASP.NET controls, you'll learn to use Visual Studio 2010 to extend existing Web Parts and to build custom components from scratch. 	2011-04-24	1	1935182773	982	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/wilen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
307	C++ Concurrency in Action	C++ Concurrency in Action is the first book to show you how to take advantage of the new C++ Standard and TR2 to write robust multi-threaded applications in C++.	2012-02-24	1	1933988770	425	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/williams.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
308	Web Components in Action	\N	\N	1	1617291943	709	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/buckett2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
309	Java Servlets by Example	\N	2002-12-01	1	188477766X	1058	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/williamson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
310	XML Programming with VB and ASP	\N	1999-12-01	1	1884777872	595	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/wilson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
311	Oracle8i Database Administration	\N	1999-11-01	1	1884777783	409	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/yuhanna.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
312	The Engaging Web	The Engaging Web: How Fun and Games Improve Your Site shows web developers how to incorporate games into websites. This book will help you decode the possibilities and provide a series of proven and tangible strategies that any web developer, producer, or product manager can use to implement games in their website. Whether you're looking to make games the centerpiece of your site, an added-value feature, or you just want to engage and excite your users, The Engaging Web will help you develop a strategy that harnesses the power of games.	\N	1	9781935182078	842	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/zichermann.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
313	Enterprise OSGi In Action	\N	\N	1	1617290130	338	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/cummins.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
314	Ext JS in Action, Second Edition	\N	2014-02-04	1	1617290327	424	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/garcia3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
315	Android in Action, Third Edition	\N	2011-11-15	1	1617290505	846	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ableson3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
316	Learn Windows IIS in a Month of Lunches	\N	2013-12-31	1	1617290971	1066	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/helmick.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
317	Mondrian in Action	\N	\N	1	161729098X	366	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/back.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
318	RabbitMQ in Depth	\N	\N	1	1617291005	1091	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/roy.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
319	JavaScript Application Design	\N	\N	1	1617291951	865	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bevacqua.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
320	Arduino in Action	Arduino in Action is a hands-on guide to prototyping and building electronics using the Arduino platform. Suitable for beginners and advanced users, this easy to follow book begins with the basics and systematically guides you through projects ranging from your first blinking LED through connecting Arduino to devices like game controllers or your iPhone.	2013-05-30	1	1617290246	491	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mevans.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
321	Node.js in Action	Node.js in Action is an example-driven tutorial that starts at square one and guides you through all the features, techniques, and concepts you'll need to build production-quality Node applications. You'll start by learning how to set up your Node development environment, including loading the community-created extensions. Next, you'll run several simple demonstration programs where you'll learn the basics of a few common types of Node applications. Then you'll dive into asynchronous programming, a model Node leverages to lessen application bottlenecks.	2013-10-15	1	1617290572	1087	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/cantelon.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
322	Third-Party JavaScript 	\N	2013-03-11	1	1617290548	841	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/vinegar.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
323	Multimedia Computing	\N	1993-09-01	1	020152029X	555	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
324	Web Development with JavaServer Pages	\N	2000-05-15	1	1884777996	1086	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
325	Up to Speed with Swing	\N	1998-05-01	1	1884777643	504	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
326	Manager's Guide to Open Source	\N	2004-10-01	1	193239429X	460	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
327	Programming Web Services with Java	\N	2002-10-01	1	1930110421	781	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
328	TCP/IP Programming for OS/2	\N	1996-04-23	1	132612496	625	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
329	Implementing SAP R/3, Second Edition	\N	1997-09-01	1	013889213X	822	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
330	Implementing SAP R/3	\N	1996-06-01	1	1884777228	400	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
331	Using C-Kermit: Communication Software	\N	\N	1	1884777147	656	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
332	SCWCD Exam Study Kit	\N	2002-07-01	1	1930110596	674	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
333	Unit Testing in C++	\N	\N	1	1617290386	561	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
337	HTML5 in Action	HTML5 In Action provides a complete introduction to web development using HTML5. You'll explore every aspect of the HTML5 specification through real-world examples and code samples. It's much more than just a specification reference, though. It lives up to the name HTML5 in Action by giving you the practical, hands-on guidance you'll need to use key features.	2014-02-10	1	1617290491	606	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/crowther2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
338	Java Persistence with Hibernate, Second Edition	\N	\N	1	1617290459	731	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bauer3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
339	Hadoop in Practice	\N	2012-10-02	1	1617290238	1079	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/holmes.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
340	HBase in Action	\N	2012-11-02	1	1617290521	810	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dimidukkhurana.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
341	Flex Mobile in Action	\N	2012-05-30	1	1617290610	1000	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/campos.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
342	HTML5 for .NET Developers	\N	2012-11-30	1	1617290432	838	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jackson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
343	50 Android Hacks	\N	2013-06-03	1	1617290564	564	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sessa.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
344	PowerShell in Depth	\N	2013-02-20	1	1617290556	940	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jones2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
345	Augmented Reality Revealed	\N	\N	1	1617290165	992	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
346	Building Well-Structured JavaScript Applications	\N	\N	1	1617290599	626	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
347	Linked Data	\N	2013-12-31	1	1617290394	390	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dwood.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
348	Mule in Action, Second Edition	\N	2014-02-20	1	1617290823	415	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/dossot2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
349	Single Page Web Applications	\N	2013-09-19	1	1617290750	825	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mikowski.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
350	The Art of Unit Testing, Second Edition	\N	2013-11-25	1	1617290890	1033	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/osherove2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
351	Play for Java	\N	2014-03-14	1	1617290904	1099	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/leroux.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
352	Hello World! Second Edition	\N	2013-12-12	1	1617290920	413	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/sande2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
353	Dart in Action	\N	2012-12-31	1	1617290866	638	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/buckett.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
354	Redis in Action	\N	2013-06-18	1	1617290858	809	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/carlson.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
355	Using the TI-83 Plus/TI-84 Plus	\N	2013-08-19	1	161729084X	798	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/mitchell2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
356	iOS 7 in Action	\N	2014-04-03	1	1617291420	662	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/lim2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
357	Hello App Inventor!	\N	\N	1	1617291439	968	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/beer.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
358	Ember.js in Action	\N	2014-06-10	1	1617291455	766	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/skeie.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
359	Netty in Action	\N	\N	1	1617291471	763	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/maurer.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
360	RavenDB in Action	\N	\N	1	1617291501	586	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/syn-hershko.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
361	OCP Java SE 7 Programmer II Certification Guide	\N	\N	1	161729148X	699	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/gupta2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
362	Backbone.js in Action	\N	\N	1	1617291536	905	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/breed.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
363	Clojure in Action, Second Edition	\N	\N	1	1617291528	679	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rathore2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
364	Practical Data Science with R	\N	2014-04-02	1	1617291560	665	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/zumel.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
365	Secrets of the JavaScript Ninja pBook upgrade	\N	\N	1	1617292850	839	1	\N	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
366	ArcGIS Web Development	\N	\N	1	1617291617	766	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/rubalcava.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
367	Elasticsearch in Action	\N	\N	1	1617291625	984	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hinman.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
368	Learn SCCM 2012 in a Month of Lunches	\N	\N	1	1617291684	983	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bannan.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
369	Programming for Musicians and Digital Artists	\N	\N	1	1617291706	1056	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/kapur.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
370	BDD in Action	\N	\N	1	161729165X	684	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/smart.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
371	Windows Phone 8 in Action	\N	2013-12-31	1	1617291374	1097	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/binkley.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
372	Titanium Alloy in Action	\N	\N	1	1617291749	942	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/alcocer.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
373	Giraph in Action	\N	\N	1	1617291757	571	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/martella.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
374	The Well-Grounded Rubyist, Second Edition	\N	2014-06-24	1	1617291692	589	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/black3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
375	Go in Action	\N	\N	1	1617291781	558	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ketelsen.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
376	The Programmer's Guide to Apache Thrift 	\N	\N	1	1617291811	476	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/abernethy.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
377	Grokking Functional Programming	\N	\N	1	1617291838	489	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/khan.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
383	MongoDB in Action, Second Edition	\N	\N	1	1617291609	392	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/banker2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
389	Barcodes with iOS	\N	\N	1	161729215X	1038	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/drobnik.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
390	Chef in Action	\N	\N	1	1617292214	476	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/aivaliotis.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
391	Hadoop in Practice, Second Edition	\N	\N	1	1617292222	892	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/holmes2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
392	Oculus Rift in Action	\N	\N	1	1617292192	542	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bdavis.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
393	OpenStack in Action	\N	\N	1	1617292168	760	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/bumgardner.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
394	PowerShell in Depth, Second Edition	\N	\N	1	1617292184	951	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/jones6.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
395	Practical Probabilistic Programming	\N	\N	1	1617292338	1036	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/pfeffer.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
396	Unity in Action	\N	\N	1	161729232X	681	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hocking.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
397	Express.js in Action	\N	\N	1	1617292427	779	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/hahn.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
398	Learn Git in a Month of Lunches	\N	\N	1	1617292419	1074	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/umali.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
399	Understanding SPAs	\N	\N	1	1617292435	779	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/scott2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
400	XSLT Quickly	\N	2001-05-01	1	1930110111	644	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ducharme.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
401	Windows Forms Programming with C#	\N	2002-03-01	1	1930110286	416	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/eebrown.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
402	Windows Forms in Action	\N	2006-04-01	1	1932394656	767	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/eebrown2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
403	Event Processing in Action	Event Processing in Action is a ground-breaking book that introduces the major concepts of event driven architectures and shows you how to use, design, and build event processing systems and applications. The book looks at practical examples and provides an in-depth explanation of their architecture and implementation. Throughout the book, you'll follow a comprehensive use case that expert authors Opher Etzion and Peter Niblett construct step-by-step.	2010-08-15	1	1935182218	876	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/etzion.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
404	The Well-Grounded Java Developer	The Well-Grounded Java Developer is a unique guide written for developers with a solid grasp of Java fundamentals. It provides a fresh, practical look at new Java 7 features along with the array of ancillary technologies that a working developer will use in building the next generation of business software.    The book starts with thorough coverage of new Java 7 features. You'll then explore a cross-section of emerging JVM-based languages, including Groovy, Scala, and Clojure. Along the way, you'll find dozens of valuable development techniques showcasing modern approaches to concurrency and performance.	2012-07-10	1	1617290068	391	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/evans.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
405	Objective-C Fundamentals	Objective-C for the iPhone is a hands-on tutorial that leads you from your first line of Objective-C code through the process of building native apps for the iPhone using the latest version of the SDK. While the book assumes you know your way around an IDE, no previous experience with Objective-C, the iPhone SDK, or mobile computing is required.	2011-09-13	1	1935182536	1016	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/fairbairn.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
406	ADO.NET Programming	ADO.NET Programming covers database programming in .NET and illustrates important steps with nice examples. It shows you how you can achieve effortless separation of data presentation from data access; how to easily go from relational data to XML, and back; how to bind data directly to the Web and Windows Controls; how to write generic access code that talks to multiple databases without change; and much more.	2002-07-01	1	1930110294	498	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/feldman.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
407	WPF in Action with Visual Studio 2008	\N	2008-11-01	1	1933988223	1084	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/feldman2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
408	Location-Aware Applications	\N	2011-07-28	1	1935182331	929	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ferraro.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
409	Web Development with JavaServer Pages, Second Edition	\N	2001-11-01	1	193011012X	1060	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/fields2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
410	IntelliJ IDEA in Action	The purpose of this most excellent book is to get you up and running quickly. Perhaps more importantly, this book shows you how to use IDEA's multitude of powerful software development tools to their fullest advantage!       John R. Vacca, Author and IT Consultant	2006-03-01	1	1932394443	910	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/fields3.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
411	Spring Integration in Action	Spring Integration in Action is a hands-on guide to Spring-based messaging and integration. After addressing the core messaging patterns, such as those used in transformation and routing, the book turns to the adapters that enable integration with external systems. Readers will explore real-world enterprise integration scenarios using JMS, Web Services, file systems, and email. They will also learn about Spring Integration's support for working with XML. The book concludes with a practical guide to advanced topics such as concurrency, performance, system-management, and monitoring.	2012-09-19	1	1935182439	960	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/fisher.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
412	The Joy of Clojure	The Joy of Clojure goes beyond just syntax to show you how to write fluent and idiomatic Clojure code. You'll learn a functional approach to programming and will master Lisp techniques that make Clojure so elegant and efficient. The book gives you easy access to hard soft ware areas like concurrency, interoperability, and performance. And it shows you how great it can be to think about problems the Clojure way.	2011-03-25	1	1935182641	1024	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/fogus.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
413	Dynamic WAP Application Development	\N	2002-08-01	1	1930110081	991	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/foo.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
414	IronPython in Action	\N	2009-03-01	1	1933988339	374	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/foord.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
415	Art of Java Web Development	\N	2003-11-01	1	1932394060	370	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ford.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
416	Java Reflection in Action	\N	2004-10-01	1	1932394184	346	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/forman.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
417	Programming Windows Server 2003	\N	2003-08-01	1	1930110987	402	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/foster.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
418	Struts Recipes	\N	2004-11-01	1	1932394250	913	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/franciscus.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
419	Hello! iOS Development	\N	2013-07-28	1	1935182986	523	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/franco.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
420	Jess in Action	Jess in Action first introduces rule programming concepts and teaches you the Jess language. Armed with this knowledge, you then progress through a series of fully-developed applications chosen to expose you to practical rule-based development. The book shows you how you can add power and intelligence to your Java software	2003-06-01	1	1930110898	797	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/friedman-hill.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
421	Remote LAN Access	Remote LAN Access will help you cut through the haze typically encountered when designing and installing remote LAN connections.	1996-06-01	1	134944518	1070	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/fritz.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
422	J2EE and XML Development	\N	2002-03-01	1	1930110308	711	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/gabrick.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
423	Eclipse in Action	Eclipse in Action provides a thorough guide to using Eclipse features and plugins effectively in the context of real-world Java development. Realistic examples demonstrate how to use Eclipse effectively to build, test and debug applications using the tools provided by Eclipse and other third-party open source plugins. The reader will learn how to use plugin tools for using Eclipse in a team environment, including using Ant for more sophisticated build processes and CVS for source control. Plugin-ins for building web applications, using J2EE technologies, such as JSP/Servlets and EJB, are also discussed.	2003-05-01	1	1930110960	891	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/gallardo.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
424	ASP.NET AJAX in Action	\N	2007-09-01	1	1933988142	811	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/gallo.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
425	Ext JS in Action	Ext JS in Action teaches the reader about Ext from the ground up. By following the common design patterns demonstrated in the Ext source and in many commercial applications, the book teaches you to achieve the same results you see in world-class commercial JavaScript applications. This book will guide you through the Ext component model and layouts. You'll learn how core components, such as the Container class, serve as building blocks for building complex user interfaces. The book fully covers Ext utility classes, AJAX, Observable (the Ext events model), DOM helpers and Function Helpers and illustrates how use of JavaScript Object Notation (JSON), a powerful and lightweight data format, can allow your application to efficiently communicate over the network to the web server. Finally, you'll build on this foundation to customize or extend Ext widgets.	2010-12-05	1	1935182110	599	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/garcia.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
426	Sencha Touch in Action	Sencha Touch in Action is the definitive guide to developing applications with Sencha Touch. You'll begin with the basic design principles for building great mobile applications, and then explore the features of Sencha Touch that bring those ideas to life. You'll learn how and why objects operate in the framework as you work through several real-world examples. This book also promotes the emerging best practices for mobile web development, from widget implementation to developing an application with the Sencha Touch MVC framework.	2013-07-12	1	1617290378	761	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/garcia2.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
427	DSLs in Action	DSLs in Action introduces the concepts and definitions a developer needs to build high-quality domain specific languages. It provides a solid foundation to the usage as well as implementation aspects of a DSL, focusing on the necessity of applications speaking the language of the domain. After reading this book, a programmer will be able to design APIs that make better domain models. For experienced developers, the book addresses the intricacies of domain language design without the pain of writing parsers by hand.	2010-12-01	1	1935182455	387	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ghosh.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
428	Database Programming for Handheld Devices	\N	2000-07-01	1	1884777856	1049	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/gorgani.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
429	Jakarta Commons Online Bookshelf	\N	2005-03-01	1	1932394524	796	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
430	Browsing with HttpClient	Written for developers and architects with real work to do, the Jakarta Commons Online Bookshelf is a collection of 14 PDF modules, each focused on one of the main Commons components. Commons is a collection of over twenty open-source Java tools broadly ranging from logging, validation, bean utilities and XML parsing. The Jakarta Commons Online Bookshelf summarizes the rationale behind each component and then provides expert explanations and hands-on examples of their use. You will learn to easily incorporate the Jakarta Commons components into your existing Java applications.	2005-03-01	1	1932394524a-e	1061	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal1.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
431	Codec: Encoders and Decoders	\N	2005-03-01	1	1932394524j-e	424	1	https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/goyal10.jpg	2023-08-06 12:28:02.1755	2023-08-06 12:28:02.1755
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: book; Owner: postgres
--

COPY book.categories (category_id, category_name) FROM stdin;
1	Object-Technology Programming
2	In Action
3	P
4	XML
5	PowerBuilder
6	Mobile
7	Software Development
8	Perl
9	Next Generation Databases
10	SOA
11	Mobile Technology
12	Python
13	Microsoft/.NET
14	Object-Oriented Programming
15	Algorithmic Art
16	Microsoft .NET
17	S
18	Open Source
19	Programming
20	Miscella
21	Miscellaneous
22	Client Server
23	Business
24	internet
25	java
26	Computer Graphics
27	PHP
28	Java
29	Networking
30	Computer Graph
31	.NET
32	Software Engineering
33	Microsoft
34	Web Development
35	Internet
36	Theory
37	Client-Server
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: book; Owner: postgres
--

COPY book.languages (language_id, language_code, language_name) FROM stdin;
1	EN	English
2	RU	Russian
\.


--
-- Data for Name: publishers; Type: TABLE DATA; Schema: book; Owner: postgres
--

COPY book.publishers (publisher_id, publisher_name) FROM stdin;
1	Information system publisher
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: hr; Owner: postgres
--

COPY hr.employees (employee_id, first_name, last_name, middle_name, date_of_birth, phone_number, employment_date, dismissal_date, position_id, url_photo, created_at, modified_at) FROM stdin;
1	Katell	Cook	\N	1981-04-08	+78033355011	2022-09-11	\N	1	\N	2023-08-06 13:23:24.586347	2023-08-06 13:23:24.586347
2	Brandon	Little	\N	1983-10-23	+74741623652	2022-07-20	\N	1	\N	2023-08-06 13:23:24.641986	2023-08-06 13:23:24.641986
3	Mona	Gomez	\N	1987-06-30	+72134216535	2021-12-10	\N	2	\N	2023-08-06 13:23:24.674869	2023-08-06 13:23:24.674869
4	George	Shepherd	\N	1992-09-15	+76137188761	2021-04-30	\N	2	\N	2023-08-06 13:23:24.705729	2023-08-06 13:23:24.705729
5	Cameron	Bray	\N	1984-06-02	+71506886696	2021-07-03	\N	1	\N	2023-08-06 13:23:24.739039	2023-08-06 13:23:24.739039
6	Colorado	England	\N	1995-03-28	+76668473551	2021-03-01	\N	2	\N	2023-08-06 13:23:24.77424	2023-08-06 13:23:24.77424
7	Nerea	O'Neill	\N	1991-10-03	+73650358202	2022-02-02	\N	2	\N	2023-08-06 13:23:24.802811	2023-08-06 13:23:24.802811
8	Carl	Francis	\N	1989-11-08	+79857421597	2022-05-09	\N	1	\N	2023-08-06 13:23:24.831705	2023-08-06 13:23:24.831705
9	Jacob	Barnes	\N	1984-03-07	+73537811480	2021-11-22	\N	2	\N	2023-08-06 13:23:24.863244	2023-08-06 13:23:24.863244
10	Wyatt	Potter	\N	1993-12-04	+76528781706	2021-06-03	\N	2	\N	2023-08-06 13:23:24.910747	2023-08-06 13:23:24.910747
\.


--
-- Data for Name: positions; Type: TABLE DATA; Schema: hr; Owner: postgres
--

COPY hr.positions (position_id, position_name) FROM stdin;
1	Courier
2	Operator
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.addresses (address_id, address, postal_code, city, region_id, created_at, modified_at) FROM stdin;
1	35 Mifflin Drive	70174	New Orleans	19	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
2	11 Main Avenue	47705	Evansville	15	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
3	86357 Hayes Circle	78703	Austin	44	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
4	39342 Anzinger Road	63110	Saint Louis	26	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
5	71 Prairieview Lane	89166	Las Vegas	29	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
6	5 Elmside Drive	76210	Denton	44	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
7	71386 Norway Maple Point	77288	Houston	44	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
8	2 Blackbird Place	73135	Oklahoma City	37	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
9	4 Warbler Road	55188	Saint Paul	24	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
10	5 Stoughton Crossing	93709	Fresno	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
11	5040 Bellgrove Hill	26505	Morgantown	49	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
12	7 Melvin Circle	32813	Orlando	10	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
13	2794 Melby Avenue	50981	Des Moines	16	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
14	24991 Hallows Avenue	92030	Escondido	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
15	06122 Jackson Park	13251	Syracuse	33	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
16	3 Fieldstone Junction	06816	Danbury	7	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
17	612 Pepper Wood Street	89550	Reno	29	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
18	5 Vermont Terrace	48555	Flint	23	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
19	52920 Bunting Terrace	91199	Pasadena	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
20	455 Mendota Way	32255	Jacksonville	10	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
21	789 Vera Park	67230	Wichita	17	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
22	79 Weeping Birch Way	32505	Pensacola	10	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
23	3 Warner Terrace	32909	Palm Bay	10	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
24	8205 Ridgeway Trail	37931	Knoxville	43	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
25	6 2nd Park	20205	Washington	9	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
26	8638 Buena Vista Trail	94405	San Mateo	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
27	9606 Marcy Lane	61651	Peoria	14	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
28	36483 Scoville Road	20409	Washington	9	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
29	63668 Daystar Terrace	20851	Rockville	21	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
30	9 Carpenter Park	40293	Louisville	18	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
31	85302 Boyd Junction	90505	Torrance	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
32	3 Donald Crossing	92883	Corona	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
33	3 Golf View Center	22156	Springfield	47	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
34	0994 North Road	14905	Elmira	33	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
35	1 Schiller Trail	13505	Utica	33	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
36	81 Blackbird Circle	14210	Buffalo	33	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
37	4057 Blue Bill Park Junction	93399	Bakersfield	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
38	16 Buena Vista Point	89087	North Las Vegas	29	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
39	5 West Drive	95828	Sacramento	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
40	13269 Hooker Hill	32236	Jacksonville	10	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
41	00 Lunder Place	85030	Phoenix	3	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
42	6 Mallory Lane	95298	Stockton	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
43	35041 Coleman Place	40515	Lexington	18	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
44	52453 West Parkway	49560	Grand Rapids	23	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
45	4 Muir Center	30328	Atlanta	11	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
46	82 Sommers Road	48242	Detroit	23	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
47	2243 Westerfield Road	06606	Bridgeport	7	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
48	0886 Di Loreto Street	77212	Houston	44	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
49	5394 Thackeray Road	95113	San Jose	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
50	8 Petterle Crossing	19495	Valley Forge	39	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
51	97140 Granby Trail	33610	Tampa	10	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
52	3 Duke Alley	55487	Minneapolis	24	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
53	16334 Anniversary Street	63196	Saint Louis	26	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
54	47826 Del Mar Trail	46852	Fort Wayne	15	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
55	27741 Saint Paul Center	92862	Orange	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
56	82 Walton Crossing	68124	Omaha	28	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
57	42416 Forest Dale Alley	74103	Tulsa	37	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
58	0 Paget Trail	80299	Denver	6	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
59	70 Goodland Street	03105	Manchester	30	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
60	6784 Village Pass	20456	Washington	9	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
61	792 Arapahoe Street	55412	Minneapolis	24	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
62	84 Hollow Ridge Junction	34282	Bradenton	10	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
63	19 Mallory Road	36205	Anniston	1	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
64	3 Laurel Avenue	63167	Saint Louis	26	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
65	1784 Valley Edge Plaza	92867	Orange	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
66	500 Spaight Lane	97306	Salem	38	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
67	4 Autumn Leaf Way	20436	Washington	9	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
68	460 Namekagon Way	06145	Hartford	7	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
69	2258 School Junction	52245	Iowa City	16	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
70	04 Mccormick Court	50981	Des Moines	16	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
71	04 Crownhardt Point	45419	Dayton	36	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
72	01820 Welch Junction	73129	Oklahoma City	37	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
73	371 Forest Run Street	84409	Ogden	45	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
74	8 Linden Junction	01813	Woburn	22	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
75	61857 Petterle Street	79905	El Paso	44	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
76	6 Garrison Avenue	53790	Madison	50	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
77	02295 New Castle Point	32304	Tallahassee	10	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
78	82153 Superior Avenue	84403	Ogden	45	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
79	905 Cambridge Terrace	11388	Flushing	33	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
80	97 Killdeer Point	39236	Jackson	25	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
81	95553 Messerschmidt Crossing	44185	Cleveland	36	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
82	1236 Dovetail Way	20005	Washington	9	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
83	340 Crownhardt Lane	78210	San Antonio	44	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
84	9 Union Avenue	73104	Oklahoma City	37	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
85	975 Schurz Terrace	53210	Milwaukee	50	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
86	73 Gateway Circle	49544	Grand Rapids	23	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
87	6809 Dawn Park	78475	Corpus Christi	44	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
88	2 Bellgrove Crossing	91520	Burbank	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
89	82763 Lake View Way	95194	San Jose	5	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
90	7366 Larry Plaza	48275	Detroit	23	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
91	35573 Rieder Alley	36104	Montgomery	1	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
92	9 Montana Parkway	72199	North Little Rock	4	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
93	1798 Johnson Road	80951	Colorado Springs	6	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
94	11225 Express Place	64160	Kansas City	26	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
95	835 Toban Hill	20022	Washington	9	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
96	0395 Elmside Park	19109	Philadelphia	39	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
97	4 Meadow Vale Center	55557	Young America	24	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
98	970 Summer Ridge Avenue	48267	Detroit	23	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
99	8 Quincy Circle	32859	Orlando	10	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
100	2 Fair Oaks Place	46015	Anderson	15	2023-08-06 12:11:57.353262	2023-08-06 12:11:57.353262
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.countries (country_code, country_name) FROM stdin;
US	United States
\.


--
-- Data for Name: customer_addresses; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.customer_addresses (customer_id, address_id, is_current_address) FROM stdin;
1	1	t
2	2	t
3	3	t
4	4	t
5	5	t
6	6	t
7	7	t
8	8	t
9	9	t
10	10	t
11	11	t
12	12	t
13	13	t
14	14	t
15	15	t
16	16	t
17	17	t
18	18	t
19	19	t
20	20	t
21	21	t
22	22	t
23	23	t
24	24	t
25	25	t
26	26	t
27	27	t
28	28	t
29	29	t
30	30	t
31	31	t
32	32	t
33	33	t
34	34	t
35	35	t
36	36	t
37	37	t
38	38	t
39	39	t
40	40	t
41	41	t
42	42	t
43	43	t
44	44	t
45	45	t
46	46	t
47	47	t
48	48	t
49	49	t
50	50	t
51	51	t
52	52	t
53	53	t
54	54	t
55	55	t
56	56	t
57	57	t
58	58	t
59	59	t
60	60	t
61	61	t
62	62	t
63	63	t
64	64	t
65	65	t
66	66	t
67	67	t
68	68	t
69	69	t
70	70	t
71	71	t
72	72	t
73	73	t
74	74	t
75	75	t
76	76	t
77	77	t
78	78	t
79	79	t
80	80	t
81	81	t
82	82	t
83	83	t
84	84	t
85	85	t
86	86	t
87	87	t
88	88	t
89	89	t
90	90	t
91	91	t
92	92	t
93	93	t
94	94	t
95	95	t
96	96	t
97	97	t
98	98	t
99	99	t
100	100	t
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.customers (customer_id, first_name, last_name, middle_name, date_of_birth, phone_number, email_address, is_email_notification, is_active, created_at, modified_at) FROM stdin;
1	Chantale	Poole	\N	1970-01-05	+74182453285	chantalepoole2381@yandex.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
2	Owen	Chapman	\N	1954-03-14	+74835276126	owenchapman@google.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
3	Yael	Zimmerman	\N	1999-12-01	+72274658772	yaelzimmerman4477@mail.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
4	Jessamine	Sampson	\N	1977-10-27	+76333874439	jessaminesampson9727@outlook.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
5	Pamela	Petersen	\N	1992-09-05	+71652842323	pamelapetersen@yandex.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
6	Plato	Weeks	\N	1989-09-19	+76676272643	platoweeks@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
7	Patrick	Terrell	\N	1959-10-31	+72624839661	patrickterrell7916@mail.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
8	Jael	Clements	\N	1968-04-28	+75422452143	jaelclements7502@outlook.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
9	Raphael	Avila	\N	1957-04-11	+77299926443	raphaelavila@google.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
10	Xyla	Moon	\N	1998-06-25	+71629842852	xylamoon@mail.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
11	Alan	Solis	\N	1989-08-11	+79263463729	alansolis@outlook.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
12	Gregory	Hardy	\N	2000-04-13	+77575927246	gregoryhardy1749@outlook.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
13	Hector	Lane	\N	1958-07-21	+74229746477	hectorlane@google.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
14	Hilel	Albert	\N	1997-07-21	+75732464639	hilelalbert@yandex.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
15	Robert	Turner	\N	1962-03-31	+72387345267	robertturner4082@mail.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
16	Petra	Short	\N	1997-10-30	+76337924268	petrashort6495@mail.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
17	Bruce	Frost	\N	1997-12-12	+79185633536	brucefrost6764@yandex.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
18	Claire	Parks	\N	1978-06-14	+75786726573	claireparks@outlook.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
19	Vladimir	Webster	\N	1961-10-20	+72168266186	vladimirwebster2705@mail.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
20	Cassady	Peterson	\N	1985-03-14	+78674361264	cassadypeterson@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
21	Leandra	Best	\N	1970-03-09	+74185724649	leandrabest786@outlook.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
22	Martena	Chaney	\N	1961-12-23	+75157223293	martenachaney6723@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
23	Jackson	Duffy	\N	1979-12-09	+73343673127	jacksonduffy594@yandex.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
24	Joshua	Roberson	\N	1993-06-20	+75325722255	joshuaroberson7246@yandex.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
25	Tobias	Fulton	\N	1956-06-07	+75634891675	tobiasfulton@outlook.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
26	Lavinia	Bright	\N	1998-10-12	+74582422378	laviniabright4845@yandex.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
27	Hyatt	Holmes	\N	1991-10-25	+74454484226	hyattholmes5222@google.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
28	Pandora	Weeks	\N	1979-09-21	+72137156852	pandoraweeks3722@mail.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
29	Linus	Stewart	\N	1992-07-16	+71638846856	linusstewart@mail.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
30	Iris	Lindsey	\N	1993-10-05	+75658726645	irislindsey2254@outlook.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
31	Kelly	Mcintyre	\N	1962-09-06	+73734246469	kellymcintyre3967@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
32	Nicholas	Cote	\N	1950-11-23	+76775442883	nicholascote4680@yandex.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
33	Madonna	Forbes	\N	1991-07-03	+76874276626	madonnaforbes1342@mail.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
34	Melodie	Velasquez	\N	1964-12-23	+78247647955	melodievelasquez@google.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
35	Darius	Durham	\N	1985-06-19	+78683739335	dariusdurham@outlook.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
36	Aspen	Randolph	\N	1968-03-07	+77589713668	aspenrandolph@outlook.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
37	Fallon	Lindsey	\N	1985-12-07	+78667237326	fallonlindsey5316@yandex.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
38	Baker	May	\N	1957-05-20	+72363773864	bakermay@google.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
39	Audrey	Winters	\N	1974-08-21	+77981123784	audreywinters5716@yandex.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
40	Echo	Mercado	\N	1977-10-13	+74556677636	echomercado@outlook.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
41	Lana	Hernandez	\N	1975-07-03	+75227378778	lanahernandez3884@outlook.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
42	Hashim	Kramer	\N	1952-03-19	+72664575243	hashimkramer6087@mail.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
43	Deirdre	Saunders	\N	1971-08-01	+77536721682	deirdresaunders4305@mail.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
44	Leila	Best	\N	1961-09-11	+73463619374	leilabest5965@yandex.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
45	Wade	Holden	\N	1981-06-01	+79747292622	wadeholden4199@yandex.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
46	Stewart	Caldwell	\N	1997-07-01	+71633872272	stewartcaldwell4946@outlook.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
47	Emi	Lara	\N	1980-06-27	+75768968927	emilara@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
48	Yoko	Solis	\N	1989-08-20	+75267677925	yokosolis@yandex.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
49	Maggy	Bond	\N	1964-11-29	+72625258773	maggybond877@outlook.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
50	Adele	Blanchard	\N	1975-10-27	+75279849617	adeleblanchard7288@outlook.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
51	Phyllis	Kelley	\N	1997-06-21	+71338477348	phylliskelley@mail.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
52	Hilary	Bush	\N	1977-11-06	+78846326597	hilarybush@outlook.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
53	Stacy	Peterson	\N	1977-04-21	+74299287784	stacypeterson8043@outlook.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
54	Abra	Guthrie	\N	1951-02-03	+78748838395	abraguthrie6716@yandex.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
55	Christian	Middleton	\N	1959-02-16	+78846674328	christianmiddleton@google.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
56	Theodore	Fry	\N	1978-05-08	+78274943643	theodorefry@outlook.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
57	Moana	Mosley	\N	1983-05-14	+78234343366	moanamosley@mail.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
58	Althea	Trevino	\N	1961-01-27	+77742598386	altheatrevino@yandex.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
59	Shad	Gonzalez	\N	1970-02-23	+75745752854	shadgonzalez5936@google.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
60	Heather	Crane	\N	2000-07-30	+75853567325	heathercrane@yandex.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
61	Mannix	Barron	\N	1981-09-06	+77884579432	mannixbarron@outlook.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
62	Michael	Moss	\N	1972-04-04	+73637539893	michaelmoss@yandex.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
63	Rosalyn	Malone	\N	1970-04-08	+73424777345	rosalynmalone@outlook.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
64	Ainsley	Carr	\N	1953-04-25	+72478667544	ainsleycarr8292@google.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
65	Daphne	Malone	\N	1993-08-28	+77361727317	daphnemalone@outlook.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
66	Driscoll	Harper	\N	1987-08-14	+78446335138	driscollharper@google.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
67	Zenaida	Christensen	\N	1993-02-05	+75952729168	zenaidachristensen3170@outlook.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
68	Cody	Elliott	\N	1980-12-04	+78178347548	codyelliott@mail.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
69	Kyra	O'connor	\N	1984-06-20	+73778839744	kyraoconnor@google.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
70	Cora	Acevedo	\N	1983-06-28	+75646252944	coraacevedo@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
71	Libby	Dejesus	\N	1953-01-23	+75843483553	libbydejesus7466@google.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
72	Beau	Coleman	\N	1975-03-08	+75453726437	beaucoleman@google.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
73	Duncan	Lucas	\N	1991-03-11	+73747622754	duncanlucas@yandex.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
74	Hayden	Marks	\N	1958-07-26	+75761664387	haydenmarks8064@mail.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
75	Haviva	Pacheco	\N	1985-10-21	+74654349746	havivapacheco7776@outlook.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
76	Uriah	Schwartz	\N	1998-05-11	+75281237544	uriahschwartz2232@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
77	Rachel	Henry	\N	1987-06-03	+73646761981	rachelhenry@outlook.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
78	Simon	Mathews	\N	1973-04-17	+77235487176	simonmathews9887@yandex.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
79	Jesse	Hahn	\N	1991-01-27	+76118432296	jessehahn7428@outlook.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
80	Arthur	Buckley	\N	1987-08-15	+78892337558	arthurbuckley6399@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
81	Armand	Jarvis	\N	1966-08-26	+72365944884	armandjarvis@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
82	Hunter	Hutchinson	\N	1966-11-08	+76837158734	hunterhutchinson1376@mail.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
83	Kermit	Leonard	\N	1984-08-10	+78518853785	kermitleonard@outlook.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
84	Alisa	Hutchinson	\N	1968-06-15	+76338596222	alisahutchinson@mail.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
85	TaShya	Alvarado	\N	1965-08-27	+72462256227	tashyaalvarado2931@outlook.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
86	Serena	Wilder	\N	1967-07-03	+73737815632	serenawilder1958@yandex.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
87	Kameko	Justice	\N	1996-05-17	+74563732587	kamekojustice4573@mail.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
88	Eugenia	Maynard	\N	1962-12-05	+76976362714	eugeniamaynard@yandex.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
89	Tallulah	Oneal	\N	1968-04-25	+78332551883	tallulahoneal5410@outlook.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
90	Jessica	Barron	\N	1986-08-31	+79287623933	jessicabarron@yandex.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
91	Steven	Hinton	\N	1970-01-21	+71822423335	stevenhinton@yandex.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
92	Joel	Price	\N	1956-06-02	+74321424873	joelprice4336@mail.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
93	George	Robles	\N	1991-01-09	+71584393283	georgerobles9769@mail.cedu	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
94	Angelica	Hewitt	\N	1978-11-07	+78786456245	angelicahewitt5136@mail.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
95	Denise	Hurley	\N	1970-02-07	+74138589384	denisehurley@mail.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
96	Lani	Hobbs	\N	1977-10-28	+76427366793	lanihobbs8729@yandex.org	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
97	Gil	Cain	\N	1971-11-08	+73736427852	gilcain@google.ca	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
98	Aiko	Floyd	\N	1967-02-18	+72498396545	aikofloyd@outlook.com	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
99	Garth	Velez	\N	1962-08-08	+76964269826	garthvelez@mail.ru	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
100	Colette	Bolton	\N	1958-08-28	+71338298557	colettebolton896@yandex.net	f	t	2023-08-06 11:44:35.606694	2023-12-23 10:50:49.680158
\.


--
-- Data for Name: passwords; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.passwords (customer_id, password_hash, salt, created_at, modified_at) FROM stdin;
1	$2a$06$Fg6PGhinQLSqwb276Di7I.21hodfEuXSS4./jvRLXCzv69z7P5TK.	$2a$06$FkvN3xRtdqkgYL2Oi/1lxu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
2	$2a$06$h37Fnz5hSpZdeBwoE5N.4uXv18Ne/vu/n/K9bjQtqFivGDQPbM8Pq	$2a$06$ZgWaoMFWrw0V9gAd6B8vqO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
3	$2a$06$WPKFjfdYbnfjcn77NyTpXORuERhFN9gyvbsvIjlI.paOChX.5W3dq	$2a$06$HhDOgop31/ynBivW9OxJPe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
4	$2a$06$B0m/eMDAiSsyamdP4fb/guN7/BwgnakueOf5eFFU.I8K6Kx4Q0jje	$2a$06$ZuB8x5IWNIVSR2OEGvah..	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
5	$2a$06$.4/rz1VdE8GN82fT/wl1veS39sb6U8T.YPXFvi4bB0mC4lExFroD2	$2a$06$vpFPAsJ2m4gUANwra49eiu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
6	$2a$06$YoD03Nwv10Jl2oPPWTHDD.8EjsnGpVC.nhhxJ0pYRKv7QucAFbnze	$2a$06$5dUpn8.QFUf02sOyhc4/su	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
7	$2a$06$mb0RbLOs7nV94f1VmEYBh.IZ9bfO0ENV0pfJa6BHZMTyrHdukyhNW	$2a$06$/JA3zrJeQoYXwvGIBk7REu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
8	$2a$06$Vw4uVj49Czb4x15cO.DONO4uEiJoJIN.xK8ZTI8/0EIhBWdwYx732	$2a$06$W4WDW0nLySvUUpho0OfcDO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
9	$2a$06$NMCczBveMr9UWyYCGmUTQeIxMsqnEda8x4Lzy5qA0esLc2tXXKeCy	$2a$06$.ulXe6qb.TibwBofQMmEGu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
10	$2a$06$EpUa2q6j6ggBiY3Q1S7TQ.CX3wxQ1m/rdjm8D43sKTS4/Q/JN7oH2	$2a$06$Q5gdNFAlfNoqrdZdHW03Uu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
11	$2a$06$bniUa9Vv/P/6R3ed3k5zr.TTr/fCuT/SrHJ3gdJJOMMZUgcXK/9oe	$2a$06$yPFk1n7ZkXBbbL4XVM7Ate	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
12	$2a$06$0rlP1GPeuEv8.YcAwr5HOed4CV8dBeK5U078jdc7KX4pDzSDKzroG	$2a$06$uUc3wbnI4a3VEiOtiJMHQO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
13	$2a$06$lJco2UGuEO83GnXtPD3dy.Em2GEK/OqTOb73UElfBBUG3C2SW/F5i	$2a$06$8YznATS4C.9bkoyvxuJe/u	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
14	$2a$06$bu1nhx6MgBWyk7F59ASNe.HXJlkPS89eWVV60ny4Q.DBZCROBa6Aq	$2a$06$gBBCbvMweGD0cBcbrvUIkO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
15	$2a$06$sW77YA28g.fFpOvpJOxf2enIgGbhGU/Dn5V4CeTs3fiJA4Fo1tkRW	$2a$06$zp7H2f3V6xwox1sDSgy5au	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
16	$2a$06$nE6fEFrQPYVNK4rSGLLqLOgthnAVvBd0JQ6pKzopkK0olEKh9oHyK	$2a$06$9OgNXiACRY5KpH/BT0GOnO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
17	$2a$06$Pb90s043oMD1y.09qmy7iuCqXn2g0GB.aQUYVZYZQvd7O9G9bifle	$2a$06$7vBid/nhl31O/Tu4YCqyZO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
18	$2a$06$eBoY06QoHvydu9PMSjocVuZ6.Koh82rMbC727jfLUisqTWHh0ngN.	$2a$06$e/l3Pfe2NACNReX0euXrZu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
19	$2a$06$pEjBnp7eDu1obweJix5Q8uLS4A6YB4ssUW9AOOmjqY4RwsVYcOeDe	$2a$06$NoSi5jnEbyFDn8StYPAvvu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
20	$2a$06$Bclhaqp96dVcrHKqTAxzV.3ePAWaE.eR6FilrqWYgT/QxbMZp2C5O	$2a$06$db.iqm5Auk3azRcCHlKHke	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
21	$2a$06$TM4lmGouPKQ9ZmOo0FJ/jObDxrDaLnOUKVtGi/fC3rOOD.SqwEZCK	$2a$06$ow/GYb62Q/X1C.LiIV8YGu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
22	$2a$06$q5vmI.Tkqa9HUUj4.d4O1e36y.sxzMm.btBwZFk8FaSuZ.psW4qGq	$2a$06$9eosL1kl5zUEjDs83Gh3A.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
23	$2a$06$j8SOf64JcgmTPYKA6xGNPOkCtMLRYL/k6FYDputHA0Tb1bp/65DUy	$2a$06$KKlSfnUi4zKvHyAV.LLZsO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
24	$2a$06$E0S1FKtsMgGCBYMDETM3euaXZ6Mkpr6BpESI3TuKBANCHHDcYzal.	$2a$06$PQQJtby8ktn6D8VolH2NpO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
25	$2a$06$CEy30cvLk/cPnIFPDP4t.eimt0cyMh2YwgWCVmYM6ges5S0p8QOsq	$2a$06$d1Hbo8V1IyFXPM7EnIeg6e	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
26	$2a$06$i.8mDjzPRj/hSxRKO2zU0e8hy.mPeCuoc86tbgSMRKFKAbnrtZq1a	$2a$06$9RGttH3yf.uwqSQ6pTrLZ.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
27	$2a$06$yLR7ve7v8vNFVvk8qbsR7etulOyB2dycYUJOlqEIu1XD1nM1ZbNnO	$2a$06$j7CAPox5INaxWKlrIow8r.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
28	$2a$06$NXwVwLPpNGB4rsphURIJ0.zeXEw5Pu.X3l.kTOrOrBK1rGraGPyvK	$2a$06$u.uAZ.qvt317jk83Xe2SX.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
29	$2a$06$1RL3wo39fk6Cc//dr7djXuRbrJCLZUI5bP8eLyG.OlwwcAWWYyeNa	$2a$06$sSLbwHlHgESgMErHQrut8O	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
30	$2a$06$SP.qv3KXlfuN2IcxuTTgduoPmX7Z89k2B1VD2QvDYlUWg3noiQWFa	$2a$06$dnCGKoP1VrgldfzgDrVTde	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
31	$2a$06$iFrPDhKmjU3Xys8jnbD1mujX2ie92yZEWQ6UNHa4ksPFoN4/Wffq.	$2a$06$oRE1/5d8J/kKX9BurM6Npu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
32	$2a$06$q1lk8KWCJPWGh1lecOHOfOQpAyV2zroMGK9FX6e0Ch6cG0lCl0Ara	$2a$06$8ns2GOMWDE7pg0EyNTqZk.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
33	$2a$06$0pmIXGTLQdicQpLEV636p.FSmspnVU.8hgO4bvrg08XraL6G0f3Ya	$2a$06$QRY02kPXn8XwNSy40.GO7.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
34	$2a$06$T/Qn8wrl/Mp1TTPRz25xkeNURk.cIlX3yaOakXlRQ.gRyZb6BNnsC	$2a$06$YezxbO8lCkRyT0yrCMnVi.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
35	$2a$06$HoVeC6CoNfuez6rm6sCUUuX.4HQkJk5sDSx/s3rPhcXaCdPIXDW2G	$2a$06$kPWD9DjBv1ml542OvHkyYe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
36	$2a$06$GZ/upeO5ktoEvGw4QbVbGOix8wH3OyYWnL/l8KFhTght3BFxYd8DS	$2a$06$JLVYkDeH52lUh8X1/mSek.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
37	$2a$06$1R5b3IkgjPsoVplW2ui9nuIT4An9t79/eM0YzwRyvIu3y3OfujDc.	$2a$06$B6Vv0T09gLM.YTMNrVNJ9O	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
38	$2a$06$c7hEpPvXSOL8LgvSP81IXuVYy6nyRzF2BCp1vasBiEySp6wmHyG0G	$2a$06$cG2uLMlZd5zV1T5bqlt.8O	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
39	$2a$06$cpu85oyfU5HV4GAWMiCIRe7.dGhGSeGgX13.//K58F9ZifAix5pLG	$2a$06$3nKmhnXfjtmyV7rWIRT5Fu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
40	$2a$06$.U7qSxwkwvISFWLt.8UUOuvfaTo9jQ4cpwQVbtOw1URaWvqD.8mXK	$2a$06$q4qZ/VRyjdieywbLIhgBbe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
41	$2a$06$Jur1X88iIGOrYXxRY20bxemFKaM0IPkwwM2sBiq8ae98FxmQf8p/u	$2a$06$fdq4b/Rqhuw4yVIc9e9qVe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
42	$2a$06$RU9dlr3KBL7LWLuHK45U1O3tfBWv9QscGzHbZbs7OWa1UiPGcTrmC	$2a$06$E6.pfuj2JY/mCAy.vgTmze	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
43	$2a$06$R05p75ATEz2kH6zRLNiqEulEZy4.NYtGpXhQmhHJN9rrpyB5RXBie	$2a$06$3fVR.AJE4BFx8KZfn5OVNe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
44	$2a$06$BthSeays0Nci4X8K8d8rfeTU.ilr0xAJJfkRGDUIyO8weGoGpyeZ6	$2a$06$B.PLvEQTp8QImmA/VJkpWO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
45	$2a$06$XdBujtmcOtMZRAlGiY7Hd.iMkn2xTKohCxr2lCWWPrFG8txV1Bu5O	$2a$06$l43zUD1qKyErGFS3jpWBd.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
46	$2a$06$RRwvJDrTrvvLHBljZmEtqe.jontvY8wzlhUJbbrHfEci4zGBu2Q0a	$2a$06$qFnBBEnx712wUGttFXjeL.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
47	$2a$06$D8eoK3ZZMei61G1FnEqNX.zaQlN9JL4CZPNFfH/q106rJEUe6C9LO	$2a$06$wMuBBUpu56igMVXpUt72x.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
48	$2a$06$2Hx47lK8CwEdPxZFpCT9wuk3ZvmpuFQN5z2PftUbj/urGu30DcxPO	$2a$06$wY0wwssQlTZyuGCGRp4kDu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
49	$2a$06$GAkcljVKTSTBaJwaK7jqo.zXnAXzRernUrIFSNIF8sFa8/vYV6KuS	$2a$06$MNffVb/KASjw2pyXdz6Xs.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
50	$2a$06$G8qjMHuug1qVhHiE.ahIyuldNdtdXt41GD3FeMZWqVj3hf.Wr3q7.	$2a$06$ZL2oGkfO0r3vWYIKoyetse	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
51	$2a$06$lGGEYK2R3y5dQCdow3c2Ce0j85bUmdT06Vdy4MGEBTPCmUHYg0CwG	$2a$06$lDlLvmR5uDbbJP3WO1wAYO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
52	$2a$06$unYLN0d3v3NeN0IKDt3SW.iWTObcp5lWRoSsYP6yBz2NsrFvVEJH.	$2a$06$.UapK1kPyXx6CwFtA1shse	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
53	$2a$06$c8Ck6U9bYjNx7IO15tRPyuv7IVBmxEh3FyaXL5WWlHnbUAX7AIlmu	$2a$06$Geerarc6UdgNtC7U.Ygtz.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
54	$2a$06$GP8KVAOv9SQMaZ2/hPC9UO3VlFhM4pw7/1Vl32yrZgVvfsNg.3l1W	$2a$06$1gkrrg7wnNZJYNXrgy.rgu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
55	$2a$06$nRwNu1xeVKqbVoQg./H52e5hsEcTYGPb4KCyi5w3l6f107nn.QqqS	$2a$06$YOuOuFe..71S6WOYHTsVBe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
56	$2a$06$8nRdQZLdfo3b6R.RxrOo/eqp/Nwi0wEXmQGQyJKrA8REDrJoGtwaO	$2a$06$6tOJxBlJ3S0uVu0k/EnOCO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
57	$2a$06$GU9CIQs.vP89aJgRFrVh8uqDLtFMUri/wV6sDdaOgt/sc3UgYMk..	$2a$06$4uTGmL5RZLAM0RT3CmofYO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
58	$2a$06$loncFpePkA492jqrqn.Fne2sg815UADd/WQGGXOwbMhmwRo88W0he	$2a$06$sHMBrjMEqkx.dl0VLoPMWe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
59	$2a$06$CBdIoAPN6eEbSceivK.O2u7fehBK7F3GNfZcMt1RYFrD2GZh06eb2	$2a$06$.hj79rWqBhCW/OqXB3497e	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
60	$2a$06$kSiMPv6qIYMasgCQOR1L6.X0tP5IYMJ.p6j2Y0KWHC1x4efJmnfY2	$2a$06$zBEapptCwRVXCe2HKP2xZe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
61	$2a$06$7GPQpOzHfedLh0R6.jympOkQN8vKbCUOt9YdHYt1.hzvXMLpzo/ai	$2a$06$.S9sYXQVHtudt.CPl1Wy4.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
62	$2a$06$KnBpQZxfFeo4Um7eAMFHuuXCwvKkuUYlJUoPfqeTkGYC/Wp4ix6kK	$2a$06$KcyBDMpzAi0G29eMK/XNGO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
63	$2a$06$RKWgrwGDvWtis4y9S2UB1uetBRqrMdG/Emm.v/228mxyDIAXcdURq	$2a$06$foUstTbY1FMBM5N3Ngwkuu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
64	$2a$06$56eGdeFzIcLkNlyHl6vpieusNJCB8Cu1YUt7xE0AIRR3lYocrlGdm	$2a$06$6PdPr8rJhF2ssWCsV5yG/O	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
65	$2a$06$M36kJAmnsc8iS6/vNwN7luDt8/XN9OrMlnSeztJnb7cNHPf5grsOG	$2a$06$GErrVyZXrla5YETDhkxHcu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
66	$2a$06$8guoEhRjLF7BMTS1aPheXe0gRVhnJCk70lrf4opk7m05sRUtOXktC	$2a$06$snx5dLHJLQE8PGao6YGmfO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
67	$2a$06$P6UeIjF3.ZBio8.T9Ez6V.H5Od4p/DScjlU/BE.ZBkOfed8ppLv3u	$2a$06$d2xEu.q70FoJVOu8BvloFO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
68	$2a$06$TYrkvCzUpkeiC4JPzj.u2OCXtZO5Fj1jN0tMp0W46PD5rzX4bW6tm	$2a$06$jfItk87Sfd8EdCq32uaAPe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
69	$2a$06$vBwn.CK0TnY6Ufu9fVREte6wooiJO4yGr46a2coRuGW0YOMDda/gC	$2a$06$ELQmcEuqGqHpuRt.clVru.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
70	$2a$06$wK0Yk/mf09P6uaZTGoBgNeVbH3NlqqGJooRUuqnX0Vq/oseeeN.lq	$2a$06$NHKg38TGIWgCundVjMlxCu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
71	$2a$06$zk2qPczyifIE/XPg4q.CY.pbJ8VfaiFWmO7XizRE.HZaCyi3jIO8K	$2a$06$GRPfqlqRrh3jhDu2YQFSZ.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
72	$2a$06$BU3WlN4iyuuUEdgFr2YVW.da7yoCJrNwNYTjwKp03zbTyqLOCg.5e	$2a$06$iYp0buVs4kK4s5AukV8R1e	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
73	$2a$06$wfLXhDfd1ZN9Sh3B0zAM2OT7TbiuCjnSf8mJrTM8Y81t09xfR7Ur.	$2a$06$q9GXQW6/WuNuXWVb.pgKJe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
74	$2a$06$hvw1QdBtWhE8huBLWfGV1uG4Z8ZNjtlOMYnyvG.IUij0m6YmMog.W	$2a$06$nlCXq/QcMwfpFIQJxO0wEe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
75	$2a$06$KRXtNv92a0jZT.sRdBE8t.Sf4OupBfpWXialV8JQCl366FGjs8Uda	$2a$06$3i5oyJk0W7BxrcG51F7BiO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
76	$2a$06$fx0mFPbX/Z.QfJ6tytIKB.j6oM33DJ7qXiNLHc2SmtqcXxZ4WCfiy	$2a$06$XCy3FVlT9b5rWfhu2YBuAO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
77	$2a$06$90euG32.UR1SSL4BT9IEN.iufXQxq9X2uaSM3t7reT0p9skEW1EK2	$2a$06$G0jNqIkwkZk5sX1vujclT.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
78	$2a$06$H0cQPCF4009dDgbpsCIGmevDNcSa7V8a6XLpWCE3OeTIWbb8E5Xkq	$2a$06$mlo/p/hhpDtTAygxr1omXu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
79	$2a$06$B5mAYIKWffNsmCJc/4sNBuN5bskE9mDP/m4tgwJwRLVlBqAzTgQeS	$2a$06$GsRFu6sXRmjTUmo3NktJRe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
80	$2a$06$mDiItEioPGzlSpV/xiZGTubz526LsnH.O3xCuSxZjyjTqxgznvep6	$2a$06$QhTizgu19l5eUl53sLT0fO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
81	$2a$06$nVj81HObIKg26uYkLT85OeI4HR/38LCS73zHROePZkAwSQgARNBgy	$2a$06$yHux54f87YxioqFWVffefe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
82	$2a$06$6kD943Y5BWRzcr12vF1Bne/GGP2DZhYwHIbYrYtxQ4gJNgUQVAupi	$2a$06$bPGrJgF1PV2EedA2w9ireu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
83	$2a$06$3i8PAd7UvJKBsvD2lgSuxei3FefSoEB6kD/qAwYe8khtGZtp2YUyy	$2a$06$ocZ3IVD13kjVu/6IQLg5q.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
84	$2a$06$19XQ0iokFPuVWaqzhyCO.eIvky8aq/BlNEhWokrdJbHrt675DyB5a	$2a$06$AOpWA9Clx0xNTq/c3a5qF.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
85	$2a$06$qAndBf0trTb3A2Wn0Q7QWOA6gNxtDDjUItSxvSE3FG69maNd1PQ0u	$2a$06$RskKOyTTEIIpkRxefM7Ene	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
86	$2a$06$1JzPPi0/m2KH76s.HEKi9O3SCI0H0Ty0Urq/OxSYIOa1L2hAoEOGu	$2a$06$8Agd2N4BNhhe4hch89CtTe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
87	$2a$06$QczuuArRViKP57sEfoQSuuoeK6a9546ylUgaR9p8xqx/pCrIEsolS	$2a$06$BCVgttVBsN52qOMSoT.UNe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
88	$2a$06$J8kciQeehUCaKRXUOdAOqOvcRK0L7efcxdbEw.w5.5Vl56XiC/l4.	$2a$06$gtyaNoYEYauzqY/Y3MjoGe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
89	$2a$06$HhzaGyq4EWfpYdEl5HXozuhw4fbs5LtVM4n8lPCbA0FEI76LIr6jK	$2a$06$OGXcLpgvOugsU1V0qav7d.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
90	$2a$06$Nn2auTm8mNKEMx2c1Uq60OnZ0fnrHYB1XaOIJYIulKWD0BvrT3J0i	$2a$06$qe1kGKWfeEogMgpiyn1MbO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
91	$2a$06$BvgQS3c8c91TH9tQnyLteuVQjAqhclpYcNxWLCPMlylA/Y2lgjREm	$2a$06$9wek465LxDMXK/bRqwOQsu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
92	$2a$06$IK1Lndac/4ht89n84D4dB.aXxY5h.GjGDkgU6Ufe5Lh3Fi/7WP8bO	$2a$06$T.LAYnVu9d5PUFpJjXyvju	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
93	$2a$06$SlyM0IshKXgu08Ufjldd9.c3oOq/xRuGHT3JR.vsewiQkytMBaUnm	$2a$06$F.Ydzo7QSX2./3DCx0502O	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
94	$2a$06$XIqErs4EvSbHTd71wSXOH.lxSzNPb/aJPqNQH.wLQrlgc2e1h1xSK	$2a$06$kZcohhaPh/t8diUeZE5ruu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
95	$2a$06$sMI7h075wU9RwDwow7xk2ujunSDWWMvRCf4PPLvjy.2f38i/GNoze	$2a$06$na/RExEdyfzb/O4Y2WHMmu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
96	$2a$06$AFlCdRnauMl.IdhVdoMH7ud8dwEJlTYkLrEiBlo50PYtbz2zxdfsy	$2a$06$6ac/SViD5ouc9PGJHaoNxe	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
97	$2a$06$GxISBIiT3/Ti7rqc86pCIOZJ3ZusunDp5zVC9akbb8D/p7GR72xL.	$2a$06$wsMA0t5gBlcBXL24LOQkze	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
98	$2a$06$nTjZfwx3fN86Hojk0a0oauxHq2hykxGk0MMpA7lKnNZIhErIfZPMi	$2a$06$Ang.Qs/ILZeI2Dv13WExNO	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
99	$2a$06$zL1PEMpsJQMIDABUp5ENH.iuK1t3IcVGlMBpLXewsW/dQucNX6PC6	$2a$06$W4RMRJ7Q5uJO38Ni.GIOMu	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
100	$2a$06$.7SQeb6XoSgTPuHeXpaiseeqkc.AnjfF.ghkoK41GHM9xxEdIoUTS	$2a$06$8WTz7jY3spFdjms062YHJ.	2023-08-06 11:44:35.606694	2023-08-06 11:44:35.606694
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.regions (region_id, region_code, country_code, region_name) FROM stdin;
1	AL	US	Alabama
2	AK	US	Alaska
3	AZ	US	Arizona
4	AR	US	Arkansas
5	CA	US	California
6	CO	US	Colorado
7	CT	US	Connecticut
8	DE	US	Delaware
9	DC	US	District of Columbia
10	FL	US	Florida
11	GA	US	Georgia
12	HI	US	Hawaii
13	ID	US	Idaho
14	IL	US	Illinois
15	IN	US	Indiana
16	IO	US	Iowa
17	KS	US	Kansas
18	KY	US	Kentucky
19	LA	US	Louisiana
20	ME	US	Maine
21	MD	US	Maryland
22	MA	US	Massachusetts
23	MI	US	Michigan
24	MN	US	Minnesota
25	MS	US	Mississippi
26	MO	US	Missouri
27	MT	US	Montana
28	NE	US	Nebraska
29	NV	US	Nevada
30	NH	US	New Hampshire
31	NJ	US	New Jersey
32	NM	US	New Mexico
33	NY	US	New York
34	NC	US	North Carolina
35	ND	US	North Dakota
36	OH	US	Ohio
37	OK	US	Oklahoma
38	OR	US	Oregon
39	PA	US	Pennsylvania
40	RI	US	Rhode Island
41	SC	US	South Carolina
42	SD	US	South Dakota
43	TN	US	Tennessee
44	TX	US	Texas
45	UT	US	Utah
46	VT	US	Vermont
47	VA	US	Virginia
48	WA	US	Washington
49	WV	US	West Virginia
50	WI	US	Wisconsin
51	WY	US	Wyoming
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.products (product_id, unit_price, units_in_stock, weight, bonuses, sell_start_date, sell_end_date, created_at, modified_at) FROM stdin;
3	49.99	1000	498	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
5	33.95	1000	1047	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
4	33.95	1000	889	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
108	30.46	1000	1243	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
109	61.94	1000	1379	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
110	10.59	1000	1446	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
111	97.34	1000	1471	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
112	61.92	1000	675	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
113	37.97	1000	1381	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
114	12.17	1000	1239	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
115	11.31	1000	1251	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
132	62.96	1000	1155	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
133	59.56	1000	780	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
134	70.64	1000	923	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
135	88.65	1000	1115	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
136	39.73	1000	1305	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
137	23.46	1000	1488	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
138	14.49	1000	1130	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
139	48.61	1000	1421	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
140	72.4	1000	934	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
141	55.14	1000	646	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
142	11.5	1000	587	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
143	16.71	1000	755	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
144	76.28	1000	1281	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
145	65.83	1000	966	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
146	78.09	1000	1488	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
147	60.54	1000	1002	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
148	25.13	1000	758	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
149	32.58	1000	675	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
150	47.57	1000	716	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
151	60.32	1000	1249	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
152	83.56	1000	1278	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
153	25.25	1000	866	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
154	27.72	1000	743	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
155	21.68	1000	889	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
156	43.06	1000	1479	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
157	57.96	1000	891	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
158	92.13	1000	864	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
159	25.12	1000	573	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
160	71.58	1000	1122	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
161	90.69	1000	1175	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
162	73.29	1000	1214	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
163	85.71	1000	1447	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
164	95.13	1000	896	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
165	74.03	1000	1044	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
166	98.53	1000	996	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
167	14.98	1000	1398	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
168	71.73	1000	751	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
169	21.65	1000	1377	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
170	20.83	1000	624	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
171	58.84	1000	962	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
172	67.14	1000	1000	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
173	74.13	1000	656	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
174	24.94	1000	948	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
175	85.35	1000	836	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
176	58.18	1000	855	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
177	60.32	1000	1223	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
178	32.74	1000	1031	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
179	63.43	1000	1271	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
180	94.46	1000	1421	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
181	26.66	1000	1140	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
182	81.17	1000	1445	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
183	57.51	1000	782	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
184	45.23	1000	1135	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
185	14.86	1000	563	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
186	34.12	1000	764	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
187	72.52	1000	1278	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
188	97.29	1000	1136	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
189	72.32	1000	1252	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
190	13.81	1000	1231	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
191	11.65	1000	794	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
192	12.83	1000	576	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
193	78.85	1000	1123	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
194	48.64	1000	676	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
195	78.7	1000	1506	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
196	68.24	1000	689	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
197	39.94	1000	1286	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
198	22.07	1000	1118	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
199	86.39	1000	561	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
200	51.31	1000	520	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
201	18.94	1000	701	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
202	12.69	1000	1012	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
203	26.14	1000	1119	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
204	30.25	1000	1165	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
205	82.97	1000	1252	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
206	23.77	1000	968	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
207	21.62	1000	682	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
208	86.94	1000	1149	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
209	82.02	1000	664	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
210	14.98	1000	587	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
1	4.95	1000	726	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-14 09:34:32.144316
2	18.99	1000	975	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-14 09:34:32.144316
211	79.23	1000	1448	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
212	92.43	1000	860	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
213	51.04	1000	1135	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
214	93.28	1000	994	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
215	42.33	1000	1476	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
216	39.03	1000	541	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
217	22.31	1000	620	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
218	91.44	1000	1313	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
219	33.99	1000	1064	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
220	15.1	1000	555	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
221	63.62	1000	861	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
222	80.56	1000	1035	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
223	22.8	1000	534	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
224	75.29	1000	802	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
225	57.15	1000	1133	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
226	58.75	1000	961	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
227	50.31	1000	864	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
228	70.45	1000	666	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
229	27.78	1000	835	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
230	13.6	1000	1461	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
231	39.66	1000	1428	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
232	42.45	1000	1480	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
233	25.45	1000	715	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
234	18.01	1000	564	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
235	52.7	1000	1259	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
236	70.54	1000	804	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
237	46.61	1000	645	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
238	70.74	1000	1388	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
239	83.54	1000	1276	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
240	48.1	1000	555	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
241	83.76	1000	1227	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
242	40.11	1000	972	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
243	68.7	1000	1019	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
244	98.03	1000	989	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
245	98.66	1000	1200	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
246	35.72	1000	885	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
247	65.22	1000	964	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
248	51.2	1000	1372	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
249	59.12	1000	1480	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
250	11.82	1000	1127	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
251	24.15	1000	1473	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
252	20.33	1000	684	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
253	54.5	1000	799	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
254	87.13	1000	1358	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
255	46.76	1000	1414	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
256	49.87	1000	809	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
257	10.54	1000	1199	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
258	23.23	1000	537	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
259	69.95	1000	1488	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
260	69.84	1000	1095	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
261	37.27	1000	1346	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
262	94.46	1000	1382	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
263	86.42	1000	1055	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
264	46.39	1000	838	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
265	78.71	1000	1198	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
266	61.29	1000	1042	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
267	64.19	1000	1021	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
268	17.33	1000	1076	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
269	23.25	1000	1372	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
270	45.99	1000	823	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
271	62.08	1000	712	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
272	85.23	1000	1064	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
273	45.65	1000	1324	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
274	99.96	1000	1472	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
275	30.27	1000	886	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
276	63.48	1000	1327	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
277	86.27	1000	950	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
278	98.88	1000	594	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
279	73.9	1000	1305	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
280	42.94	1000	1323	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
281	72.6	1000	1478	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
282	37.37	1000	1344	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
283	88.09	1000	1039	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
284	19.12	1000	1185	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
285	79.42	1000	571	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
286	23.65	1000	1386	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
287	49.18	1000	708	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
288	39.76	1000	1296	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
289	24.89	1000	705	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
290	57.37	1000	986	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
291	61.97	1000	974	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
292	56.79	1000	1033	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
293	22.4	1000	608	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
294	74.43	1000	660	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
295	33.17	1000	1428	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
296	15.31	1000	861	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
297	19.04	1000	716	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
298	65.64	1000	822	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
299	19.95	1000	1274	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
300	69.26	1000	728	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
301	71.23	1000	679	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
302	69.4	1000	1421	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
303	42.51	1000	839	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
304	92.3	1000	825	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
305	25.73	1000	501	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
306	86.62	1000	1144	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
307	94.64	1000	1396	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
308	37.06	1000	1204	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
309	40.51	1000	692	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
310	35.9	1000	904	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
311	78.69	1000	1337	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
312	74.03	1000	1461	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
313	27.26	1000	978	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
314	21.04	1000	1178	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
315	77.49	1000	1026	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
316	71.43	1000	1421	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
317	59.97	1000	605	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
318	87.29	1000	594	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
319	82.43	1000	678	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
320	51.21	1000	712	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
321	17.77	1000	593	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
322	35.94	1000	817	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
323	46.19	1000	1375	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
324	76.25	1000	1200	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
325	21.27	1000	1340	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
326	85.7	1000	877	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
327	18.47	1000	1174	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
328	22.51	1000	1068	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
329	54.85	1000	685	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
330	52.24	1000	1064	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
331	79.13	1000	1428	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
332	90.93	1000	1504	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
333	55.32	1000	1345	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
334	47.93	1000	1311	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
335	51.18	1000	1177	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
336	69.84	1000	1495	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
337	91.83	1000	1275	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
338	69.42	1000	688	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
339	18.37	1000	1422	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
340	30.92	1000	716	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
341	78.01	1000	663	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
342	65.49	1000	1465	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
343	21.44	1000	1073	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
344	34.94	1000	986	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
345	25.23	1000	665	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
346	30.03	1000	1446	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
347	74.25	1000	948	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
348	37.59	1000	526	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
349	60.72	1000	725	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
350	41.59	1000	1325	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
367	90.9	1000	1452	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
368	69.4	1000	842	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
369	36.89	1000	1016	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
370	33.65	1000	783	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
371	78.44	1000	1368	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
372	82.31	1000	1207	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
373	66.49	1000	729	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
374	95.47	1000	1180	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
375	29.2	1000	1152	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
376	26.63	1000	689	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
377	68.49	1000	574	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
378	69.07	1000	1274	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
379	62.94	1000	679	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
380	50.15	1000	988	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
381	86.5	1000	1152	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
382	77.91	1000	999	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
383	12.65	1000	1235	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
384	35.78	1000	1186	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
385	79.35	1000	832	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
386	85.83	1000	778	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
387	85.52	1000	709	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
388	80.3	1000	914	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
389	84.24	1000	1028	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
390	48.15	1000	1214	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
391	30.27	1000	1067	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
392	17.14	1000	814	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
393	91.42	1000	723	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
394	66.96	1000	1119	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
395	15.6	1000	1200	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
396	92.17	1000	1394	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
397	26.97	1000	605	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
398	15.56	1000	1004	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
399	71.38	1000	1350	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
400	41.19	1000	924	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
401	50.43	1000	1045	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
402	37.94	1000	509	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
412	62.93	1000	1465	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
413	99.06	1000	1117	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
414	95.97	1000	948	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
415	90.18	1000	1415	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
416	12	1000	1288	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
417	73.09	1000	1283	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
418	90.11	1000	1425	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
419	62.99	1000	1472	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
420	48.51	1000	725	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
421	85.8	1000	1234	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
422	65.8	1000	1183	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
423	49.46	1000	1400	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
424	59.36	1000	1153	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
425	20.67	1000	1058	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
426	37.18	1000	771	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
427	53.5	1000	1142	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
428	17.38	1000	795	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
429	69.08	1000	1303	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
49	17.53	1000	968	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
50	53.83	1000	1275	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
51	93.3	1000	1051	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
52	87.67	1000	849	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
53	13.52	1000	834	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
54	96.76	1000	1321	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
55	74.09	1000	1256	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
56	75.87	1000	1207	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
57	32.74	1000	751	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
58	70.76	1000	1100	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
59	60.02	1000	636	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
60	60.51	1000	895	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
61	74.04	1000	764	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
62	84.74	1000	992	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
63	84.55	1000	1087	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
64	62.76	1000	1234	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
430	75.85	1000	706	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
431	91.09	1000	1183	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
6	79.16	1000	658	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
7	28.54	1000	1397	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
8	98.93	1000	1294	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
9	67.13	1000	596	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
10	21.17	1000	868	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
11	79.83	1000	1240	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
12	37.36	1000	1127	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
13	43.61	1000	641	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
14	14.96	1000	755	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
15	32.24	1000	717	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
16	49.83	1000	508	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
17	58.7	1000	1363	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
18	25.55	1000	1261	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
19	22.78	1000	1372	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
20	99.97	1000	1249	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
21	31.15	1000	1138	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
22	83.76	1000	667	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
23	97.58	1000	670	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
24	77.36	1000	982	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
25	44.08	1000	1288	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
26	74.45	1000	672	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
27	85.47	1000	904	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
28	32.95	1000	1468	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
29	12.21	1000	1250	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
30	25.34	1000	941	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
31	59.31	1000	1290	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
32	62.38	1000	660	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
33	53.2	1000	601	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
34	86.38	1000	967	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
35	97.31	1000	726	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
36	65.33	1000	726	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
37	45.93	1000	999	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
38	48.13	1000	1322	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
39	88.21	1000	775	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
40	51.85	1000	768	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
41	82.09	1000	1305	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
42	87.77	1000	1148	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
43	90.41	1000	1286	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
44	53.7	1000	611	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
45	64.85	1000	866	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
46	42.28	1000	714	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
47	10.62	1000	1488	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
48	99.96	1000	565	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
351	47.94	1000	741	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
352	96.37	1000	1309	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
353	39.8	1000	1450	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
354	47.97	1000	561	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
355	38.04	1000	835	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
356	53.41	1000	581	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
357	93.42	1000	1019	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
358	45.58	1000	650	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
359	83.22	1000	1486	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
360	97.34	1000	1322	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
361	16.92	1000	847	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
362	38.69	1000	1232	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
363	23.56	1000	905	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
364	38.4	1000	636	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
365	74.66	1000	1327	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
366	75.67	1000	1187	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
65	26.43	1000	1004	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
66	38.45	1000	1260	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
67	63.7	1000	652	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
68	87.92	1000	960	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
69	40.35	1000	1355	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
70	34.01	1000	1391	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
71	12.85	1000	861	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
72	75.04	1000	1480	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
73	53.89	1000	1168	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
74	66.15	1000	714	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
75	45.21	1000	1266	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
76	73.88	1000	682	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
77	29.35	1000	740	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
78	52.89	1000	560	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
79	19.54	1000	503	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
80	78.69	1000	519	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
81	71.31	1000	832	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
82	54.93	1000	1054	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
83	17.46	1000	1245	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
84	10.07	1000	1129	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
85	19.08	1000	1077	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
86	54.94	1000	1170	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
87	99.96	1000	881	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
88	83.11	1000	951	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
89	95.92	1000	1160	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
90	38.75	1000	952	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
91	48.58	1000	530	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
92	91.74	1000	983	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
93	46.73	1000	1034	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
94	89.55	1000	793	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
95	67.74	1000	1464	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
96	88.74	1000	1276	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
97	94.85	1000	1354	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
98	27.55	1000	1051	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
99	93.82	1000	1243	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
100	90.83	1000	1079	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
101	34.76	1000	848	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
102	99.35	1000	751	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
103	39.67	1000	870	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
104	63.74	1000	1204	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
105	22.11	1000	1229	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
106	14.05	1000	1426	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
107	95.72	1000	1008	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
116	26.34	1000	1257	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
117	73.03	1000	1201	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
118	41.77	1000	1325	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
119	72.55	1000	1015	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
120	66.49	1000	904	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
121	59.21	1000	972	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
122	87.97	1000	1290	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
123	76.82	1000	861	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
124	44.93	1000	878	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
125	33.27	1000	1094	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
126	76.91	1000	615	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
127	96.88	1000	612	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
128	82.66	1000	678	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
129	43.76	1000	1179	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
130	71.53	1000	1047	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
131	90.45	1000	1424	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
403	70.13	1000	1507	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
404	69.88	1000	1261	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
405	19.85	1000	1300	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
406	64.76	1000	622	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
407	88.91	1000	1398	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
408	68.55	1000	1079	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
409	30.03	1000	718	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
410	48.7	1000	689	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
411	84.6	1000	1412	10	2023-08-01	\N	2023-08-06 13:32:02.785667	2023-08-06 13:32:02.785667
\.


--
-- Data for Name: credit_cards; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.credit_cards (card_id, card_type, card_number, exp_month, exp_year, created_at, modified_at) FROM stdin;
1	mastercard	5108757633884809	6	2028	2023-08-06 13:45:08.330044	2023-08-06 13:45:08.330044
2	mastercard	5108750369468731	5	2028	2023-08-06 13:45:08.348713	2023-08-06 13:45:08.348713
3	mastercard	5048375674863674	9	2028	2023-08-06 13:45:08.371438	2023-08-06 13:45:08.371438
4	mastercard	5108752508568512	2	2028	2023-08-06 13:45:08.385655	2023-08-06 13:45:08.385655
5	mastercard	5048376890499517	0	2028	2023-08-06 13:45:08.399383	2023-08-06 13:45:08.399383
6	mastercard	5048373024442448	6	2028	2023-08-06 13:45:08.413199	2023-08-06 13:45:08.413199
7	mastercard	5108759873475124	3	2028	2023-08-06 13:45:08.426955	2023-08-06 13:45:08.426955
8	mastercard	5048376064863316	5	2028	2023-08-06 13:45:08.441142	2023-08-06 13:45:08.441142
9	mastercard	5108751250142088	9	2028	2023-08-06 13:45:08.454886	2023-08-06 13:45:08.454886
10	mastercard	5048371140829605	6	2028	2023-08-06 13:45:08.46871	2023-08-06 13:45:08.46871
11	mastercard	5108758653338171	10	2028	2023-08-06 16:57:08.296981	2023-08-06 16:57:08.296981
12	mastercard	5048376694608958	3	2028	2023-08-06 16:57:08.377241	2023-08-06 16:57:08.377241
13	mastercard	5048373159746936	5	2028	2023-08-06 16:57:08.427571	2023-08-06 16:57:08.427571
14	mastercard	5108756838462304	10	2028	2023-08-06 16:57:08.482448	2023-08-06 16:57:08.482448
15	mastercard	5048370895488583	3	2028	2023-08-06 16:57:08.55051	2023-08-06 16:57:08.55051
16	mastercard	5108750007446289	2	2028	2023-08-06 16:57:08.637442	2023-08-06 16:57:08.637442
17	mastercard	5108754083360976	2	2028	2023-08-06 16:57:08.696085	2023-08-06 16:57:08.696085
18	mastercard	5108753071951002	10	2028	2023-08-06 16:57:08.751977	2023-08-06 16:57:08.751977
19	mastercard	5108755961702403	10	2028	2023-08-06 16:57:08.80917	2023-08-06 16:57:08.80917
20	mastercard	5108751341638318	10	2028	2023-08-06 16:57:08.867457	2023-08-06 16:57:08.867457
21	mastercard	5108755295503592	10	2028	2023-08-06 16:57:08.927479	2023-08-06 16:57:08.927479
22	mastercard	5048377081352788	5	2028	2023-08-06 16:57:08.985033	2023-08-06 16:57:08.985033
23	mastercard	5048370696524941	12	2028	2023-08-06 16:57:09.04572	2023-08-06 16:57:09.04572
24	mastercard	5048373670492739	4	2028	2023-08-06 16:57:09.116584	2023-08-06 16:57:09.116584
25	mastercard	5048378828502131	1	2028	2023-08-06 16:57:09.181418	2023-08-06 16:57:09.181418
26	mastercard	5048372676810928	8	2028	2023-08-06 16:57:09.244881	2023-08-06 16:57:09.244881
27	mastercard	5108759257195959	11	2028	2023-08-06 16:57:09.308391	2023-08-06 16:57:09.308391
28	mastercard	5108756892553675	9	2028	2023-08-06 16:57:09.381129	2023-08-06 16:57:09.381129
29	mastercard	5108757024497120	2	2028	2023-08-06 16:57:09.453522	2023-08-06 16:57:09.453522
30	mastercard	5048378188823697	7	2028	2023-08-06 16:57:09.504397	2023-08-06 16:57:09.504397
31	mastercard	5048372481684716	5	2028	2023-08-06 16:57:09.556864	2023-08-06 16:57:09.556864
32	mastercard	5048375595762187	2	2028	2023-08-06 16:57:09.616204	2023-08-06 16:57:09.616204
33	mastercard	5048374164241897	9	2028	2023-08-06 16:57:09.671728	2023-08-06 16:57:09.671728
34	mastercard	5048371713860219	12	2028	2023-08-06 16:57:09.725991	2023-08-06 16:57:09.725991
35	mastercard	5108750674241070	4	2028	2023-08-06 16:57:09.778026	2023-08-06 16:57:09.778026
36	mastercard	5108758497410723	10	2028	2023-08-06 16:57:09.830398	2023-08-06 16:57:09.830398
37	mastercard	5048377806704412	10	2028	2023-08-06 16:57:09.89627	2023-08-06 16:57:09.89627
38	mastercard	5048373816179299	3	2028	2023-08-06 16:57:10.010906	2023-08-06 16:57:10.010906
39	mastercard	5048370470438862	4	2028	2023-08-06 16:57:10.059621	2023-08-06 16:57:10.059621
40	mastercard	5108754922406238	9	2028	2023-08-06 16:57:10.11857	2023-08-06 16:57:10.11857
41	mastercard	5108759493658398	9	2028	2023-08-06 16:57:10.171603	2023-08-06 16:57:10.171603
42	mastercard	5048379042840570	12	2028	2023-08-06 16:57:10.224488	2023-08-06 16:57:10.224488
43	mastercard	5048376661011319	8	2028	2023-08-06 16:57:10.277022	2023-08-06 16:57:10.277022
44	mastercard	5108756427606956	6	2028	2023-08-06 16:57:10.328756	2023-08-06 16:57:10.328756
45	mastercard	5048378395803474	1	2028	2023-08-06 16:57:10.390504	2023-08-06 16:57:10.390504
46	mastercard	5108759202318110	6	2028	2023-08-06 16:57:10.448014	2023-08-06 16:57:10.448014
47	mastercard	5048373984865901	3	2028	2023-08-06 16:57:10.499064	2023-08-06 16:57:10.499064
48	mastercard	5048375854075149	9	2028	2023-08-06 16:57:10.554712	2023-08-06 16:57:10.554712
49	mastercard	5108757999475507	7	2028	2023-08-06 16:57:10.615105	2023-08-06 16:57:10.615105
50	mastercard	5108757120150359	8	2028	2023-08-06 16:57:10.676837	2023-08-06 16:57:10.676837
51	mastercard	5108754658712262	12	2028	2023-08-06 16:57:10.731058	2023-08-06 16:57:10.731058
52	mastercard	5048371246025637	10	2028	2023-08-06 16:57:10.788524	2023-08-06 16:57:10.788524
53	mastercard	5108757376693177	8	2028	2023-08-06 16:57:10.856197	2023-08-06 16:57:10.856197
54	mastercard	5108756419774531	1	2028	2023-08-06 16:57:10.906051	2023-08-06 16:57:10.906051
55	mastercard	5108756383168991	9	2028	2023-08-06 16:57:10.963185	2023-08-06 16:57:10.963185
56	mastercard	5108750333111672	3	2028	2023-08-06 16:57:11.01887	2023-08-06 16:57:11.01887
57	mastercard	5108759844230673	4	2028	2023-08-06 16:57:11.074917	2023-08-06 16:57:11.074917
58	mastercard	5108756439757615	1	2028	2023-08-06 16:57:11.143539	2023-08-06 16:57:11.143539
59	mastercard	5048379711856543	11	2028	2023-08-06 16:57:11.195129	2023-08-06 16:57:11.195129
60	mastercard	5108759968961848	7	2028	2023-08-06 16:57:11.250298	2023-08-06 16:57:11.250298
61	mastercard	5108757681951153	5	2028	2023-08-06 16:57:11.300129	2023-08-06 16:57:11.300129
62	mastercard	5108750651125858	9	2028	2023-08-06 16:57:11.363573	2023-08-06 16:57:11.363573
63	mastercard	5108752314533973	6	2028	2023-08-06 16:57:11.41967	2023-08-06 16:57:11.41967
64	mastercard	5048375061973110	2	2028	2023-08-06 16:57:11.474554	2023-08-06 16:57:11.474554
65	mastercard	5048374639091828	7	2028	2023-08-06 16:57:11.536006	2023-08-06 16:57:11.536006
66	mastercard	5048378330335558	11	2028	2023-08-06 16:57:11.605196	2023-08-06 16:57:11.605196
67	mastercard	5108758498447690	10	2028	2023-08-06 16:57:11.668984	2023-08-06 16:57:11.668984
68	mastercard	5048378922360741	12	2028	2023-08-06 16:57:11.734802	2023-08-06 16:57:11.734802
69	mastercard	5048376277459324	3	2028	2023-08-06 16:57:11.796033	2023-08-06 16:57:11.796033
70	mastercard	5108751055844359	1	2028	2023-08-06 16:57:11.86515	2023-08-06 16:57:11.86515
71	mastercard	5108756860394243	3	2028	2023-08-06 16:57:11.924139	2023-08-06 16:57:11.924139
72	mastercard	5048371566265060	8	2028	2023-08-06 16:57:11.977209	2023-08-06 16:57:11.977209
73	mastercard	5048375484318679	8	2028	2023-08-06 16:57:12.032731	2023-08-06 16:57:12.032731
74	mastercard	5108759360972815	7	2028	2023-08-06 16:57:12.084604	2023-08-06 16:57:12.084604
75	mastercard	5108755492758643	2	2028	2023-08-06 16:57:12.150659	2023-08-06 16:57:12.150659
76	mastercard	5048371557405030	2	2028	2023-08-06 16:57:12.209125	2023-08-06 16:57:12.209125
77	mastercard	5108757233337695	8	2028	2023-08-06 16:57:12.276139	2023-08-06 16:57:12.276139
78	mastercard	5108752546212214	5	2028	2023-08-06 16:57:12.335088	2023-08-06 16:57:12.335088
79	mastercard	5048371142655438	12	2028	2023-08-06 16:57:12.404092	2023-08-06 16:57:12.404092
80	mastercard	5048379789238608	12	2028	2023-08-06 16:57:12.486979	2023-08-06 16:57:12.486979
81	mastercard	5048374933712111	8	2028	2023-08-06 16:57:12.557933	2023-08-06 16:57:12.557933
82	mastercard	5048371620951838	9	2028	2023-08-06 16:57:12.633238	2023-08-06 16:57:12.633238
83	mastercard	5108751436764094	7	2028	2023-08-06 16:57:12.703339	2023-08-06 16:57:12.703339
84	mastercard	5048375074647487	5	2028	2023-08-06 16:57:12.768983	2023-08-06 16:57:12.768983
85	mastercard	5048378930562254	7	2028	2023-08-06 16:57:12.82837	2023-08-06 16:57:12.82837
86	mastercard	5108750741362347	10	2028	2023-08-06 16:57:12.935705	2023-08-06 16:57:12.935705
87	mastercard	5108753770360463	2	2028	2023-08-06 16:57:12.999771	2023-08-06 16:57:12.999771
88	mastercard	5048373232135511	5	2028	2023-08-06 16:57:13.062281	2023-08-06 16:57:13.062281
89	mastercard	5108759641400255	2	2028	2023-08-06 16:57:13.133946	2023-08-06 16:57:13.133946
90	mastercard	5108751815606502	7	2028	2023-08-06 16:57:13.189437	2023-08-06 16:57:13.189437
91	mastercard	5048376425454037	1	2028	2023-08-06 16:57:13.245527	2023-08-06 16:57:13.245527
92	mastercard	5048374906247574	1	2028	2023-08-06 16:57:13.296298	2023-08-06 16:57:13.296298
93	mastercard	5048373237019918	4	2028	2023-08-06 16:57:13.350963	2023-08-06 16:57:13.350963
94	mastercard	5048379698185460	12	2028	2023-08-06 16:57:13.412435	2023-08-06 16:57:13.412435
95	mastercard	5108757419723999	1	2028	2023-08-06 16:57:13.465846	2023-08-06 16:57:13.465846
96	mastercard	5048378871496983	8	2028	2023-08-06 16:57:13.51797	2023-08-06 16:57:13.51797
97	mastercard	5048374468756277	10	2028	2023-08-06 16:57:13.575011	2023-08-06 16:57:13.575011
98	mastercard	5048375721498383	2	2028	2023-08-06 16:57:13.646116	2023-08-06 16:57:13.646116
99	mastercard	5048379250497402	12	2028	2023-08-06 16:57:13.704459	2023-08-06 16:57:13.704459
100	mastercard	5108750450188636	8	2028	2023-08-06 16:57:13.761473	2023-08-06 16:57:13.761473
\.


--
-- Data for Name: customer_bonus_cards; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.customer_bonus_cards (customer_id, barcode, balance, created_at, modified_at) FROM stdin;
39	4041013024214	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
28	0892572998137	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
77	4296154997998	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
82	0808368240998	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
55	8777973691055	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
75	0386591336085	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
46	2748219921672	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
36	5161862459429	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
66	4005835397985	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
2	8512424008664	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
72	2565269412306	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
6	8283735653145	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
53	7760412815490	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
18	7759422012822	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
57	8237441767737	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
62	8852159200089	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
22	4041478832371	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
29	7690261185682	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
31	6710150826185	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
52	7960644235651	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
93	3759133930486	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
58	1336366872482	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
89	1919941195101	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
94	5009227238817	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
91	0607208160671	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
88	7470313514031	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
11	6218268717884	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
78	5671639660229	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
8	0878978148427	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
70	0894133444076	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
34	5196759783391	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
86	3858444176145	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
16	8598591764933	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
56	1075746538195	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
40	7590879969599	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
50	4269652303310	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
48	3973342390500	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
96	8289717675829	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
24	2747582178815	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
30	4761494185819	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
42	6566031842769	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
92	3840847015237	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
64	0182776660982	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
44	4682695552627	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
32	3903636278058	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
60	9013530760321	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
98	3237925051734	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
100	9089054760613	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
76	0549695849869	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
74	5721781231049	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
4	4822141496536	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
15	1428867109165	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
38	3206923393080	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
83	4646124211493	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
63	4353980259822	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
54	8226607657258	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
12	0157385456332	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
69	7922318692783	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
67	1779815093842	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
14	6505066942907	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
26	6907177012934	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
21	4093808272232	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
23	1558505457554	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
20	5383069302802	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
49	6045550945757	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
68	8904434251421	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
13	1354688527364	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
10	3219856702114	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
19	8768770486769	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
81	1598535404951	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
80	9101572942481	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
9	0783700747751	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
3	2763695076839	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
5	6682025981092	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
7	7786873885467	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
1	1678952858606	70	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
84	1733700412288	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
90	4679725903009	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
85	7436932261427	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
87	4876098437938	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
51	2724526480747	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
43	5170873527379	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
97	4327497394996	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
35	3177435860489	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
59	1393550430012	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
17	8388957603126	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
73	6137329450763	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
95	6940831867795	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
65	8297453366222	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
71	9676054172920	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
27	3571835149870	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
25	9982636410556	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
37	4483035345208	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
99	0344796456503	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
41	2758350050916	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
33	5860641892793	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
61	7772280627639	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
45	0542229753054	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
47	6282329305644	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
79	9572674060088	10	2023-08-06 16:42:13.817172	2023-08-14 08:54:02.38082
\.


--
-- Data for Name: customer_credit_cards; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.customer_credit_cards (customer_id, card_id, is_current_card) FROM stdin;
1	1	t
2	2	t
3	3	t
4	4	t
5	5	t
6	6	t
7	7	t
8	8	t
9	9	t
10	10	t
11	11	t
12	12	t
13	13	t
14	14	t
15	15	t
16	16	t
17	17	t
18	18	t
19	19	t
20	20	t
21	21	t
22	22	t
23	23	t
24	24	t
25	25	t
26	26	t
27	27	t
28	28	t
29	29	t
30	30	t
31	31	t
32	32	t
33	33	t
34	34	t
35	35	t
36	36	t
37	37	t
38	38	t
39	39	t
40	40	t
41	41	t
42	42	t
43	43	t
44	44	t
45	45	t
46	46	t
47	47	t
48	48	t
49	49	t
50	50	t
51	51	t
52	52	t
53	53	t
54	54	t
55	55	t
56	56	t
57	57	t
58	58	t
59	59	t
60	60	t
61	61	t
62	62	t
63	63	t
64	64	t
65	65	t
66	66	t
67	67	t
68	68	t
69	69	t
70	70	t
71	71	t
72	72	t
73	73	t
74	74	t
75	75	t
76	76	t
77	77	t
78	78	t
79	79	t
80	80	t
81	81	t
82	82	t
83	83	t
84	84	t
85	85	t
86	86	t
87	87	t
88	88	t
89	89	t
90	90	t
91	91	t
92	92	t
93	93	t
94	94	t
95	95	t
96	96	t
97	97	t
98	98	t
99	99	t
100	100	t
\.


--
-- Data for Name: customer_personal_promocodes; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.customer_personal_promocodes (promocode_id, customer_id, promocode, rate, valid_from, valid_to, used, created_at, modified_at) FROM stdin;
1	1	BOOKehi-tE4-S7u-Zst	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
2	2	BOOKef8-sVe-3of-cOa	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
3	3	BOOK3p3-n65-Q4S-gfK	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
4	4	BOOKYxk-VIZ-NA0-5dz	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
5	5	BOOKfhD-wKE-DB3-5U8	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
6	6	BOOKXsh-nqB-pNm-8KF	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
7	7	BOOKtbb-KoR-NWu-e4C	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
8	8	BOOKHBG-rVD-J2w-k8A	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
9	9	BOOKYwP-MjT-FJz-h6l	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
10	10	BOOKIrY-U3u-XBe-FBb	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
11	11	BOOK5bL-rJ4-kQ5-82v	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
12	12	BOOKXg9-zpv-tLb-38I	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
13	13	BOOKTkK-AwC-Ode-9f0	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
14	14	BOOK60I-enp-dr1-7Mx	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
15	15	BOOK2Se-aXe-aBW-yJw	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
16	16	BOOKc20-iC4-y5R-qcC	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
17	17	BOOKYDW-a9b-Qr8-z8B	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
18	18	BOOKJZf-ymL-k7x-12W	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
19	19	BOOKLxa-ZES-P6a-azV	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
20	20	BOOKzsP-TIC-GmP-nUA	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
21	21	BOOKz50-0WA-N6W-pxh	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
22	22	BOOKDZD-wF5-QCj-I7x	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
23	23	BOOKWu0-tgw-Cs3-cvB	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
24	24	BOOKQ9a-mnd-AsJ-2LY	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
25	25	BOOKmHw-75D-Gtn-U4z	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
26	26	BOOKIZV-pO3-bKN-fB8	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
27	27	BOOK8C5-qTe-WlG-wED	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
28	28	BOOKZGq-Gd5-BR5-OrM	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
29	29	BOOKjfW-cZ2-WVK-IQ5	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
30	30	BOOKU70-SeE-ltf-dj0	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
31	31	BOOKYxU-2DY-r8s-6L0	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
32	32	BOOKP2E-3sw-8AH-U5q	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
33	33	BOOKXmE-FrU-rYT-vol	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
34	34	BOOKk3j-pPA-DQ6-kc1	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
35	35	BOOKnga-zsv-7tD-PP4	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
36	36	BOOKqFs-MHa-XNN-rB2	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
37	37	BOOK5Tu-MQa-Gus-DRv	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
38	38	BOOKoXo-uNR-0Rk-XnS	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
39	39	BOOK8C4-PiD-VJw-Y0K	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
40	40	BOOK6Sa-3Rh-7Mh-uXs	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
41	41	BOOKkDw-9wF-mvx-7UW	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
42	42	BOOKhXL-hiX-qpM-bn7	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
43	43	BOOKhC4-poI-Dhc-CVb	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
44	44	BOOKfyi-mex-VEa-szT	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
45	45	BOOK6k3-Y4l-eFr-kND	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
46	46	BOOKJMP-aEJ-ixS-Kat	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
47	47	BOOKdyw-9SF-czi-p0z	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
48	48	BOOKTyS-QPY-xd6-QCx	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
49	49	BOOKGoO-fOi-W8S-ZAp	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
50	50	BOOK8id-PDh-R2G-Zin	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
51	51	BOOK3AL-EEV-jlB-xPf	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
52	52	BOOKh4d-IqU-hus-mjO	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
53	53	BOOKp7E-kVe-pXR-JCv	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
54	54	BOOK26I-NgD-3gQ-dmD	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
55	55	BOOKIBN-H2M-FAm-fP0	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
56	56	BOOKhMV-27q-Ucx-1if	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
57	57	BOOKze8-hoc-ei9-si5	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
58	58	BOOKvEq-CY1-CBU-yEI	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
59	59	BOOKUM0-aZp-nUB-hfV	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
60	60	BOOKFDN-tIz-rVx-2cK	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
61	61	BOOKE0h-Ry2-Yzm-tuB	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
62	62	BOOKvpV-IkV-P57-AvT	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
63	63	BOOKvqR-lii-ZKe-6Y7	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
64	64	BOOK3SZ-Ipo-VOL-Yo5	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
65	65	BOOKVxT-0Un-TeJ-0vo	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
66	66	BOOKpNK-LVw-t2a-f7n	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
67	67	BOOKBAP-bdV-ywF-6Vt	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
68	68	BOOKj8n-J5K-rJ2-UEs	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
69	69	BOOKbNW-FvB-uhI-R1M	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
70	70	BOOKqcH-dYu-nT7-TgV	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
71	71	BOOKF7o-tqw-38p-AwA	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
72	72	BOOKwgw-s9G-0ia-kBO	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
73	73	BOOKEGE-bz4-kFc-tmy	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
74	74	BOOKlP2-soP-769-tQA	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
75	75	BOOK19c-3Ab-Ov5-psB	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
76	76	BOOKyZO-itu-vqd-CUC	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
77	77	BOOKbt6-tfH-LBA-ugC	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
78	78	BOOK2D1-JIA-p5z-et0	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
79	79	BOOKNJg-PYf-C0w-pry	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
80	80	BOOKyRF-4ju-ISQ-mND	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
81	81	BOOKRIv-Gq8-LsB-Oe6	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
82	82	BOOKHhB-5rm-P8Z-oM9	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
83	83	BOOKe4b-ew3-XUf-k5p	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
84	84	BOOKdQw-9xX-6GS-l9n	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
85	85	BOOKJGK-8TP-xEC-ECW	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
86	86	BOOK34q-1ih-1Zd-igJ	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
87	87	BOOKmWw-MYS-nbw-WlH	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
88	88	BOOKWsn-dNZ-bZn-yYV	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
89	89	BOOK3sh-B38-jQn-xRf	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
90	90	BOOKtaG-R09-pVc-s0P	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
91	91	BOOKVLB-d92-ARn-3u8	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
92	92	BOOKDmP-11s-bL1-W27	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
93	93	BOOKGNp-fci-6iu-Km7	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
94	94	BOOKaiB-3ee-mWy-S7j	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
95	95	BOOKshW-CL8-MfD-Enj	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
96	96	BOOKEQ9-rJ0-zyX-pWU	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
97	97	BOOKOPK-JoB-RkF-G8F	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
98	98	BOOKsvf-Cxk-SeY-9nx	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
99	99	BOOKcLA-lP9-vRv-7cY	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
100	100	BOOKpVO-kWj-bZB-0NL	30	2023-07-31	2023-08-31	f	2023-08-06 16:47:17.760813	2023-08-06 16:47:17.760813
\.


--
-- Data for Name: method_deliveries; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.method_deliveries (delivery_id, delivery_name) FROM stdin;
1	Pickup
2	Courier
3	Mail
\.


--
-- Data for Name: method_payments; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.method_payments (payment_id, payment_name) FROM stdin;
1	Cash
2	Credit card
\.


--
-- Data for Name: order_lines; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.order_lines (line_id, order_id, product_id, unit_price, weight, bonuses, quantity, line_total, line_weight, line_bonuses) FROM stdin;
1	1	1	4.95	726	10	3	14.85	2178	30
2	1	2	18.99	975	10	3	56.97	2925	30
3	1	20	99.97	1249	10	1	99.97	1249	10
4	2	8	98.93	1294	10	1	98.93	1294	10
5	3	11	79.83	1240	10	1	79.83	1240	10
6	4	14	14.96	755	10	1	14.96	755	10
7	5	17	58.7	1363	10	1	58.7	1363	10
8	6	20	99.97	1249	10	1	99.97	1249	10
9	7	21	31.15	1138	10	1	31.15	1138	10
10	8	25	44.08	1288	10	1	44.08	1288	10
11	9	44	53.7	611	10	1	53.7	611	10
12	10	45	64.85	866	10	1	64.85	866	10
13	11	50	53.83	1275	10	1	53.83	1275	10
14	12	64	62.76	1234	10	1	62.76	1234	10
15	13	67	63.7	652	10	1	63.7	652	10
16	14	70	34.01	1391	10	1	34.01	1391	10
17	15	72	75.04	1480	10	1	75.04	1480	10
18	16	74	66.15	714	10	1	66.15	714	10
19	17	79	19.54	503	10	1	19.54	503	10
20	18	86	54.94	1170	10	1	54.94	1170	10
21	19	88	83.11	951	10	1	83.11	951	10
22	20	91	48.58	530	10	1	48.58	530	10
23	21	92	91.74	983	10	1	91.74	983	10
24	22	96	88.74	1276	10	1	88.74	1276	10
25	23	97	94.85	1354	10	1	94.85	1354	10
26	24	98	27.55	1051	10	1	27.55	1051	10
27	25	100	90.83	1079	10	1	90.83	1079	10
28	26	106	14.05	1426	10	1	14.05	1426	10
29	27	111	97.34	1471	10	1	97.34	1471	10
30	28	112	61.92	675	10	1	61.92	675	10
31	29	117	73.03	1201	10	1	73.03	1201	10
32	30	120	66.49	904	10	1	66.49	904	10
33	31	140	72.4	934	10	1	72.4	934	10
34	32	144	76.28	1281	10	1	76.28	1281	10
35	33	153	25.25	866	10	1	25.25	866	10
36	34	158	92.13	864	10	1	92.13	864	10
37	35	160	71.58	1122	10	1	71.58	1122	10
38	36	161	90.69	1175	10	1	90.69	1175	10
39	37	163	85.71	1447	10	1	85.71	1447	10
40	38	167	14.98	1398	10	1	14.98	1398	10
41	39	168	71.73	751	10	1	71.73	751	10
42	40	172	67.14	1000	10	1	67.14	1000	10
43	41	177	60.32	1223	10	1	60.32	1223	10
44	42	180	94.46	1421	10	1	94.46	1421	10
45	43	181	26.66	1140	10	1	26.66	1140	10
46	44	185	14.86	563	10	1	14.86	563	10
47	45	188	97.29	1136	10	1	97.29	1136	10
48	46	189	72.32	1252	10	1	72.32	1252	10
49	47	190	13.81	1231	10	1	13.81	1231	10
50	48	192	12.83	576	10	1	12.83	576	10
51	49	198	22.07	1118	10	1	22.07	1118	10
52	50	200	51.31	520	10	1	51.31	520	10
53	51	203	26.14	1119	10	1	26.14	1119	10
54	52	204	30.25	1165	10	1	30.25	1165	10
55	53	213	51.04	1135	10	1	51.04	1135	10
56	54	222	80.56	1035	10	1	80.56	1035	10
57	55	224	75.29	802	10	1	75.29	802	10
58	56	225	57.15	1133	10	1	57.15	1133	10
59	57	235	52.7	1259	10	1	52.7	1259	10
60	58	241	83.76	1227	10	1	83.76	1227	10
61	59	248	51.2	1372	10	1	51.2	1372	10
62	60	249	59.12	1480	10	1	59.12	1480	10
63	61	255	46.76	1414	10	1	46.76	1414	10
64	62	260	69.84	1095	10	1	69.84	1095	10
65	63	261	37.27	1346	10	1	37.27	1346	10
66	64	262	94.46	1382	10	1	94.46	1382	10
67	65	266	61.29	1042	10	1	61.29	1042	10
68	66	274	99.96	1472	10	1	99.96	1472	10
69	67	275	30.27	886	10	1	30.27	886	10
70	68	280	42.94	1323	10	1	42.94	1323	10
71	69	281	72.6	1478	10	1	72.6	1478	10
72	70	298	65.64	822	10	1	65.64	822	10
73	71	300	69.26	728	10	1	69.26	728	10
74	72	305	25.73	501	10	1	25.73	501	10
75	73	309	40.51	692	10	1	40.51	692	10
76	74	314	21.04	1178	10	1	21.04	1178	10
77	75	319	82.43	678	10	1	82.43	678	10
78	76	324	76.25	1200	10	1	76.25	1200	10
79	77	333	55.32	1345	10	1	55.32	1345	10
80	78	335	51.18	1177	10	1	51.18	1177	10
81	79	336	69.84	1495	10	1	69.84	1495	10
82	80	338	69.42	688	10	1	69.42	688	10
83	81	343	21.44	1073	10	1	21.44	1073	10
84	82	354	47.97	561	10	1	47.97	561	10
85	83	359	83.22	1486	10	1	83.22	1486	10
86	84	366	75.67	1187	10	1	75.67	1187	10
87	85	368	69.4	842	10	1	69.4	842	10
88	86	373	66.49	729	10	1	66.49	729	10
89	87	379	62.94	679	10	1	62.94	679	10
90	88	380	50.15	988	10	1	50.15	988	10
91	89	383	12.65	1235	10	1	12.65	1235	10
92	90	384	35.78	1186	10	1	35.78	1186	10
93	91	388	80.3	914	10	1	80.3	914	10
94	92	389	84.24	1028	10	1	84.24	1028	10
95	93	390	48.15	1214	10	1	48.15	1214	10
96	94	391	30.27	1067	10	1	30.27	1067	10
97	95	399	71.38	1350	10	1	71.38	1350	10
98	96	413	99.06	1117	10	1	99.06	1117	10
99	97	416	12	1288	10	1	12	1288	10
100	98	417	73.09	1283	10	1	73.09	1283	10
101	99	422	65.8	1183	10	1	65.8	1183	10
102	100	143	16.71	755	10	1	16.71	755	10
\.


--
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.order_statuses (status_id, status_name) FROM stdin;
1	Created
2	Paid
3	Shipped
4	Delivered
5	Delivered and paid
6	Cancelled
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.orders (order_id, customer_id, employee_id, total_sum, total_weight, total_bonuses, order_date, delivery_date, credit_card_id, method_payment_id, method_delivery_id, address_delivery_id, promocode, comment, status_id, created_at, modified_at) FROM stdin;
2	2	1	98.93	1294	10	2023-08-14	2023-08-28	2	2	2	2	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
3	3	1	79.83	1240	10	2023-08-14	2023-08-28	3	2	2	3	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
4	4	1	14.96	755	10	2023-08-14	2023-08-28	4	2	2	4	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
5	5	1	58.7	1363	10	2023-08-14	2023-08-28	5	2	2	5	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
6	6	1	99.97	1249	10	2023-08-14	2023-08-28	6	2	2	6	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
7	7	1	31.15	1138	10	2023-08-14	2023-08-28	7	2	2	7	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
8	8	1	44.08	1288	10	2023-08-14	2023-08-28	8	2	2	8	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
9	9	1	53.7	611	10	2023-08-14	2023-08-28	9	2	2	9	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
10	10	1	64.85	866	10	2023-08-14	2023-08-28	10	2	2	10	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
11	11	1	53.83	1275	10	2023-08-14	2023-08-28	11	2	2	11	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
12	12	1	62.76	1234	10	2023-08-14	2023-08-28	12	2	2	12	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
13	13	1	63.7	652	10	2023-08-14	2023-08-28	13	2	2	13	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
14	14	1	34.01	1391	10	2023-08-14	2023-08-28	14	2	2	14	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
15	15	1	75.04	1480	10	2023-08-14	2023-08-28	15	2	2	15	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
16	16	1	66.15	714	10	2023-08-14	2023-08-28	16	2	2	16	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
17	17	1	19.54	503	10	2023-08-14	2023-08-28	17	2	2	17	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
18	18	1	54.94	1170	10	2023-08-14	2023-08-28	18	2	2	18	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
19	19	1	83.11	951	10	2023-08-14	2023-08-28	19	2	2	19	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
20	20	1	48.58	530	10	2023-08-14	2023-08-28	20	2	2	20	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
21	21	1	91.74	983	10	2023-08-14	2023-08-28	21	2	2	21	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
22	22	1	88.74	1276	10	2023-08-14	2023-08-28	22	2	2	22	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
23	23	1	94.85	1354	10	2023-08-14	2023-08-28	23	2	2	23	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
24	24	1	27.55	1051	10	2023-08-14	2023-08-28	24	2	2	24	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
25	25	1	90.83	1079	10	2023-08-14	2023-08-28	25	2	2	25	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
26	26	1	14.05	1426	10	2023-08-14	2023-08-28	26	2	2	26	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
27	27	1	97.34	1471	10	2023-08-14	2023-08-28	27	2	2	27	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
28	28	1	61.92	675	10	2023-08-14	2023-08-28	28	2	2	28	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
29	29	1	73.03	1201	10	2023-08-14	2023-08-28	29	2	2	29	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
30	30	1	66.49	904	10	2023-08-14	2023-08-28	30	2	2	30	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
31	31	1	72.4	934	10	2023-08-14	2023-08-28	31	2	2	31	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
32	32	1	76.28	1281	10	2023-08-14	2023-08-28	32	2	2	32	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
33	33	1	25.25	866	10	2023-08-14	2023-08-28	33	2	2	33	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
34	34	1	92.13	864	10	2023-08-14	2023-08-28	34	2	2	34	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
35	35	1	71.58	1122	10	2023-08-14	2023-08-28	35	2	2	35	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
36	36	1	90.69	1175	10	2023-08-14	2023-08-28	36	2	2	36	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
37	37	1	85.71	1447	10	2023-08-14	2023-08-28	37	2	2	37	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
38	38	1	14.98	1398	10	2023-08-14	2023-08-28	38	2	2	38	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
39	39	1	71.73	751	10	2023-08-14	2023-08-28	39	2	2	39	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
40	40	1	67.14	1000	10	2023-08-14	2023-08-28	40	2	2	40	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
41	41	1	60.32	1223	10	2023-08-14	2023-08-28	41	2	2	41	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
42	42	1	94.46	1421	10	2023-08-14	2023-08-28	42	2	2	42	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
43	43	1	26.66	1140	10	2023-08-14	2023-08-28	43	2	2	43	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
44	44	1	14.86	563	10	2023-08-14	2023-08-28	44	2	2	44	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
45	45	1	97.29	1136	10	2023-08-14	2023-08-28	45	2	2	45	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
46	46	1	72.32	1252	10	2023-08-14	2023-08-28	46	2	2	46	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
47	47	1	13.81	1231	10	2023-08-14	2023-08-28	47	2	2	47	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
48	48	1	12.83	576	10	2023-08-14	2023-08-28	48	2	2	48	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
49	49	1	22.07	1118	10	2023-08-14	2023-08-28	49	2	2	49	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
50	50	1	51.31	520	10	2023-08-14	2023-08-28	50	2	2	50	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
51	51	1	26.14	1119	10	2023-08-14	2023-08-28	51	2	2	51	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
52	52	1	30.25	1165	10	2023-08-14	2023-08-28	52	2	2	52	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
53	53	1	51.04	1135	10	2023-08-14	2023-08-28	53	2	2	53	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
54	54	1	80.56	1035	10	2023-08-14	2023-08-28	54	2	2	54	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
55	55	1	75.29	802	10	2023-08-14	2023-08-28	55	2	2	55	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
56	56	1	57.15	1133	10	2023-08-14	2023-08-28	56	2	2	56	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
57	57	1	52.7	1259	10	2023-08-14	2023-08-28	57	2	2	57	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
58	58	1	83.76	1227	10	2023-08-14	2023-08-28	58	2	2	58	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
59	59	1	51.2	1372	10	2023-08-14	2023-08-28	59	2	2	59	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
60	60	1	59.12	1480	10	2023-08-14	2023-08-28	60	2	2	60	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
61	61	1	46.76	1414	10	2023-08-14	2023-08-28	61	2	2	61	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
62	62	1	69.84	1095	10	2023-08-14	2023-08-28	62	2	2	62	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
63	63	1	37.27	1346	10	2023-08-14	2023-08-28	63	2	2	63	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
64	64	1	94.46	1382	10	2023-08-14	2023-08-28	64	2	2	64	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
65	65	1	61.29	1042	10	2023-08-14	2023-08-28	65	2	2	65	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
66	66	1	99.96	1472	10	2023-08-14	2023-08-28	66	2	2	66	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
67	67	1	30.27	886	10	2023-08-14	2023-08-28	67	2	2	67	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
68	68	1	42.94	1323	10	2023-08-14	2023-08-28	68	2	2	68	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
69	69	1	72.6	1478	10	2023-08-14	2023-08-28	69	2	2	69	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
70	70	1	65.64	822	10	2023-08-14	2023-08-28	70	2	2	70	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
71	71	1	69.26	728	10	2023-08-14	2023-08-28	71	2	2	71	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
72	72	1	25.73	501	10	2023-08-14	2023-08-28	72	2	2	72	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
73	73	1	40.51	692	10	2023-08-14	2023-08-28	73	2	2	73	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
74	74	1	21.04	1178	10	2023-08-14	2023-08-28	74	2	2	74	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
75	75	1	82.43	678	10	2023-08-14	2023-08-28	75	2	2	75	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
76	76	1	76.25	1200	10	2023-08-14	2023-08-28	76	2	2	76	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
77	77	1	55.32	1345	10	2023-08-14	2023-08-28	77	2	2	77	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
78	78	1	51.18	1177	10	2023-08-14	2023-08-28	78	2	2	78	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
79	79	1	69.84	1495	10	2023-08-14	2023-08-28	79	2	2	79	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
80	80	1	69.42	688	10	2023-08-14	2023-08-28	80	2	2	80	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
81	81	1	21.44	1073	10	2023-08-14	2023-08-28	81	2	2	81	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
82	82	1	47.97	561	10	2023-08-14	2023-08-28	82	2	2	82	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
83	83	1	83.22	1486	10	2023-08-14	2023-08-28	83	2	2	83	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
84	84	1	75.67	1187	10	2023-08-14	2023-08-28	84	2	2	84	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
85	85	1	69.4	842	10	2023-08-14	2023-08-28	85	2	2	85	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
86	86	1	66.49	729	10	2023-08-14	2023-08-28	86	2	2	86	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
87	87	1	62.94	679	10	2023-08-14	2023-08-28	87	2	2	87	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
88	88	1	50.15	988	10	2023-08-14	2023-08-28	88	2	2	88	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
89	89	1	12.65	1235	10	2023-08-14	2023-08-28	89	2	2	89	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
90	90	1	35.78	1186	10	2023-08-14	2023-08-28	90	2	2	90	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
91	91	1	80.3	914	10	2023-08-14	2023-08-28	91	2	2	91	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
92	92	1	84.24	1028	10	2023-08-14	2023-08-28	92	2	2	92	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
93	93	1	48.15	1214	10	2023-08-14	2023-08-28	93	2	2	93	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
94	94	1	30.27	1067	10	2023-08-14	2023-08-28	94	2	2	94	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
95	95	1	71.38	1350	10	2023-08-14	2023-08-28	95	2	2	95	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
96	96	1	99.06	1117	10	2023-08-14	2023-08-28	96	2	2	96	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
97	97	1	12	1288	10	2023-08-14	2023-08-28	97	2	2	97	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
98	98	1	73.09	1283	10	2023-08-14	2023-08-28	98	2	2	98	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
99	99	1	65.8	1183	10	2023-08-14	2023-08-28	99	2	2	99	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
100	100	1	16.71	755	10	2023-08-14	2023-08-28	100	2	2	100	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 07:55:31.353809
1	1	1	71.82	5103	60	2023-08-03	2023-08-17	1	2	2	1	\N	\N	5	2023-08-14 06:48:37.932759	2023-08-14 08:49:02.933811
\.


--
-- Name: authors_author_id_seq; Type: SEQUENCE SET; Schema: book; Owner: postgres
--

SELECT pg_catalog.setval('book.authors_author_id_seq', 578, true);


--
-- Name: books_book_id_seq; Type: SEQUENCE SET; Schema: book; Owner: postgres
--

SELECT pg_catalog.setval('book.books_book_id_seq', 431, true);


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: book; Owner: postgres
--

SELECT pg_catalog.setval('book.categories_category_id_seq', 37, true);


--
-- Name: languages_language_id_seq; Type: SEQUENCE SET; Schema: book; Owner: postgres
--

SELECT pg_catalog.setval('book.languages_language_id_seq', 2, true);


--
-- Name: publishers_publisher_id_seq; Type: SEQUENCE SET; Schema: book; Owner: postgres
--

SELECT pg_catalog.setval('book.publishers_publisher_id_seq', 1, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: hr; Owner: postgres
--

SELECT pg_catalog.setval('hr.employees_employee_id_seq', 10, true);


--
-- Name: positions_position_id_seq; Type: SEQUENCE SET; Schema: hr; Owner: postgres
--

SELECT pg_catalog.setval('hr.positions_position_id_seq', 2, true);


--
-- Name: addresses_address_id_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.addresses_address_id_seq', 100, true);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.customers_customer_id_seq', 100, true);


--
-- Name: regions_region_id_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.regions_region_id_seq', 51, true);


--
-- Name: credit_cards_card_id_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.credit_cards_card_id_seq', 100, true);


--
-- Name: customer_personal_promocodes_promocode_id_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.customer_personal_promocodes_promocode_id_seq', 100, true);


--
-- Name: method_deliveries_delivery_id_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.method_deliveries_delivery_id_seq', 3, true);


--
-- Name: method_payments_payment_id_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.method_payments_payment_id_seq', 2, true);


--
-- Name: order_lines_line_id_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.order_lines_line_id_seq', 1, false);


--
-- Name: order_statuses_status_id_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.order_statuses_status_id_seq', 6, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.orders_order_id_seq', 1, false);


--
-- Name: authors pk_authors; Type: CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.authors
    ADD CONSTRAINT pk_authors PRIMARY KEY (author_id);


--
-- Name: books pk_books; Type: CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.books
    ADD CONSTRAINT pk_books PRIMARY KEY (book_id);


--
-- Name: categories pk_categories; Type: CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.categories
    ADD CONSTRAINT pk_categories PRIMARY KEY (category_id);


--
-- Name: languages pk_languages; Type: CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.languages
    ADD CONSTRAINT pk_languages PRIMARY KEY (language_id);


--
-- Name: publishers pk_publisher; Type: CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.publishers
    ADD CONSTRAINT pk_publisher PRIMARY KEY (publisher_id);


--
-- Name: books unq_isbn; Type: CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.books
    ADD CONSTRAINT unq_isbn UNIQUE (isbn);


--
-- Name: employees pk_employees; Type: CONSTRAINT; Schema: hr; Owner: postgres
--

ALTER TABLE ONLY hr.employees
    ADD CONSTRAINT pk_employees PRIMARY KEY (employee_id);


--
-- Name: positions pk_positions; Type: CONSTRAINT; Schema: hr; Owner: postgres
--

ALTER TABLE ONLY hr.positions
    ADD CONSTRAINT pk_positions PRIMARY KEY (position_id);


--
-- Name: employees unq_phone_number; Type: CONSTRAINT; Schema: hr; Owner: postgres
--

ALTER TABLE ONLY hr.employees
    ADD CONSTRAINT unq_phone_number UNIQUE (phone_number);


--
-- Name: addresses pk_addresses; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.addresses
    ADD CONSTRAINT pk_addresses PRIMARY KEY (address_id);


--
-- Name: countries pk_countries; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.countries
    ADD CONSTRAINT pk_countries PRIMARY KEY (country_code);


--
-- Name: customers pk_customers; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.customers
    ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);


--
-- Name: passwords pk_passwords; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.passwords
    ADD CONSTRAINT pk_passwords PRIMARY KEY (customer_id);


--
-- Name: regions pk_regions; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.regions
    ADD CONSTRAINT pk_regions PRIMARY KEY (region_id);


--
-- Name: customers unq_email_address; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.customers
    ADD CONSTRAINT unq_email_address UNIQUE (email_address);


--
-- Name: passwords unq_password; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.passwords
    ADD CONSTRAINT unq_password UNIQUE (password_hash);


--
-- Name: customers unq_phone_number; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.customers
    ADD CONSTRAINT unq_phone_number UNIQUE (phone_number);


--
-- Name: regions unq_region_code; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.regions
    ADD CONSTRAINT unq_region_code UNIQUE (region_code);


--
-- Name: products pk_products; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.products
    ADD CONSTRAINT pk_products PRIMARY KEY (product_id);


--
-- Name: credit_cards pk_credit_cards; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.credit_cards
    ADD CONSTRAINT pk_credit_cards PRIMARY KEY (card_id);


--
-- Name: customer_bonus_cards pk_customer_bonus_cards; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer_bonus_cards
    ADD CONSTRAINT pk_customer_bonus_cards PRIMARY KEY (customer_id);


--
-- Name: customer_personal_promocodes pk_customer_personal_promocodes; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer_personal_promocodes
    ADD CONSTRAINT pk_customer_personal_promocodes PRIMARY KEY (promocode_id);


--
-- Name: method_deliveries pk_method_deliveries; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.method_deliveries
    ADD CONSTRAINT pk_method_deliveries PRIMARY KEY (delivery_id);


--
-- Name: method_payments pk_method_payments; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.method_payments
    ADD CONSTRAINT pk_method_payments PRIMARY KEY (payment_id);


--
-- Name: order_lines pk_order_lines; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.order_lines
    ADD CONSTRAINT pk_order_lines PRIMARY KEY (line_id);


--
-- Name: order_statuses pk_order_statuses; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.order_statuses
    ADD CONSTRAINT pk_order_statuses PRIMARY KEY (status_id);


--
-- Name: orders pk_orders; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);


--
-- Name: customer_bonus_cards unq_barcode; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer_bonus_cards
    ADD CONSTRAINT unq_barcode UNIQUE (barcode);


--
-- Name: credit_cards unq_card_number; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.credit_cards
    ADD CONSTRAINT unq_card_number UNIQUE (card_number);


--
-- Name: customer_personal_promocodes unq_promocode; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer_personal_promocodes
    ADD CONSTRAINT unq_promocode UNIQUE (promocode);


--
-- Name: books tgr_update_modified_column; Type: TRIGGER; Schema: book; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON book.books FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: employees tgr_update_modified_column; Type: TRIGGER; Schema: hr; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON hr.employees FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: addresses tgr_update_modified_column; Type: TRIGGER; Schema: person; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON person.addresses FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: customers tgr_update_modified_column; Type: TRIGGER; Schema: person; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON person.customers FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: passwords tgr_update_modified_column; Type: TRIGGER; Schema: person; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON person.passwords FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: products tgr_update_modified_column; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON production.products FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: credit_cards tgr_update_modified_column; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON sales.credit_cards FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: customer_bonus_cards tgr_update_modified_column; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON sales.customer_bonus_cards FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: customer_personal_promocodes tgr_update_modified_column; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON sales.customer_personal_promocodes FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: orders tgr_update_modified_column; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER tgr_update_modified_column BEFORE UPDATE ON sales.orders FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: book_authors fk_book_authors_authors; Type: FK CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.book_authors
    ADD CONSTRAINT fk_book_authors_authors FOREIGN KEY (author_id) REFERENCES book.authors(author_id);


--
-- Name: book_authors fk_book_authors_books; Type: FK CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.book_authors
    ADD CONSTRAINT fk_book_authors_books FOREIGN KEY (book_id) REFERENCES book.books(book_id);


--
-- Name: book_categories fk_book_categories_books; Type: FK CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.book_categories
    ADD CONSTRAINT fk_book_categories_books FOREIGN KEY (book_id) REFERENCES book.books(book_id);


--
-- Name: book_categories fk_book_categories_categories; Type: FK CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.book_categories
    ADD CONSTRAINT fk_book_categories_categories FOREIGN KEY (category_id) REFERENCES book.categories(category_id);


--
-- Name: books fk_books_languages; Type: FK CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.books
    ADD CONSTRAINT fk_books_languages FOREIGN KEY (language_id) REFERENCES book.languages(language_id);


--
-- Name: books fk_books_publishers; Type: FK CONSTRAINT; Schema: book; Owner: postgres
--

ALTER TABLE ONLY book.books
    ADD CONSTRAINT fk_books_publishers FOREIGN KEY (publisher_id) REFERENCES book.publishers(publisher_id);


--
-- Name: employees fk_employees_positions; Type: FK CONSTRAINT; Schema: hr; Owner: postgres
--

ALTER TABLE ONLY hr.employees
    ADD CONSTRAINT fk_employees_positions FOREIGN KEY (position_id) REFERENCES hr.positions(position_id);


--
-- Name: addresses fk_addresses_regions; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.addresses
    ADD CONSTRAINT fk_addresses_regions FOREIGN KEY (region_id) REFERENCES person.regions(region_id);


--
-- Name: customer_addresses fk_customer_addresses_addresses; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.customer_addresses
    ADD CONSTRAINT fk_customer_addresses_addresses FOREIGN KEY (address_id) REFERENCES person.addresses(address_id);


--
-- Name: customer_addresses fk_customer_addresses_customers; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.customer_addresses
    ADD CONSTRAINT fk_customer_addresses_customers FOREIGN KEY (customer_id) REFERENCES person.customers(customer_id);


--
-- Name: passwords fk_passwords_customers; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.passwords
    ADD CONSTRAINT fk_passwords_customers FOREIGN KEY (customer_id) REFERENCES person.customers(customer_id);


--
-- Name: regions fk_regions_countries; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.regions
    ADD CONSTRAINT fk_regions_countries FOREIGN KEY (country_code) REFERENCES person.countries(country_code);


--
-- Name: products fk_products_books; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.products
    ADD CONSTRAINT fk_products_books FOREIGN KEY (product_id) REFERENCES book.books(book_id);


--
-- Name: customer_bonus_cards fk_customer_bonus_cards_customers; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer_bonus_cards
    ADD CONSTRAINT fk_customer_bonus_cards_customers FOREIGN KEY (customer_id) REFERENCES person.customers(customer_id);


--
-- Name: customer_credit_cards fk_customer_credit_cards_c; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer_credit_cards
    ADD CONSTRAINT fk_customer_credit_cards_c FOREIGN KEY (customer_id) REFERENCES person.customers(customer_id);


--
-- Name: customer_credit_cards fk_customer_credit_cards_cc; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer_credit_cards
    ADD CONSTRAINT fk_customer_credit_cards_cc FOREIGN KEY (card_id) REFERENCES sales.credit_cards(card_id);


--
-- Name: customer_personal_promocodes fk_customer_personal_promocodes_c; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer_personal_promocodes
    ADD CONSTRAINT fk_customer_personal_promocodes_c FOREIGN KEY (customer_id) REFERENCES person.customers(customer_id);


--
-- Name: order_lines fk_order_lines_orders; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.order_lines
    ADD CONSTRAINT fk_order_lines_orders FOREIGN KEY (order_id) REFERENCES sales.orders(order_id);


--
-- Name: order_lines fk_order_lines_products; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.order_lines
    ADD CONSTRAINT fk_order_lines_products FOREIGN KEY (product_id) REFERENCES production.products(product_id);


--
-- Name: orders fk_orders_addresses; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_addresses FOREIGN KEY (address_delivery_id) REFERENCES person.addresses(address_id);


--
-- Name: orders fk_orders_credit_cards; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_credit_cards FOREIGN KEY (credit_card_id) REFERENCES sales.credit_cards(card_id);


--
-- Name: orders fk_orders_customers_id; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_customers_id FOREIGN KEY (customer_id) REFERENCES person.customers(customer_id);


--
-- Name: orders fk_orders_employees_id; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_employees_id FOREIGN KEY (employee_id) REFERENCES hr.employees(employee_id);


--
-- Name: orders fk_orders_method_deliveries; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_method_deliveries FOREIGN KEY (method_delivery_id) REFERENCES sales.method_deliveries(delivery_id);


--
-- Name: orders fk_orders_method_payments; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_method_payments FOREIGN KEY (method_payment_id) REFERENCES sales.method_payments(payment_id);


--
-- Name: orders fk_orders_order_statuses; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_order_statuses FOREIGN KEY (status_id) REFERENCES sales.order_statuses(status_id);


--
-- PostgreSQL database dump complete
--

