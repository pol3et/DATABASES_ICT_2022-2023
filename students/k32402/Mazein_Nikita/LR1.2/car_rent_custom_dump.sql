PGDMP         7                {            postgres    15.2    15.2 A    q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            r           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            s           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            t           1262    5    postgres    DATABASE     �   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1251';
    DROP DATABASE postgres;
                postgres    false            u           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3444                        2615    24692    lab    SCHEMA        CREATE SCHEMA lab;
    DROP SCHEMA lab;
                postgres    false                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            v           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            {           1247    33205    non_neg_money    DOMAIN     u   CREATE DOMAIN public.non_neg_money AS real
	CONSTRAINT non_neg_money_check CHECK ((VALUE >= (0)::double precision));
 "   DROP DOMAIN public.non_neg_money;
       public          postgres    false            �           1247    33400    non_negative_bigint    DOMAIN     o   CREATE DOMAIN public.non_negative_bigint AS bigint
	CONSTRAINT non_negative_bigint_check CHECK ((VALUE >= 0));
 (   DROP DOMAIN public.non_negative_bigint;
       public          postgres    false            w           1247    33202    non_negative_integer    DOMAIN     r   CREATE DOMAIN public.non_negative_integer AS integer
	CONSTRAINT non_negative_integer_check CHECK ((VALUE >= 0));
 )   DROP DOMAIN public.non_negative_integer;
       public          postgres    false            �            1259    24693 	   Accidents    TABLE     
  CREATE TABLE lab."Accidents" (
    "Accident_DT" timestamp(2) without time zone NOT NULL,
    "Contr_Code" public.non_negative_integer NOT NULL,
    "Place" character varying(100),
    "Damage" character varying(300) NOT NULL,
    "Cl_Is_Guilty" boolean NOT NULL
);
    DROP TABLE lab."Accidents";
       lab         heap    postgres    false    887    7            �            1259    24696    Auto    TABLE     �  CREATE TABLE lab."Auto" (
    "Auto_Code" public.non_negative_integer NOT NULL,
    "Mod_Code" public.non_negative_integer NOT NULL,
    "Engine_Num" character varying(30) NOT NULL,
    "Date_Last_TS" timestamp(2) without time zone,
    "Mileage" public.non_negative_integer NOT NULL,
    "Body_Num" character varying(30) NOT NULL,
    "Release_Year" public.non_negative_integer NOT NULL,
    reg_plate character varying(9) NOT NULL,
    CONSTRAINT chk_rel_year CHECK ((("Release_Year")::integer > 1980))
);
    DROP TABLE lab."Auto";
       lab         heap    postgres    false    7    887    887    887    887            �            1259    24699 
   Bonus_Card    TABLE       CREATE TABLE lab."Bonus_Card" (
    "BC_Code" public.non_negative_bigint NOT NULL,
    "Cl_Code" public.non_negative_integer NOT NULL,
    "Bonus_Sum" public.non_negative_integer NOT NULL,
    CONSTRAINT chk_bonsum CHECK ((length((("Bonus_Sum")::character varying(7))::text) <= 6))
);
    DROP TABLE lab."Bonus_Card";
       lab         heap    postgres    false    898    7    887    887            �            1259    24702    Client    TABLE     �  CREATE TABLE lab."Client" (
    "Cl_Code" public.non_negative_integer NOT NULL,
    "Email" character varying(256),
    "Address" character varying(100) NOT NULL,
    "Full_Name" character varying(50) NOT NULL,
    "Passport_Data" public.non_negative_bigint NOT NULL,
    "Tel_Num" public.non_negative_bigint NOT NULL,
    CONSTRAINT chk_email CHECK ((("Email")::text ~~ '_%@_%._%'::text)),
    CONSTRAINT chk_passport CHECK (((("Passport_Data")::bigint > 1000000000) AND (("Passport_Data")::bigint <= '9999999999'::bigint))),
    CONSTRAINT chk_phone CHECK (((("Tel_Num")::bigint > '70000000000'::bigint) AND (("Tel_Num")::bigint <= '79999999999'::bigint)))
);
    DROP TABLE lab."Client";
       lab         heap    postgres    false    898    7    898    887            �            1259    24705    Contract    TABLE     �  CREATE TABLE lab."Contract" (
    "Contr_Code" public.non_negative_integer NOT NULL,
    "Act_Transf_Client" public.non_negative_integer,
    "Act_Transf_Company" public.non_negative_integer,
    "Rent_Price" public.non_neg_money NOT NULL,
    "DT_Contract" timestamp(2) without time zone NOT NULL,
    "DT_Car_Transf_To_Cl" timestamp(2) without time zone,
    "Factual_DT_Ret" timestamp(2) without time zone,
    "Late_Fee" public.non_neg_money,
    "Ret_Mark" boolean NOT NULL,
    "Cl_Code" public.non_negative_integer NOT NULL,
    "Stf_Code" public.non_negative_integer NOT NULL,
    "Auto_Code" public.non_negative_integer NOT NULL,
    rent_time public.non_negative_integer NOT NULL
);
    DROP TABLE lab."Contract";
       lab         heap    postgres    false    887    7    891    891    887    887    887    887    887    887            �            1259    24708 	   Extension    TABLE     #  CREATE TABLE lab."Extension" (
    "Extension_Id" public.non_negative_integer NOT NULL,
    "Contr_Code" integer NOT NULL,
    "New_DT_Ret" timestamp without time zone NOT NULL,
    "Ext_Hours" public.non_negative_integer NOT NULL,
    "Sequence_Num" public.non_negative_integer NOT NULL
);
    DROP TABLE lab."Extension";
       lab         heap    postgres    false    887    887    7    887            �            1259    24711    Model    TABLE     M  CREATE TABLE lab."Model" (
    "Mod_Code" public.non_negative_integer NOT NULL,
    "Name" character varying(40) NOT NULL,
    "Characteristics" character varying(300) NOT NULL,
    "Description" character varying(1500) NOT NULL,
    "Market_Price" public.non_negative_integer,
    "Bail_Sum" public.non_negative_integer NOT NULL
);
    DROP TABLE lab."Model";
       lab         heap    postgres    false    887    887    7    887            �            1259    24716 	   Penalties    TABLE     �  CREATE TABLE lab."Penalties" (
    "Penalty_Code" public.non_negative_integer NOT NULL,
    "Accident_DT" timestamp(2) without time zone NOT NULL,
    "Who_Pays" character varying(2) NOT NULL,
    "Payment_Status" boolean NOT NULL,
    "Penalty_Sum" public.non_neg_money NOT NULL,
    CONSTRAINT check_who_pays CHECK ((("Who_Pays")::text = ANY ((ARRAY['Cl'::character varying, 'Co'::character varying, 'Ot'::character varying])::text[])))
);
    DROP TABLE lab."Penalties";
       lab         heap    postgres    false    891    887    7            �            1259    24719    Price    TABLE     [  CREATE TABLE lab."Price" (
    "Mod_Code" integer NOT NULL,
    "DT_Inter_Start" timestamp(2) without time zone NOT NULL,
    "DT_Inter_End" timestamp(2) without time zone,
    "Price_One_H" public.non_negative_integer NOT NULL,
    "Price_Long_Inter" public.non_negative_integer NOT NULL,
    "Price_Code" public.non_negative_integer NOT NULL
);
    DROP TABLE lab."Price";
       lab         heap    postgres    false    887    887    7    887            �            1259    24722    Staff    TABLE       CREATE TABLE lab."Staff" (
    "Stf_Code" public.non_negative_integer NOT NULL,
    "Position" character varying(30) NOT NULL,
    "Resps" character varying(200) NOT NULL,
    "Salary" public.non_negative_integer,
    stf_name character varying NOT NULL
);
    DROP TABLE lab."Staff";
       lab         heap    postgres    false    887    887    7            �            1259    24725 	   Violation    TABLE     �   CREATE TABLE lab."Violation" (
    "Violation_Code" public.non_negative_integer NOT NULL,
    "Penalty_Code" integer,
    rtr_viol_code integer NOT NULL
);
    DROP TABLE lab."Violation";
       lab         heap    postgres    false    887    7            �            1259    33369    insurance_dict    TABLE       CREATE TABLE lab.insurance_dict (
    insur_code public.non_negative_integer NOT NULL,
    insur_price public.non_negative_integer NOT NULL,
    insure_name character varying(40) NOT NULL,
    insure_desc character varying(200) NOT NULL,
    "Mod_Code" integer NOT NULL
);
    DROP TABLE lab.insurance_dict;
       lab         heap    postgres    false    7    887    887            �            1259    24812    rtr_dict    TABLE     �   CREATE TABLE lab.rtr_dict (
    rtr_viol_code public.non_negative_integer NOT NULL,
    viol_fee public.non_neg_money NOT NULL,
    viol_type character varying(100) NOT NULL,
    viol_descript character varying(200) NOT NULL
);
    DROP TABLE lab.rtr_dict;
       lab         heap    postgres    false    887    7    891            b          0    24693 	   Accidents 
   TABLE DATA                 lab          postgres    false    216   7Q       c          0    24696    Auto 
   TABLE DATA                 lab          postgres    false    217   �a       d          0    24699 
   Bonus_Card 
   TABLE DATA                 lab          postgres    false    218   �g       e          0    24702    Client 
   TABLE DATA                 lab          postgres    false    219   �h       f          0    24705    Contract 
   TABLE DATA                 lab          postgres    false    220   �l       g          0    24708 	   Extension 
   TABLE DATA                 lab          postgres    false    221   �p       h          0    24711    Model 
   TABLE DATA                 lab          postgres    false    222   �w       i          0    24716 	   Penalties 
   TABLE DATA                 lab          postgres    false    223   0|       j          0    24719    Price 
   TABLE DATA                 lab          postgres    false    224   l�       k          0    24722    Staff 
   TABLE DATA                 lab          postgres    false    225   ��       l          0    24725 	   Violation 
   TABLE DATA                 lab          postgres    false    226   ��       n          0    33369    insurance_dict 
   TABLE DATA                 lab          postgres    false    228   ��       m          0    24812    rtr_dict 
   TABLE DATA                 lab          postgres    false    227   ��       �           2606    24729    Accidents Accidents_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY lab."Accidents"
    ADD CONSTRAINT "Accidents_pkey" PRIMARY KEY ("Accident_DT");
 C   ALTER TABLE ONLY lab."Accidents" DROP CONSTRAINT "Accidents_pkey";
       lab            postgres    false    216            �           2606    33247    Auto Auto_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY lab."Auto"
    ADD CONSTRAINT "Auto_pkey" PRIMARY KEY ("Auto_Code");
 9   ALTER TABLE ONLY lab."Auto" DROP CONSTRAINT "Auto_pkey";
       lab            postgres    false    217            �           2606    33415    Bonus_Card Bonus_Card_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY lab."Bonus_Card"
    ADD CONSTRAINT "Bonus_Card_pkey" PRIMARY KEY ("BC_Code");
 E   ALTER TABLE ONLY lab."Bonus_Card" DROP CONSTRAINT "Bonus_Card_pkey";
       lab            postgres    false    218            �           2606    33208    Client Client_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY lab."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY ("Cl_Code");
 =   ALTER TABLE ONLY lab."Client" DROP CONSTRAINT "Client_pkey";
       lab            postgres    false    219            �           2606    33264    Contract Contract_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY lab."Contract"
    ADD CONSTRAINT "Contract_pkey" PRIMARY KEY ("Contr_Code");
 A   ALTER TABLE ONLY lab."Contract" DROP CONSTRAINT "Contract_pkey";
       lab            postgres    false    220            �           2606    33300    Extension Extension_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY lab."Extension"
    ADD CONSTRAINT "Extension_pkey" PRIMARY KEY ("Extension_Id");
 C   ALTER TABLE ONLY lab."Extension" DROP CONSTRAINT "Extension_pkey";
       lab            postgres    false    221            �           2606    33306    Model Model_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY lab."Model"
    ADD CONSTRAINT "Model_pkey" PRIMARY KEY ("Mod_Code");
 ;   ALTER TABLE ONLY lab."Model" DROP CONSTRAINT "Model_pkey";
       lab            postgres    false    222            �           2606    33324    Penalties Penalties_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY lab."Penalties"
    ADD CONSTRAINT "Penalties_pkey" PRIMARY KEY ("Penalty_Code");
 C   ALTER TABLE ONLY lab."Penalties" DROP CONSTRAINT "Penalties_pkey";
       lab            postgres    false    223            �           2606    33335    Price Price_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY lab."Price"
    ADD CONSTRAINT "Price_pkey" PRIMARY KEY ("Price_Code");
 ;   ALTER TABLE ONLY lab."Price" DROP CONSTRAINT "Price_pkey";
       lab            postgres    false    224            �           2606    33341    Staff Staff_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY lab."Staff"
    ADD CONSTRAINT "Staff_pkey" PRIMARY KEY ("Stf_Code");
 ;   ALTER TABLE ONLY lab."Staff" DROP CONSTRAINT "Staff_pkey";
       lab            postgres    false    225            �           2606    33352    Violation Violation_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY lab."Violation"
    ADD CONSTRAINT "Violation_pkey" PRIMARY KEY ("Violation_Code");
 C   ALTER TABLE ONLY lab."Violation" DROP CONSTRAINT "Violation_pkey";
       lab            postgres    false    226            �           2606    33390 "   insurance_dict insurance_dict_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY lab.insurance_dict
    ADD CONSTRAINT insurance_dict_pkey PRIMARY KEY (insur_code);
 I   ALTER TABLE ONLY lab.insurance_dict DROP CONSTRAINT insurance_dict_pkey;
       lab            postgres    false    228            �           2606    33358    rtr_dict rtr_dict_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY lab.rtr_dict
    ADD CONSTRAINT rtr_dict_pkey PRIMARY KEY (rtr_viol_code);
 =   ALTER TABLE ONLY lab.rtr_dict DROP CONSTRAINT rtr_dict_pkey;
       lab            postgres    false    227            �           2606    33407    Client unq_email 
   CONSTRAINT     M   ALTER TABLE ONLY lab."Client"
    ADD CONSTRAINT unq_email UNIQUE ("Email");
 9   ALTER TABLE ONLY lab."Client" DROP CONSTRAINT unq_email;
       lab            postgres    false    219            �           2606    33409    Client unq_psprt 
   CONSTRAINT     U   ALTER TABLE ONLY lab."Client"
    ADD CONSTRAINT unq_psprt UNIQUE ("Passport_Data");
 9   ALTER TABLE ONLY lab."Client" DROP CONSTRAINT unq_psprt;
       lab            postgres    false    219            �           2606    33411    Client unq_telnum 
   CONSTRAINT     P   ALTER TABLE ONLY lab."Client"
    ADD CONSTRAINT unq_telnum UNIQUE ("Tel_Num");
 :   ALTER TABLE ONLY lab."Client" DROP CONSTRAINT unq_telnum;
       lab            postgres    false    219            �           2606    24750    Penalties Accident_DT    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Penalties"
    ADD CONSTRAINT "Accident_DT" FOREIGN KEY ("Accident_DT") REFERENCES lab."Accidents"("Accident_DT") NOT VALID;
 @   ALTER TABLE ONLY lab."Penalties" DROP CONSTRAINT "Accident_DT";
       lab          postgres    false    3241    223    216            �           2606    33275    Contract Auto_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Contract"
    ADD CONSTRAINT "Auto_Code" FOREIGN KEY ("Auto_Code") REFERENCES lab."Auto"("Auto_Code") NOT VALID;
 =   ALTER TABLE ONLY lab."Contract" DROP CONSTRAINT "Auto_Code";
       lab          postgres    false    220    3243    217            �           2606    33228    Bonus_Card Cl_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Bonus_Card"
    ADD CONSTRAINT "Cl_Code" FOREIGN KEY ("Cl_Code") REFERENCES lab."Client"("Cl_Code") NOT VALID;
 =   ALTER TABLE ONLY lab."Bonus_Card" DROP CONSTRAINT "Cl_Code";
       lab          postgres    false    3247    219    218            �           2606    33270    Contract Cl_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Contract"
    ADD CONSTRAINT "Cl_Code" FOREIGN KEY ("Cl_Code") REFERENCES lab."Client"("Cl_Code") NOT VALID;
 ;   ALTER TABLE ONLY lab."Contract" DROP CONSTRAINT "Cl_Code";
       lab          postgres    false    3247    220    219            �           2606    33280    Extension Contr_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Extension"
    ADD CONSTRAINT "Contr_Code" FOREIGN KEY ("Contr_Code") REFERENCES lab."Contract"("Contr_Code") NOT VALID;
 ?   ALTER TABLE ONLY lab."Extension" DROP CONSTRAINT "Contr_Code";
       lab          postgres    false    220    3255    221            �           2606    33290    Accidents Contr_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Accidents"
    ADD CONSTRAINT "Contr_Code" FOREIGN KEY ("Contr_Code") REFERENCES lab."Contract"("Contr_Code") NOT VALID;
 ?   ALTER TABLE ONLY lab."Accidents" DROP CONSTRAINT "Contr_Code";
       lab          postgres    false    220    3255    216            �           2606    33307    Price Mod_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Price"
    ADD CONSTRAINT "Mod_Code" FOREIGN KEY ("Mod_Code") REFERENCES lab."Model"("Mod_Code") NOT VALID;
 9   ALTER TABLE ONLY lab."Price" DROP CONSTRAINT "Mod_Code";
       lab          postgres    false    224    222    3259            �           2606    33312    Auto Mod_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Auto"
    ADD CONSTRAINT "Mod_Code" FOREIGN KEY ("Mod_Code") REFERENCES lab."Model"("Mod_Code") NOT VALID;
 8   ALTER TABLE ONLY lab."Auto" DROP CONSTRAINT "Mod_Code";
       lab          postgres    false    222    217    3259            �           2606    33384    insurance_dict Mod_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab.insurance_dict
    ADD CONSTRAINT "Mod_Code" FOREIGN KEY ("Mod_Code") REFERENCES lab."Model"("Mod_Code") NOT VALID;
 @   ALTER TABLE ONLY lab.insurance_dict DROP CONSTRAINT "Mod_Code";
       lab          postgres    false    3259    228    222            �           2606    33325    Violation Penalty_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Violation"
    ADD CONSTRAINT "Penalty_Code" FOREIGN KEY ("Penalty_Code") REFERENCES lab."Penalties"("Penalty_Code") NOT VALID;
 A   ALTER TABLE ONLY lab."Violation" DROP CONSTRAINT "Penalty_Code";
       lab          postgres    false    223    3261    226            �           2606    33342    Contract Stf_Code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Contract"
    ADD CONSTRAINT "Stf_Code" FOREIGN KEY ("Stf_Code") REFERENCES lab."Staff"("Stf_Code") NOT VALID;
 <   ALTER TABLE ONLY lab."Contract" DROP CONSTRAINT "Stf_Code";
       lab          postgres    false    225    220    3265            �           2606    33359    Violation rtr_viol_code    FK CONSTRAINT     �   ALTER TABLE ONLY lab."Violation"
    ADD CONSTRAINT rtr_viol_code FOREIGN KEY (rtr_viol_code) REFERENCES lab.rtr_dict(rtr_viol_code) NOT VALID;
 @   ALTER TABLE ONLY lab."Violation" DROP CONSTRAINT rtr_viol_code;
       lab          postgres    false    226    3269    227            b      x��]M��6��W�8<~KԞ�Y�f�ػW���^�z>����ߧ�HI�ZlI3�!;���ad
��^������o�P����?��ͧ��x���/w7�w/���?|��ËWՋ7�7���on/w��_�6[�͏��Ϳ�wo�>���������/~������}_}�R0!.X}!Yś��V���*���U�R�����/��o���]���f��uu���=T��?�>n��M�������oo�����l�����������ϛ������3����t%D�d��� u�fw�9PD����nw���}�v�@��?<<s\p`�W̶Ҷچf8���}w`��n.]\�ۻ���~;wf��k�����/[1�r�2g��7�PATכ��5��>|��>�.�g>(�.��o�i��"�YAH�e}z���������@�2��>"��'���~��G�?��!e���ͻ`�b5~S��|
в���� ?��~C\�s�A���E�r	���'$Awl+��vsȑ�L��9�uъ��~�ڤ�ߢ��������AX6�]Dx�l=�|�Dq�=l�_v�Q=�7%��JL芷RD�LX,/�p�_]1LLu�Ǹ�T�ZV���`Zg|H���*��[fL�&$_�I�w(�3,�I���f��0$u�Mg�O7���J������.�?�B�TSB�����I�����k2��y�\ꃞJ`�mY��4�&�E�o>2���-A@誚0W��~����n��ߖ\h]Q�b����*,FE8�JE� - (hA�\u��xZ'R�p`%"&�	���^@2�E���������`-��ä=�۫�4<y�27 ��ϊ#���X��H�0�Q̈́���Yl���P�n�vJ��������wU8u��p��K� �ۓ�עꕫ��Ñ�Э�Q;�-�t�r.	��� g�� �ځ�%*�4�+8��J�'Uq����0�[y��*\p�7+f ���N��A��+w���d���P��萑�&Et��9�b��X@=�/����"J;��&N�D�A��c��[-B�Q���&r{�7����ѝ�K�H�2"�PG$n��$���!�[�[�9x���F�R���v!E�M�{ȋEY��×������n�$:��g�����>(D�����ɺ����T���P�[�Ô(LM��J�Q|l*���D���"N��Xm� ��ɐ]�g�e�	h���4��0A��NY��+�jJf�"z��ᐂ����Z�\�DP+��_�E:�Y���#C�WF7p�2,�Z�Z8 )�HJ�0e(�T�*Q\�\�m0j�tW���Q2�Q���y� EI�*~[fL،��eta>&��Zr�u�hLh���t�����I���@���<,X8AX@���rjfJ��T��:.ݴB�a)s��5���">xj���ٵe�)W�j0e�ݿ��;(]��uI0+G�B�@�FF$ԫ4f�o��X#���-C����c7F���$�$�_M��I1h�y=P�)м�P�R,��R�>�3�\	�8�$�9�e�1*M=�Df���'��d�O��T����^R9�1!���XRx�(/i�h��}V	��p�u�  ��%du��L������H��5r0���	Y��*U�1�nI�G<��<=StL$=
���6(P4ߣ���?&L�n�"5��H�Y/d���	��xC%*�~!A<e�"#6��=:�����ʻ��*A��B#|v���1�ibhe�Q��R�K�*�9x2�"#�
a��H%�G	�?-瀄vj��hZN�,�N*�t#uL�ɝjQ�O���a��OS�p����9����Q*c��!5$2^�G�vD���h�
����SXr�p!�y�2�<�h�����Q�M@�#6#H��v����^�������;a�]A	�k8,�ɍI���Y#[/qI��|��ݱ�]����p<���>"�d��4�8S_��@�B� ">Kl��-^��p���&��A-����|aY¤�4[亂�Zc��Ns��,�Pa|#���!i�z���56�Î��SM�+܂��7&Mc�8sфY�(kL;W����v��|�������D���CP��!'����f�E�Br3	Mnp1�U����N�q�D`T��EDҨ&��d��˪�	K��Ai��	��;[�CЮH�G�>͉��E|''(r�B�a��<�'�O�2����LF:9M9��[��Cg�(p���fIG8�Hp�Z�L�]`B�]u��}V�>��rJ��}X�)+�
L��{�8u�K�D@Sk/>���g`��H'	�̜Mڤa�n6���7�d	I�=�T��ZrrK�G��Z�*��S"G��	�	F�ǡ`�'�c�H��r햒��k9^�S��U�SJ~t�ɉ[B��01x����7@�Q;��u �P�1��x�q����
�%�	��������3�wE'��~ў<X�0�O7
Ҳpg�0�\�9{S�՘u��}�Hgd��.y�%��%�b@�}C�T�y�L��w�����&��@3sXeڋ��-��@�I4 c��"��Xn�S����@P�]�D����$�����;KԱ�sV\FO;a*�ô-�e!gL\E�0<=S#���yz����#�
L�fWX�xO�0W�f�T�Da/i!?��LO�$��dL�BA�4#"�Vq�+�~���ײ4(�pN��K�4y^��~Y�bF��*t�*�7pM�(���^���s�}��$a��O�5&�2q�Ǿ���y�9���+�[8v���{�$M,��3��&��Gcl�+j�ޏ�����;u�������Gm,��}Y�B�ȥ�0�z��ZR�rP��6��.�`X�>ҹ֯S�9&��@,��q�}�H]��Ւe�d6l�q�ʹkaa�ʕ'���ca��H�!�ɾ�<֠�u9D>�����vX9G�\W\�b�ۨ	05�֨Lw#�ĒgK64'B֩F���<.~F�0�
y��R��Twi��m�U<p��#q�x�j�����ȈAZ�/J��%|�f\��7_��if��9��-T�g�
��	�%X��]�?�Ԅ��A�W/�f�EL��+W��yg��(	����N&�1��a!�s$��'�
����Z��!�w�"�����j1-$8ߩ:�7��-=�|�(�~�G����3�r�T;U/1g��w��m�6񓖠����u�v� �`�4B�0��`Ax�∓�r�rx��31��c���M���h?��}Sr��ݐ��_0C�ۑD�u��5[h|�a��%��#ߖ(R���݃LzF�)��r�wK���a�}�(S>�حX���r<,=ֈ׍�l�����G���F�LF8Y�����nd���N�D�y�z3?�cH����"��^��4S�k13�T8��O���ާ�ޕV��b�W.�y|
W������s�{��[�_�i����-������"w�q��a�p�I�X��|lSMMם������v0ۃي�|Z�+����$,P��n�S?�H	w��\�!�5(�HL�҆���$�	�p�}	��|��m��z�Vt쭊��J���\�����!R��Μ�����Do��J�h��Ѧ�sZ}�ʦ���ўA#^����M]d�<%=�����1���FP�zA����:X�i���l�-���|\�4�r�7O~���9�ݗ���U����ﶠLi�Z4�T�"e8�!�aBSh]pĤ5�s+��v����K����1{q6��8�Hf-�0}ZR/�)���}A;e�}�+��?����j%-CG$^\�:<z�~5�̈́��d!i��aGD磖�3�b�2���y��7�㵿�D�ĺ%�5펈6|�~�����g���W,�y�O��ښ
�t{�g|�~�󘙖�5��SG��N�2-�.�NE��L�p#޽�G��9�8巿ѫ߀v�י��o����l��kʊ�L��F�F%�*�U�IH�A˻m��"׳��))�iM����h���ţ.a���'Q-k�I::/����݉��=*իwd4���'���U�d��p=����� w   �T�{�n�b�pY���|�k@��9��6l�A�wn	p��U�-�T�EUk���Z�,��H�4�Do$�4R���aW3�3��z2:���p�C��[%�ӄT3Z�#�Z�}�'獵      c   �  x��Y�n�V��+o� Vqg��}��KR���a��E� @�y,�A�n���I��x�:{lђ��3�1�/���z�b�����������������m�������l�����ѻ�o���.>�Q=��>����>~�]��g�y{��~b���_��]�������w���׷���>l�l3Z�yr��|@��u烧���H#<�)���!�@�_�o���WO�JB��/������Bk�*���oO^�&;t�5J/w��8϶�60��"�0�2���e{���0��:�m��^�gX��^+2�����מM*!�æ����'���z�J����p�3�d�h��)T��"Ϧ֣�CUCe��:��叫0�T����k�.Ep�&�z��ɽUS[CE�K�y6�-���m�����R�����(���&� �#�z�j�T��q���z[?�!B�W�
_OVF E��@���#��]��V˞����j�K�6�9ޛ��K��J�Wf!��N2��V�`u�3��D�^a%�ܣ׎*�Ǖ\	"^�]G��q�usss�e���d���</��S��j�b���B��X�wa�U�(��:��d*e�2����S�U�Xi�WX�"t:
V��b2�Z�0A�X���U+��)Ք��2�/62�.NW��,m�mm�N"�kⵘf�e�bL$�l#��zt�f؉R}ī�r�z	Pj�
'>��ko�
Smm�'�{,��V�آ���>M���ΰXq�:V��k����~a@O��ڄ��e �����w���Imz���[��~aeK�Qī�e����o����u v��fx.�V�~�0�G�
R%�Vw�nE6�1�r[�D�yD�*NH�:}X���%��1��9V)������x�����>a�-�H�̳��)>1�����G�Z��y�BG�"�]_q5�B�"Ԛ�bpV5��9!�F,���~�	k��?��r���`e��E����$u������Ď���ȉ�[�-k�j�X��:����ԩ�x.���~1Z#�W����UNX�g0݄}+����T��W�j{�f��J{Ī�6�f;�������%N \��m���js=�LxL�A�]��d�1M���6�dn�=X-mNs����v2#G���6��`�s����m�i����wߡ_�u��(wx=.KԄ{qwa��4�ŵ�Nd�����o2~�e�MT�+�F&Y�h��f������8�ӌ�~��Oٲ�K�eMp��z��?�Mv�г�I�8>h�����:��Z��B��t�%��dw0{��'�~(ew?v�/������l�����c�~�N��f�ݔ��l
����F}��3����~��E��6>�L�k��t��Aj��Z��>���d�UC�7��ĳ�U�Ox���f���ۜ�H����س��M�N�<�9�c��*v_,X���دq&"1J#ƫm
���-�+_ ���4�p�A//��|�ɓ� ��y      d   �   x��ӱ
�0�ݧ82)�b5J��b��]�b7[���oBB��/˟!��ߑ~��u�~/�Ώk������Y��5�ٖ'������7v��󭳐
����u���"w';&=�� �!FI!��C��rW%����r1��$��B(�N��SS�N�kB�r��B��Ib	A�#�� ��Я����b�$����      e   K  x��X]o�:}ﯰxaWB�Nt_J)�n��V���}���ŉQ���w�	�I���GjH��̜9���t�8#7��=t�t�����Op�4�K���(�\��`�,XY���/B<Mh�^x�e��E�tM+�_�<|�:�����o�)��z~�H��\��R������Y���dLyN�U��}%wy�|���-@ȵdp�~%����#�ۇ��\�Xc�VE&4gN��j}��k)\�)��4��)b��޾k�q��Q����r���9+/ײ2#;��l#�W��Е��[��M�3�xV��5a_�C~9�l��/��||�%�t��s���j6w�"�5
�Є|��o��ZӍgM�Ufې-iq:>�<����&��*��v�%-������d;��d
�F4��$Z%��m7�v�rP����P�n4�ȤY�Ӕm-j�V�| J���h"��$��ai�2lIs΄��bÊ�	��l�]+��`(~�iE�������ݎ�>R�d�q欹x��:.�8>�o3@�ɗ� N<?Ca	��N�*kw^�,Dj��vA�f��՚fdȫ��=�H����!
i߲5����g��u�iwИU��J�Q �C|�|���44��$b���� �/���s޴�H�����Ժw��8��#؉�s���B��Z�/3DvEE�C��3/`�����l@��U_׮n�5UC]�)7��W�u��3��d�H��2Xyv��JdE�����G�gm�}d|��GO���x���U�Y���'՗�*�kI�~y��P�?�>w 1N��n��4�{T@���tǅ�4�c��ƽ�e�[��4�{�CK�=�ep���3ܱ�K�!����!�>�u��b�����>�>�#?$����y@$yP�&R���خi�O%sк
�v��P��/�1�A��ݦ����[b����t���s���
��DD��+TC�oyRˮ'h�<e�^�SH���P�� �@n�>W�nD�G��'< pG��߷�Q�	Oo�k
t2����S��0cY.�Lj ����9��s���Zn�͜�Z�K��o��\�b�� 來�9O��<I�æzq�Y�L_      f   �  x��QO�0���/��|g��dO�����e�UƊ�V�T�þ��'�ӎ/��?nZ���w�����]W7�oŦ����|����8��η�������]-w�����|�~i����O��W�[����{z�/��\wO�]����&�%_~k6+�|����v��\��;�����<>���}�����Ov�ڧ��i������8�?0/ h��H�b�
��� 뵆�p6�5k5�Lֲ[������y�����-�����y�I���磫i!OP��05@��BU�!�>�e��F�d�ݤj�#�z _͋J;Ē���!�QSX��.�T�[C��e����D��l~SCYͺ���f����x�%��K�pA�U|��RlY�Y1� �S��l�ǩ�} Vz�뒬qӌ����(�
-��ku����D�Hv�nP=� 8����J���f��ޮ��0#�����vD����}�/�{�*�N���W0E�o�е̺���H��ds@�t��b����(o8��i8�M��[�;�\����*ݝZ\�c�q�D;�Tա�PA�R�B0s�LJd�I�Jeil�/�c��C�WJ�3�D�_mڐ��f��d��s��0���)r �}a�����I����_�4��^��dv>�(�}�C�M�����a`�Y:���f T2�k��c�D�'�VQF�"���,�����q��MD��j�r��9�� �sM&;?�S&��F��L���[|�A܆jar!h|��9�mB�s�?�A����T�OV�hqQ��T!i@$�s�^f���d�Y{��s�2E�� �!Эj�@��Hf�~�}���V��|�����Ew�� ��c䝌���Ių�p`�qF�m]��_)�+�N��+���Bn���f���+	s�f���V(�!WF�;���/}���=�{�rt�[�~�      g   �  x���M�U��}>E3�$`�=羏+�$B�jf!����Vu�yn�o�m?"Ȑ���t�Swo޽~�~w���ϻ�~��ۛ��}~x��������������7��WO��?޿z���������߿}�������ǧ/?�?�{������o��}�r���?�����|���������� {�;I�Yo�<_�x���w���R���Z^�WgE�U�Z^��J����"]��VkyE�:�8���ruV�fi kyE�:�9,kyE�:�;,kyE�:K�㊣���\_f�W�t/e'+ߪ�J/�"\��Kt\	.J�%9�%�j�+��Z�7��oc�]I��jpQΗF��ᢜ/Mۮ�}�\����E����.��V��\Oh�r�]�rA��q��E����q��E���V�Y:� �]QDu\.�/��q%�(ŏ�qe�(ŏ�q�(ŏ�qU�(ŏ�q5�(ŏ�qu�(ŏ}�u��9�(�O�q��*��Ɋ�!�{i��_޾C`?��jpQ�����pq>/L�.pQ�����(�O�q)\���"\�⧶��0����;�q�(���q��E*~����^�z�O-~V�����q%n�sr\�[��W�?�U����q5n�ss\�[�ܷ]gW:��ค]�bů�ս��RP�_�qn�Kt\�[��W��d�չ�/e�uV
J�Ku\�-~i�K��/�qEn�k�r��߉HůV�Y�ǰ�"2�_�qu�(ůq۵�"2�_���(ů�q)\����"\�/��-������������v�5���-8�q�H�o�����L�^�z-כ��7u\.J�[t\.J�[r\.J�[�v�!.J�[q\���:.������"\�ⷾ�wȃ�R��8_��w+>��,�׼~^�íҮ�:���=:���=9���=;�
���8����:����m����ř{t�%p�����+i���X
��wux7�U�u`
g����q6!9�%��ˀQ�/�8�%����Q�/�9�%���q�oc�K���\!^��а�Ă���i��bs�	V ���~��i��&X��~���i��m�i�F���L �_�S�8���"`��k؂��ؘ���ĕZ\ޙֿ��B�w�oS�K��8��-��8��1�S�8��5���q�osܯaq�{i0N�m�;�����l�1N�m�;����&�,����o�\ɠ���4�wv�F�,qo튭r'X�����N�½�+�˝`�{wWl�;�����2w�u��]�i�%��F=���͝`½�+6Ν`ʾ�+�ΕZޫ���'�=^�y�S�8��}������X��~[�N���6ѝ`0N�m�;�*`���Hw�5�8�����q�o3�K���"�^��t��VNw��^�u'X��~[�N���6ս��H�{��՝`��6֝`
���֝`0N�m��5���H�{��ם`�q�o��	6����ؕv��$����[b��	� ��6�,�i��v'X��~[�N�
��6۝`0N�m�;�:`���p�v�;Λq�-w'� �i�Mw'�����o���>�x[
�g>Bm��w'��i��w'X��~��N����ߝ`0N�m�;�
`��ۂw�U�8��	�k�q�o�	���F����wV��������3��6�`�����O��߆�l<��~[�^�Ξu�i�My'�x����`�i��ۘw���p�okޯa��y��ۜw��3��?{�?�rex      h   u  x�ŗ_S�8���;���$&�c'枀ҹ� �
��{mk*[>I&���VrB�3����-9+������rvv}_.o������؇�����ؿd�{��L�Ԡ���T۩O�S��em�L}Cs�x�$N��������_�f�!H��0��q�q8����.x�Gz�s��p�X�+�5�{ӡn3`�����T9GERaDR���%���07�ܢ��TֲZA@��r��C7*�|R��fѐ��pW"	�Y��M����φ�G�S��1c5��ȑ�V���5�����`Z�R�b��@�o���E��7%p���&o��� t%%}S<��lX�e����T'hH��D15�2�T4'5¼�0g�!��`u� sHeE?1nI+'Ue?ytX��=�����������x2%��\���іw��t!x�!>��l�����X�x��pfg��M��MF�����3�I� ����B£mE�L/$�<%�h���t:w^�tr�+������<Ge���yD��YE�Y�hG�'���QX�Zcn%X�h�e뾵r>�N%�c�����Y.P����'X���`Z�S,��� �z�&�S�F�^����������a�=C/e~�����:p%/ʡ��TaN���"���ށ,P���RH��&�F8����K
��e���f�F]�qK�k0��=0c/��h�� (H��sʵT�H�#U,7��|���"T��ftN�,;�U�u�|���h�̟�����I�7r�Qn��@��q��7`�̪�h���J)>-�%x �T]&f'�%����U0>������1��n�:������(%�\1**��&֤�0�K�����r�v��pN���K����T\XRA!~4諣F6�Z���k�xE����[�P���1uHCk Ԃ��\���FR�{&��S�!�'}�Ќ� pI5�ʶ�Kt��D���	�OM3�~-�������Ѭ��F�Թ�}~暷�+����׼b�&��	����Mv��KSZY1kގ��z��>�]�<^݆���ކ������0_���%�8�>�Ke�����G���(�� ���8f�j���=�ߗ5�~�	�h��F����/2���      i   ,  x��\ˊ\G��+
ml�*�g>��`��<^����dF���~"���f�m�^M@#�[4�'�9Y��{��?ߞ^������������{����Ǘ�/������޿|uz��/��������ֿ��?��p��G������ϛ���O��\�ͧ�_~u�������7�/����3����n�_؏�yo>�����S)�~�����R����	xc٨,�P�!�9�'�i�K���E(��x�|²)m����)ג(&@�r� �7�`	P!���q��t�"�H�3&��kL��r��uBp"�"ٰ-)���t��!�!�ɊD�V'ր�*1��)#����m耸D�JM%��=������!�D8:
�W
�V�+6�T�rH�5���kɡ����Dȣ��L�QpS�y�D����2�T� �6��Z�І����!�8��{����y��R	:�<��h��=�C�H*1��{O���2uX�c��k�*������[�K��:�t�^'�{�qüf�r*1uBp��ޕ�Ghi��
q�1܋�V�!5��v�K�K��]�dGCg�֕�Jn�*��D��ѱ������Z5QPep/k*�% �5�S�d@bІt�<�]6�#�)9a�P������F���%@AI6��0H�R���u��#^� �%��P��+_d^;�(%I5jr7lr'�Dɍ�$
�����q���-����iP�K��b�j�E5e�z��g}ym�b-�c��e�a���J=bMm�4�RFC9Z6SU-B��0Ov���U���N��:
�%{��)-�Ba�!������n.�� �A�҆cc�����x���RR�i�74�lj�h��W��Pp 6��ky�k1�J���X%��!>aشf����-D'��-�6�0$����ڦk
���b�Pt��b}٩���g0l5j%��x%���7]+�n���k
����{�)�-4�1������+9��uz��Pv�V�5iL)+����oe:e֔cNY�Y#�"5qL)�gL�G֦�Ӕu7�s��u0W
'��[�mB�8�(�0�P����{%#5���U�T�"����:7�pH��p�)�S�%�n�:{�Ưs7W��ZI�mZa�s����r��1�1G�z�����JI#�x�շ,B\#kz1�5ӳ�yZ[���w׫���Z
u-eʚZ�!˳�!I��Qy�z�H�a;�Z�+F"yo)G�pb6%G��}���鑫y8��&�������7�ce4�Ub�^n��{�}EG�H�����N+'�A첯w���|�Q��9Ib����4��{e�$1�Rx�!���X�������{8F��S�#��u�V):",����p�|�ԋ	0?�8h�2�J�ۯ��5#�k�����P)�� >���׶l�!�-�1����N��q9�����R���(v��Yq��R��%՘kX�J�����!�u���((�1I񩭏l�Z�--���e��wx�o��|3��aW�&�a�(��"�R��y5�R�T�Zd�v�l��0�:Z�q�f�����M�`;�6�nW�=�a��>K��'"P��l�q�,íR�H�A�RÙ./'�@5�j4Rxq7�)�۞���`b9���)�W=���1h���<v���íC��(��f��3k��C�&�������"<<������z�3/�ɒ��T$	�RX�<��i�<e�h��=��R�r��d�s��+,!�L���Ko'Oԉ���	vϫyG6��DW�J�y��d��8o��lR>&�}��%�"�y�>U�d��5��5�L�(A�!��]G �\�&����GQ�����
e_������(}�0����7�G�u>e�1�p����εl���no�{W���s�Ѿn�0G�+���r��k���A܋p7�,��v���>�Q�S���9�㼵R�@�'t�"���h��9��vC�)?�)���x�M�v���f��2��!<�"���>�?�U�#d	�t	��H�(�@c��;}��ͪ3������s�c~��y6�      j      x���ͪ�\z`龯�#:�	�dKkiI�jU�4�igv�̴)

��:>s��kl����8̙,I�|�3��?��_���������������������?�������ۿ���ǿ���������o����������������O�|��_��ߝ����������0�������g�o��/��o�����������\^���3L�_~L�~��������??��c��c��4���m�m�����=��ǿ�?��[��������������������oӼ�>�1�������������O�����z��y�\Ɯ[ƿ������Y{�鹽��:0���[���{���Y�|�~��2���s��2~������Y��+�8�������_���?���������W|~~.�[ƿ���?��Y��2��jm-����?��<�<�~�2�|.���Rm�e�������gQq=���#n�e���}���FT\·j��|��X���?���.Q��R���j�E������~<k��k,��޿�ǟ��ڈ���V��������}����!*����~7bQ����?��~�FT\�/�s��R��(�{�������?���(�{��~?k#*�c~|��Q����}��ǳ6���רE�����~��ܖI�Z�⟫����3��
Q��e|1g��
Q��e|1_ϒº~~p�B�.㫹�~���ǯQ��\��s�s2-���Q��,㫹�~~�~,��Y�Ws���K
[!�_���\|_�wc��n�(�e���_����xǍB�e_�ŗ�|�ޕ�-�o����L���=�o����kl����2�cQ�F.�����7r���Rm��/���7rqf{,����_�C��Ӧ=�o���}��I�^��_�Ź5�kQ�F.���^�⟫����،��(��2����W��_����\u���ů��r_��ᾖ��2
Q�˸������z��(��2������<�M�G!����/���pZ��2
Q���/��cO��8�q#G�p�(D�_��վ��P~m�W<�o���tχj�E���������_c�E��8����7rqF�)�o��3n<�����7rq4�)�o���Y����Ǣ��\��nԢ��sq���S-�=?���|��B�\�|�/~V���C5��/��b.·j.D�_����s��|��B�.㫹8ߍ�Ź����L��B�e_��Y��Q��e|1gIa.D��2�������;��Q˸���p.D�_���\|tb�9��̨�Ģ��\�7�G,����щ��(~#����E�;}q��X�3�~��U,�ߙQG����wrq�i�(~�/>N��Z�z.�rۣ�?W񸛋��<��9��?Q��e|�/~nF��S
���Y�Wsq��B�.㫹8F&�g!�s_��7��(��2�����f���Y�Wg�����,D��2���_>��(�e�����-D�_���\��E�;}�q(h_bQ��yq�p�X������Ģ��\�%�%�e.�Ģ��u�i�X�3���i�E��8��K-��8/�=�R��_��/�F!���y;?�T�����~Y�sq��v�/��b.�:7#�{�0a�]���8j�	��˸a������&�_������&�_���\|:�S��J�m�u|5g��۰�;x��B�ebH=�����/&�<���ۮ���q�x�/���:v#	���Px۞��~Y�W����X�;��v]Ɨ��������d����e�H�1k���~Y�W��~�	����/�Q��R���� ��\�ǻޖ����c�	�MB�8N���$����� u�E'�6���x���9�����~��(� uVFx���7x��ԡ��	��A�SH�mR���'�6������$��_#�������� �Kg ��9I�a<��9I�g�z���G�[>z�����ȱ�Bw����e¸�ԗ3oz��ֱ�Bw��xŏe¸��Gg�XF!�WR?�Q�NR�<T�(.%����c�(�$�Q�=���w$��.	��I�|�z�w%�c�(~�1��HBos�:�T	��I�c��XF,��H�Cp,#ŕ�v,��o��?Gx�eԢ���8�����$��X�p�[�Ws�U�2
Q\J�?�(�(Dq'�3�H�mRR�ي=�Q��RR�Y�<�Q��NR7��(Dq'�-�XF!�;I��/��9I}�~ˈE�;'��n$�6'��a�c�(~'�y��XF,����΅ˈEq%�ˈEq%�ˈE�;'�Q�J�mNRg��ۜ�~y�jQ�����D:�Q��NRg������$u�����$u��	��I��7z����5��2
Q�I�,E'�6'�3�'�6'�����ۜ�~y�
Q�Iꗸ��wrqlz����mJ�mNR7pˈE�;z�ϳ��2bQ�F.΍zBos��塊Eq��ˈE�;7�#mJ�mRR��KBos�:7�	��I�,~&�6'��3Z�2
Q�I��v�c�(�$u�	��I�	��I���c�(.%u�&�6'�s�'��9I}(�2
Q�I�Lbx���7x��ԹQO�mNR���(~�/��	��I��t��r[o��:�T	��I�8i}�#��4Ƒp$�6G���bBo��:��Bw�:�������/��9J}���2
a�Q��&�c�0�(u��J�m�R� nBos�:g�z���_s,�ŝ�~��(�$uv�z���9ݝ�ۜ��BUBos�����XF,��H�YI�mNRg�K�mNRg2��ۜ�΃	��I�	��I���'�6'�s�-��9I����$u|p���]I�XF!�;Ix۔�ۜ�����ۤ�>Ҧ)��9I���:��Bw�:f����$��2
Q������X�#��=Ք�ۤ�>6�So������eĢ��\|�x���q(vJ�mNRGsJ�mNRg���ۜ��nos�:j�Sos�:���&!u�s!�;H}\�~,�����So��:�Q��RGc`J�mRg������#�Sos�:zSos�:�4So���D�x�����'�6�3�H�mR�,#�������g�oJ�mR��0��9H'��� uf	��A�l$�6	��Y�)��9H�So��:��	��A�܌$�6�c�bJ�mRP5%�6�/�2�w�)��9H}\�z,���δ)��9H�7��&!u�x���Q�N�m߆ԧ�� u[$�6������$��W<��9H�%��&!ulx��ԇ�;%�6��ٔ���Ϊao��:r��� uv�x���9������nSos�:���&!�si{��	�MB�ب'�6��������Rtos�:�-�x����lM	��A��R��� u�&�6�/�2�w�-��9H�'x���٦I�mRG�H�mRG.�����|#a�9H��nԢ�H} S�ns�:7#	�MB����v���q�����$��	���� u�v���y|1a�9Hw�L	��A�g�mz��v���9j����Ng$a�IH��v���qW�����۾�O	��A�|�v����v���9j��ۤ���	��9�FkJ�m�Q��H�ns�:~�9a�9G�9a�9GϜ�ۤ�>F_���u��v�s��P�v�s�/�(Dq稣�4'�6�#ߘv�sԱÝv�sԱÝv�s���v�s�129'�6稣j8'�6��lӜ�ۜ���ۤ��=U�ns�:7�	��9ꨨ�	��9�R�v�t�ǡ�cO�[�W�4��s�ns�:
<s�ns�:fF���u���	�M:��ʜ�ۜ�ΫI��&!�1�7'�6�3�M�m߆���� u��x���qFkN�mR�xۜ����[]��&!u|px���ǩ�9��IH�_os�:����� uqx���/�Bw�:�_os�:7#	��A�~&�6���x��ԇ�4'�6�� ǜ��$��e����1�6'�6	���(Dq��l����pN�mRm1'�6�c,zN�mRgc<��9H�O�	��A�eĢ��\iSos�:w�	��A�8�4'�6���x����n$�6�_�f	��I�l7%    �6'��l��ۜ�~y9
a�I�ܩ'�6'��O��ۤ������$u�'�6)�#�'�6'����ۤ�>.��z���!��	��ے���ۜ��/UBos�:��z���9ޝ�ۜ�ήYBos�:����$�˯Q��RRG�&��9I�#<	��I���$�6'�㪼9��9I���z���9��ۜ��1����mI}N�mNR�twBos���8w��\<��9I�IlBos�:7#	�MJ��('�6'�����ۜ��RtBos�:�	��I� ���$��+^��7N��۔�ۜ���	��I�R$�6'����H�mRR�#��9Im�GBos�:f&	��I�81�H�mNR���H�mRRM�GBo��������ۜ��|��ۜ�θ��ۜ�����ۤ�>�{$�6'�cH��ۜ��|��ۜ����GBos�:��~$�6'�3�%�6)��їGBos�:��GBos�:�4��ť���*��9I�iSBos�:�	��I�(�=z���/�(Dq)����#��9I�����$u$�6'�c���ۜ�΍zos�:K
	��I��&�6'�_���wf��t�#��II��F,�ߑ��t�#��9ISя��$uF��&%uTx���ǝ���$u�>x۷%�Gos����(Dq'�_~�Bw�:�xos�:'xx����P�����8�#��9H����� uvbx��Ա�J�mR�%;��� u&�	��A�d����N��ۜ����ۜ�~�9jq���8n	��Q��7%�6G�/���x�x|�����O�m�RG�?��9J��#��9J��k⸣�/�#��}�R$�6g���G�os�:p�G�os�:.vy$�6i���ۜ�ΆS�os�:�	�MZ���&�6g�3O�m�R�7��9K���X�������ۤ���/��9K�5��&-u$	��Y�<�����θ�����5	��Q�܌$�6G�_~�Bw������ۤ��w�ƿm�?~���|�H�m�Rg76�9K�-����,u�~�����L�m�R_Σ(�w�K�m�R�O�os�:��	��Yꗇ��o$�\F-��d<�9K��g�os�:�g�os��r�����3�9K`�3�9K��g�os�:��τ��mK���ۜ��{�	��Y�~>~���Q�~&�6i����3�IK}��	��Y��>~���qj���ۤ�>
<τ��,uTF�	��Y�y&�6g��$�3�IK�/�9K�Il�os�:��\���Rg�� ����� �$�>:��&1�q0�� ���� ���"�3�9Lj�	��a�hp<������L nS�5s���0u��x& 7��cS� �����	��ۘ�3�9LWi=������H nS���(~#C����0u������n$ 7���J�gps�:�	��a�_�	��a�0�	��a�e����q��3�9L���-Dq��c��� ����Hps�:�����q��3�IL����0u& 7��㢁gps�:?�	��a�-�	��a�8j�L�mSg#��9L�����ԡ)<|��ԙ�%�6��sk���$��|#��IL�_�os�:[�	��a�l�%��oc�τ��0�˯Q��Sgڔ����/UBos�:nvy&�6���J�mS�t[Bos�:'Xz���9O��ۜ��\<��9K�Q<��9J������(u�M	��Q���n�&�3��9J�����(uNE'�6G�������τ��(u��J�mNR�*��9I�����$u�{O�mRRǡ��&%��M��[�	��I������$6��9I���X�������ۜ�����wO�mRR�Ttos�:����$uVx���q��3��9I��T	��I�8�$�6'��K�$�6)���(Dq'�c��$�6'�c��$�6'�cF}I�mNR���(�mH}I�mR�I�%��9H��Kos�:��%��9IyӒ�ۜ��,vI�mNR���$�6'��3�$�6'�c�bI�mNR�~�bq�Δ�y*�1��Q��o[|��ԹI�m�R�1¸�ԇm�$�6G�c0lI�m�R�z�$�6G��&�%��9J�_����(uZz��Թ7L�m�Rg�-��9JUKBos�:�FBos�:�؄�&)�a�.	��Q��Xz���q�fI�m�Rs�KBos��e�(~'G����$�>�KBos�:��%��9J�I����(u�	��I��7z���1l�$�6)���(KBos�:�_Bos����(Dq'��N��ۜ�΍zBos�:������$uDYz���!�,	��I�|�z���/U,��i�ch2��9I�����$�˻��w�ԱQO�mRRG��ۜ�έaBos��9�:��a����mI}I�mNR���(�$u\��$�6'�����ۤ���HBos�:`�%��9I������$u��]z��Թ5L�mNRg�H�mNR�+��ۜ������$u�KBos�:��%��9I�Cz	��I�,)$�6'���%��IIQ<��9I��m	��I�,�$�6)�c���ۜ��s	��I���&�6'��Xz��ԹQO�mNR�Q���mI}I�mNR�|�
Q�I�L�z�����K�mNR�7��9I�{����mI}I�mRR��ۜ��CA	��I�<h��ۤ��|#��9I�ݦ���$unFz���_���i"�z���q��+��9IB�+��9I��WBos�:��+��II}�m����$u�m���&%�1��J�mRR��WBos�:F�_	��I�(��x��ԑ��x�����{%�6'��~%�6)��9�Wos�:7�	��I���_	��I�W��o��ǰ�+a�9I��+a�II}"��Bw�:�6�v���G�ۜ�.啰ۤ�>�Q|{��(.%�1��J�mNRgڔ�ۜ�ΒB�ns��r��wI!a�9I������$uVFv���Y�J�mRǔ�+a�9H<���� u֩v���a)�v����H�m�QgI!a�IGIl�ns�:�f	�M:�c镰ۜ�+���ۜ�δ)a�9G�q#a�IG�����u��%�6��:�Wos���/�q�������Νzos�:?U	��A�w<��9Iů��&%ud	��I�����ݿ���$uN�$�6)�����۾-��z����6K�mNR���J�mNRgg<��9I��_Bos�:�T	��I�܌$�6'�s���ۜ��3	�MJ�(*$�6'�sh2��9I��P���ԙo$�6'��3��ۜ��=UBos��������~�9ba\&�	�MR�H�|���q��+��9J��+��IJ����(u����(u��&�6G���y%�6G���{�os�:�|���Y�L�m�R����(u�|��Ա�M�m�R��J�m�R�ѿ��(u�[$�6G��z�W�os�:���(u�	�MR��R%�6I��3������_�os�:���(uH�mߦ�_	�MR����5��9J�I���(u<Tk�o����7���(u�DY|���q�˚������5��9J�5��9J}=�u}?T�(�(uL�	��Q��	��Q�Y|���qYК�����ߚ��$�>�����(u�~�	��Q�hӬ	��Q�8k�&�6G�_�Q��_��9��&�6g��4�΅0.-�1��&�6g�3�K�m�R�Hk�o���0�ք��,upBk�os�:���,u�w�	��Y��Ӭ	��Y�h��	��Y��Hps�:�5�9L�z�	��a��[����ы]����Y�I nSgm$�9L�[���0u�x����Y7L nS��� ���Q�5�9L�m���0uDY����Y7L nSg�H nSg�*�9L��/	�Mb��R����q�lM�mS��&�6��sk����δ)��9L��H	��a��94�xoF|����5K�mS?�i�<��&�6��_ލZ����`M�mSg�#��9L�_���0u�Z|�����J�mS���0uv�|�����J�m���ׄ��0uV?~��ԹI�mS���0~'*Ě������ք��,u�|���q,vM�m߶����,�˯�w�6��(~�oCg ��9K��H	�MZ��Я��CU���R�f$��IK�_�os�:���,u�w'�6g�3�H�m�R�@q�os�:ϓ&�6i�cO��ۜ�β    a�os�����$������0u��	��a�K�m�R_�-��>��ۜ���H�os������;׌�1ׄ��,u"	��Y����?ޥ����,u�	��Y�8ݴ%�6g��3�%�6g�c�uK�m�RG�~���q�iK�m�R��pK�m�R��-�9K�����,��2
Q�Y�،l	��Y�o�~���q���ۜ��jK�m�R绑�ۜ���[�o��:�X�3�>��-�9K������,uо[�os�:��-��9K���\���R篑�ۜ�����ۜ�~>N��ي�|���QQ�|���q����ۜ���([�os�:K
	��Y�L�|���YnK�m�R�t���ۜ���HBos�:�	�MZ������۾m�o	�MZ꣡�%�6i��iK�m�R�|�jQ�Ɖ�q���ۜ�ΒBBo���p_����(u�Eo	��Q�8��%�6G�sJ!��9J��[Bos�:?�	��Q��k����(�˻Q��RgI!��9J�-̄��(uf	��I�,E'�6'��2��ۤ���)��9I��/��9I�m	��I�_#��̨��4[Bos�:���$u���z�����K�mNRgI!��II����$u�	��I�8i�%�6'��P�����sK�m�RgO�m�R��Q�R���-��9J��FBos�:ߍ���(��7��9K�0���,u܈�%�6g����ۜ�Ή���,uv�|���q�Ζ�ۜ��I���,u~�|���q�1��IKU�os�:�
	�MZ�K�m�Rg�*��9K�����(u��|���15����Γ	��Q�|�z���A�n	��Q��	�MR�C��z���/�F,����݈Eq��'�6G�sL/��9J�BUBos�:K�	��Q�،�	��Q�x�����(u}�z���1m�'�6G����'�6G�CS�z���q�Ȟ����)�=��IJ}\ν'�6G�_���wN�MaO�mNR�f$��II}���z������|���//G,�����M��I��	��Q����	��Q�JdO�m�RǴŞ���~y�a�۔�>¸��Q��|���YSH�m�RǴŞ����Ǟ����uO�m�Rg���$��(�������{�os�:Ni�	��Q�|7|���qǞ����	�=��9J��F�os�:N7�	�MR꣇�'�6I����������=��9J�;���(u�$�'�6G��N���$���a�o�����|�����?~�B���R�|���q�ٞ����=U�os���KU��R?wS��SH�m�R�O�os�:Gx|����Q�=��9J'����mJ}O�m�R��=��9J�Q<��9J�Ş��$��/U-����QI�m�RGO�m�R�+�����A��&)��)�	�MR�،$�6G�3mJ�m�R��KBos�:�M	��Q�I�m�R�]y{Bos�:�	��Q�|�z���٦I�m�Rg):��9J���x���/ˈE�;x۸)}O�m�R��gos�:	��Q��6%�6G��/������gos�:_���(uxx����4K�m�R���(�(u~px�����M�mNR��gos�:;�	��I� ����$uVx��ԙ6%�6'��j�����qO�mR��0��9H��	��A��oO�mR�|pkQ���#��9H����� �q�������>�T�2
Q�A�cF�XF!�;H}���(Dq	��l��(Dq��r۱�Bw��80w,���>��2
Q\B�?��c�(� ���=���jF������>,�c�(~�/���v,#�o��#m:���w��	��A�	�������X�s��Z����˨E�3�H�v��ԇ��:�Mo_��G)�XF!�;H������ �1�y,�����H�n����_�n�ns����(Dq������B��:ߍBw�:�؄�� �Aw�>v����p���X����D:���7rq�M	��9�,�%�6�_�X���_~�X�s^�/a�9G�����&ulv�t�[�>v�s�٦I�m�Qg�,a�9G}���(Dq�sk��ۜ���~�n��:�Bw���KU���Q��e��sԹ�J�m�Q ��#a�9G}�/�2bQ�Υfx�v�s�ǅG�2bQ�Νf?}�c�(~��7ˈE�;3�?ѳc�(~'��ſ���2��ۤ��<�Q���Q�+��ۜ��=U�ns�:�T	��9���Ʊ�Bw�:�v�s�Y5L�m�Q���e��t�χjy��������S��a�ns���eĢ��\�x�ns���C�XF,��鋟�?~�X�s�fFv�sԙ6%�6���_�ns��YK?��g�K�m�Qg��ۜ��ք���![�(Dq�d����ۜ���_�ns�:���]G�XF!�;G������]G�XF!�;G��k��s�9���ۜ���	��9���v�s�y�/a�9G�5܄��u��%�6稳���ۤ��_#����Q�M�m�Q�n�n��:H����uF���uVFv�s��-Z�)a�9G�)a�IG}tS�ns��t(�Ϗ�SU�R�ndJ�mRǁ�)��9H��)��9H�cJ�mR���0� u$�Sos�:��)��9H[�)��9H�Д����a�)��9H��)��9H��kĢ���ޕp,#�ݐ�����~�Rբ��mn�x��ԹQ�Q�A�S�x���/YlBos�:GBos�:�SBos�:��)��9Igͦ���$u�n�z���q�iJ�mNR�x���۾-�O	��I��eJ�mRR�y��X�s�5	��ے���ۜ��-nBos�:K#	��I�@!����$u�z��ԁ�N	��I��z���QoK�mNRgg ��9I��FBos�:���$uVFz�����M�mRR�Q��NR��)��9I�����$u�z���Y�L�mNRgڔ�ۤ����ۜ��ٗ��&%u��z�����O	��I�l�&�6'��M��ۜ��)���&%u�)$�6)�����ۜ��1����$u~�z��ԙ�&�6'�sO��ۜ�MaJ�mRRGI!��9I�����.~&�6'�_���wrq|�z���y�,��9IDǔ�ۜ���4	��I�܌$�6'�s�'��9I����mI}J�mNR�39%�6'�����ۜ��{J�mNR�6%�6'�ö�z���!�N	�MJ�h�$�6'�����ۜ���@Bos�:Xz���q�є�ۜ������$u\?<%�6'�s���ۜ��w#��9I���X����۔�ۜ��a����$��+��NR�z���yb ��}[R�z�����z���QR�z�����	��I�ha�	��I�8�8'�6'�ogc`��n����Q�x���/�Bw�:�so����Pm����E�;��(��	��I���	��I���x���G�4'�6'�_ލX����lӜ�ۜ���oN�mRR5�9��9I<��ۜ��R���ۜ��$v.Dq'�㮠9��9I�܄��$un�v���1l1'�6���Ɯ�����H�n����Q�v���1l1'�6������$��(�������9a�9H����� u���	��A�sN�mR$Ĝ����ss�ns�:�F�ns�:K�	��A�4����$��|��w��ۜ����9��9I�Ŝ��$��_��%�>�
�x��ԑ7%�6�_�T�0� u�sos�:��9��9H��z����oJ�mNRg�0��9I�GBo��:j�	��I�l�%�6'�3�'�6)��Ñ�ۜ�~y�ka����	��I�l�'�6'�����ۜ��,6��9I��7L�m�R��0��IJ��	��Q��K�m�R�n$��9J�a<��9J�����(��2ba�N2>��9��9J�����(u��|���a��	��Q��$�6I�c0:��9J};�T�{�-��9Jw��	��Q��J�m�Rm8'�6I�c2,��9J��F�o�6�>'�6G�Cښ|��ԙ�'�6G�������>M�os���*DqI���(DqG���9��IJ����(u6K�m�Rge$��9J�{���(u�|���1Q�����:U�os�:��9��IJ[���(u��M�m�R�������n�#��IJ}��	��Q���	��Q�����$�>��    ���(u�H���(u$�6G�/��1��Bw�:�{$�6I��A�G�o�6��H�m�R3����(u�z$�6G��t�#��IJ}�����(ux$�6G����H�m�R�����mJ������!�cg�[�WO�������|#��IJ}?	��Q�����~y�
Q�Q��{$�6I�#n$�6I�ck����~�5bQ�ͨ?|�����J�m�RG�����n�#��9J�����(unF|���Y�L�m�R�8�#��9J��ע��Q$�6G�c,��۾M�?z���_gc���&�6G�3�%�6I��j���$�>Ɖ	��Q�l('�6G��j���$��ї���(u�׏��(u6�x��ԡ~>x���YI�m�R���Gos�:�p	��Q��L�m�Rg�H�m�Rg�0��9J7�>x���YQO�mRR�=x���AB<x�����K�mRRG�3a�9I�;܄��$u�&�6'�3mJ�mNR������4M�n��:&?v���y%a�9H����&!u�	��A�QO�mR���H�mRg):a�9H��F�n��� :	��A� 	��A�_��o\1�(������H�n��:��'�6���@�ns�:[�	�M:�K�m�Q��H�m�Qg���ۜ�~6h��]�I�m�Q�|pQ�9�tFv�s�yb a�9G���X���c�%a�9G�ca	��9��Rv�s�9���ۜ�Iۜ���H�ns�:��v�s�٦I�m�QG�癰ۜ��W���ۜ�����ۤ�>��τ��u���	��9�8�L�m�Q��g�ns�:�τ�&�Q�}&�6稃�{&�6�3n$�6稣/�L�m�Q�*a�9G��g�ns����R-�{�(�΋?v�s��mz&�6�3�H�m�Q���g�n��:�_!�;G�{��ŝ��a�g�ns�:Ӧ��&�QQ&�6�3�'�6�cHۜ�>�E���.�$�6����3��9H����� ��;�w�ԱSO�mR�Q�gos�:X�gos�:��gos�:.�}&�6�s�������������&!u>T�(��?x�����J�mRǑ�gos�:�f	��A��{&�6��z&�6	�J�����$6��9H��k�����x���/U,��RGI=��9H�]��&!�q`������#��� u����� u�0x���/%���&%uL�$�6)��#sτ��$��SU��R���g�os��e�8�(u�}x&�6G�s;��������(u&�6G���}&�6G�_�Q�R�V=��9J'ߟ	�MR�SH�m�RgK9��9J�����(u�x|���Ǒ�g�os�:��	�MR��5bQ�N2�Q���(unF|���9����$�>��g�os�:p�g�o��:6#	��Q�6L�m�R�CU��R�DU�os�:K
	�MR���&�6G��to�os�:��%�6G��xS�os�:�_�os�:�_|���/�F,��錏Q�	��Q������NN!��9J��kԢ��\�I|���/�x!��R_|����A�%��9J�{���(u�~.	��Q��]|����4[|���q�qI�m�R�@Ւ�ۜ�~y9
a\Z�c�pI�m�Rǭ�K�o���h�-	��Y�(�,	��Y������,u��,	��Y�H�����,u�1�$�6g�c�{I�m�R���(~���h�-	��Y�h�/s!�;K��F�os�:�7-	�MZ�ciI�m�Rgi$�9Ke�%�9KG��&-u~�
Q�Y��&�6g��X|���q�tI�m�Rg�H�m�Rg���ۜ���fK�os�:_���,u�.	��Y�HrI�m�R�$�6g�3O�m�RǴŒ�ۜ�~��$�6����H�mSg�K�mSgM!�IL�	��aꗇ������%�9K������,uv�~���q�aI�m�RQ����,u��K�os�:G�~����n$�6g�3�%�6g�3�M�m�R^���ۜ�����,u�M	��Y�K�m�Rgc<��IK}}Xz��Թ�M�m�R���$�6i��ݔ�ۜ��+ߗ���,u@[KBo��:�Q���R���(�,u��%�6i�c	�MZ�،$�6g��O�m�RgG9��9K�_����,uN[$�6g��2�����������(u��K�m�R���$�6)�c7��9I�IlBos�:'Xz��Թ5L�mNR�؄��$u��$�6'�_ލBw�:H�%��9I���	��I�܌$�6'�_��|���94��۾M�/	��Q�E'�6G�_��w�q�N	�MR��\|��ԹI�m�Rgi$��9J��x�o���8��J�m�R�����$�>ҿW�os�:��+��9J��W�os�:J#���(u@[���(u�����(u�z���/�/���mc������/UBos�:&X_	�MR��8�+��9J�_���&)�qb���۾M��z���qd������=UBos�:*#���&)�qd�5����QQ%�6G��ʿWBos�:�T	��Q�y%�6G��K�����n�+��9J��k����q��+��II�_�X�3�~v�>>q_	��I�	��I�'~%�6'�����ۜ����ۜ�/��ۜ���gBos�:q_	��I�h(�z���᥼z����PN�mNRg�K�mߖ�_	��I�e����Y�N�mNRg�&��9I������YRH�mRR7�x���/�/����1l��ۜ���;��=O��ۜ���_os�:�_os�:��x��ԙ6%�6'�3�'�6'�3�K�mRR�no���P�_	��I긝�����������)��&!������_os�:ؗWos�:�T	��A�܌$�6�s������q��� �˻��7rq�ׯ�� uVx��ԙo$�6�s�0��9H�U��� u�~%�6���+��9H�Ilos�:��Wos���KU��R�aos�:��WBo��:�m	��I���&�6'�so��ۤ���	�MJ�|7
a�I�l�&�6'�sJ/��9I�򥊅qw��+��9I���	��I����ۤ�·*��4�ǕG���$u~�x�����J�mNR�I��&%uTxx۷%�Wos�������R�	��I��	�MJ�c.lM�mRR?��Ǐ��ŝ���i���$ulF���$uTF���$ut����$u��kos�:��	��I�R_x���/ˈEq�_x���Aw�	��A��a�	��A�܌$�6�c�gM�mRGM�mRgsM�mNR��������:⸣ԙ�%�6G���&�6G�������5��IJG�os�:N��	��Q�}��&)�ឭ	��Qꨩ�	��Q�,oM�m�R^�����nM�m�R��&�6G��6�����&�����n�o�6��&�6G��ٚ�����U�;O�m�Rg������sM�m�Rg1:��9J�s
	��Q����&)����	��Q��7|����|��Թ�Bw���݈E��8+�	��Q��\|۷)�5��9Jg����(ux|���YI�m�R��g�o����_���(u�E'�6G�_^�Bw�:K
	�MR��5|���q�tM�m�Rgc ��IJ}�@�&�6G������(������F�os�:��|������E�;}qM&�6G�sf$��9J����(u��|���ѦI�m�R�5k�os�:P�5��9J�-���(u��|����P���ԙ�'�6G���5��9J�;܄��(uNE'�6G��۔����M�m�Rg�)��9J��/��9J���Bw�:���&)uTz��Թ�J�m�R�C�����\<��IJCz	��Q�,�$�6G�������)����(u��'�6I�cd2��9JW7m	��Q��ŷ��&%���o	��I�d����$u|����&%���m	��I���n	�MJ�|7
Q�I�(�l	�MJ��%�6'�cfdK�mNR�,#��\1��*��9I'����$ǔl	��I�(�m	��I��|�/��F,�;�mK�mNR�7��9I��l	��I�`���ŝ��w#a�9I���Bw�:������$u�����$u��l	��I�d����$�˻Q��NRǔ�ۜ�δ)a�9I�����&%��4�v���YRH� I  mNR�7a�9I�{����$u�[�ns�:�x�ns�:�F�ns�:D�-a�9H�����&��l	��9�8�%�6�_�Q���vԷ���u&�v�s�qWЖ�ۜ���5�y~��(�u�v�s�9���ۤ�>��m	��9�,�$�6稟�����~xK�m�vԷ���u��v�s�7v�t��nĢ�sԷ���mG}K�m�Q�I����u0[[�ns�:Ӧ���u��'�6騏�f[�ns�:G�v�s�q|qK�m�Q���[os�:k
	��A���&�6�_G!�;H�Ϳ�&!u�x���y%��9H�{��� u�x���A[l	��A��۶�� un�x��ԹI�mRgc<��9H��
Q�A�|7x���ϲ����H�mR绑����	��� u�m[os�:n��x���9���$��Gos�:n��x����5K�mR�+���$���~o��:ލ�� ���<~<T�(~#�F=��9H��	��Aꬌ$�6�s.,��9H"�������~os�:�ߞ�����������X?��(Dq	��cO�mR�CU��R�$�'�6����'�6'��ݴ'�6'��p��ۜ��ý{Bos�:6U{Bos�::�{Bos�:v�{Bos�:�F���&%�1³'�6'�c�{O�mNR�|�bQ�Δ�8��'�6'����'�6)��Z���ۤ�>
U�\��NR�7��9I�܄��$u���'�6)������ۜ�~y7
Q\J��p��ۜ���{Bos�:��	��I���z���Y�M�mNR�@՞�ۜ��(��ۜ�θ��ۜ��#s{Bo��:6�	�MJ�c�uO�mNRǐ���ۜ��jO�mNR�<T�(�$�������O�mNRgO�mNR�C��ۜ��wO�mNRgc ��9I��/	��I�8M�'�6'�����ۜ���HBos���K��7rq�|�z���Y�L�mNR�q�=��9I��_Bos���׈E�;C�|7bQ��ކ�aBo��:��	��I�eԢ�����+hO�mNRg#��9I�5܄��$u�����$u U{Bos���*Dq'�s�'��9I�5���$u?x���a	�	��I�'N�mNR�+��ۤ��Oo��:�m	��I��I�mNRg�-��9I�Ilos�:���	��I�l$�6'�����ۜ��ї��$u�m{os�:��x����n$�6'��Jos�:7#	��I�<0�����Oos������w������c(	��A�Lbx��ԹQO�mR�)��&!uX
	��A�<�����~���6�ߍX����K����~a_z����5K�mNR�n$��9I������$��P�	��I꣦p,�ƿ+��(�q'�_�Q�NR��漽�Bw��h7�(�q'��sg2~,�ŝ�>D�c�(�$�Q�>�Q��NR���2bQ�F2>@��#��9I�����$�Q9���w��s�>??ߍ�&%u|�x���/U,��+ƏeĢ��\|t�2jQ�F.��Pu,��́�c�(�$u�Ms!�;I}Ԣ�e���ԇ�|,�ŝ�>p�(Dq'��K��ۜ�>��e����/_�B��:*#	�MB�\F!�;H}@#�2bQ���?Ů	��A�L�x�����z�k�	��A�|�x���QRH�mRG.����>��c�(~gH��x-���XF-��R�93y,���δ)��}R?�Q��R��e����/�(Dq��#�2
Q�A�c�XF!�;H}�<�Q��Rge$��9H����&!���P�eĢ����� u~�x���9l����>.J?���w���R%�6��j���$���K9���w����n<>��	�������Z�1��a��� �q*h�H�mRgE=��9H�S�	��A��j�c�(� u�L&�6	���(D��B��2
Q\B�}I�mRg�&��9H�Q<��9H��MO�gO�mR�+���$��\<��}R?���w��(�%�6	�������Ϊaos�:�T	��A��	��A�<1���$������ ���S=���Hos�:�m	��A��&�6������Ίzo��:΋'�6��2����δ)��9H�'�x���9N����θ���$���Hos�:�T	��A���x��ԹQO�mRg�&a�9H��E���w��]_<a�9H��)a�9H�S�n���8�>%�6�������>��c�(�]H�XF!�;H��S�ns�:*�S�ns��%n����Q��v���7v���q`nJ�mR�,#����)a�IH��F,��9/�=U�ns�:��S�ns���רE���	�M:�#�v�s��ޟ�Bw�:F_�����so;-�w#a�IG����2
Q\:���&�6稣�9%�6�c�sJ�m�Qg�K�m�Q��4�:
a�A�ܩ'�6��D�x��ԹI�mR�@Ք������Sos�:�)��IH���� ut���&!���˨����@Ք�����/��9HC#So�6�>%�6��n�)��9H}�{,����(����bJ�mR���(.!�!N	��ې�������gos���4��ۜ�0eJ�mNRgi$��9I�	GBos�:�L	��I�F����$�q���Xw����ۜ��FMBos�:+<	��I�L8z����eN	��I���k���Q��RRG�H�mNR�*��}[R�z����O�mNR�2%�6'��ٔ�ۜ��I܄��$uv�z��ԙ6%�6'��XPBos�:��	��IꜶH�mNR�<T�(~'G�K�mNR�T?|����|���/�(�qG�3oJ�m�Rg7��IJ����(u�b|���9����"n�os�:��'�6G��3�������&)ut|���9����������>������1���(u�M	��Q�aM�m�R��H�o��:�����x�os�:nK�|���/�(DqG�chrN�m�R�4'�6G��΍��3��	��۔������$vN�m�R��pN�m�Ru�9��9J�Ȝ�����iN�m�R%�9��9J'8���(u �s�o��������(u�	��Q�(~�	��Q������(u��2'�6I���ߜ��$�~.c��Pբ��s�K�+DqI�#��Q�Q�e����1O<'�6G���9'�6G��O�m�Rge$��IJ��(DqG�ciN�m�R�X؜����6͜�������� �����s(sBo��:�����(u��z��Թ5L�m�Rg�*��9J���	��Qꀶ���mJ}N�m�Rg���&)u�M	��Q�sN�mߦ����(uVz����i�9��9J�%����(uf	��Q�`����(�˯Q��NRg�'��9I����&%ulx����O�mNR�3'�6'�3�M�mNR�^3'�6'��������BUBos�:G?z������a�/����N>R      k   �  x���Ko�0���D.m�6ȣ�;e�ci��l;��$B,ѓ�t٧%;���=��e�"�3��&���l�����v��eNd��1�:g�ye��b�3r��s�;9�4�����_o8�����8Wd<<���c�y$*x��x	~M�F#h2HY�Ҩ=9xS~,tƖ�Te+;�d]W^\�z=������T|���駣I+d�W�>J<��t`a7�9��-�!ceV�~QZ�/�9��V�\����O��e�5�UJ�h��Q	R�?�hOh7�3�L��F�)'5R2�R�ſh��9E]�Z�&�
sД)�u�U|�y�6�M{|/��N�LLdd0�9��l�2��a㪪4YXުL,y��0�WKZj��>J�F��\�)Q{��(M	7�CRPHFU|���=��p�rpe��@��yGM%
e�f���M�c�r��
�kj�Z�X���ɐ=�4T(���
j;6Ơ�J�r����w�=c����j�Z�;��f�Ql!�K!4Q<��񲕞%�w���|���Mu�*5*a!��F*Z����O��u]�;�f#ʃgV�J��b$���γ&	�-̨��!�J�[j�0���6���RY� �+)�Z�{�r氮�\&�J�G���������?A���[c_�Fl�m_hW5ל��uvt�Mʷ�      l   �  x����Ja��>�pV
����Bp!�q+&q!��H o��:��	������twUwu�������������t�����������������q������|9|{x�z���~}{���������l�������rϗ�O�����%b#�χ�~��l�ՏV�c6��Ч�F�
XΘ��tۏ������0	W���\��
X)��vLX1�	e����;���bv�Y�DEjT8\z�wØ3"���DN8�	4"'��
�H�/F6�#���ණH%�pe%��)��O"�cV�p�^Y��3R��Kz"`e�x����dЈ��<9#z?(f)r�T��]���%�IN�Ԯ�$�y�I��}{����D蝶��$[���s2���������Xa������II�� z��i.��q�5�9#zf�@����dej�2�m״ʐ��*�bU��!�語L�vU���B�Nx�`N�y�w^wF�vUQ$dV�T5�V��JU:F��(���
���v���ﶹp5����yK_X���Ή�x3�I�
$x�hf|f�ml+[p�ns�q��{s'K�����w�x{����6�n]7�q����NZ^	��@[�g�'�ˈs����.�8{��9d����*ɡ��-���ˌ?�v� ���
�㉅���xi��LU��_�s����`����]���ne�}f��U�%�����X��R���r�3b�Ov�>��������?��v�®�����A=      n   N  x�Ř�n�0E���A6I %��]�AҴh�l��,$R i����G��(D��"y��r<������#���@×�J���Z�B*��"�a$f���Y%�.4o_�Ndp�����8����w�o����au矸SN;�ӥ�E�U��-H��g�k���܋5�k���UӲ��0����`RG�M��2���������H������$j���̀{����F��߄�[p���5�|[�%���f`,h�i��r�yZ-p�A���neU�'Ӂ�S����-	���V&�[�	��Cu��gk�f0��nIfd�*��R 3�lU�-J��N� �{�[�X��oI������-Jgk�N������Գq"�%���E�w�l��j��$��I"�� .��i��8B�V��N�/�隽��p���g2�E�r`��S��_�F��?�\ȣ	С�Y�PQlM��f�qD�܅��	[\+�`2��~��h�&S)�ccwA�G���^<��=���Lv�]c����V{l��\`�hǝC�f+�����<�I������6p�&��Gs0'��iz��G�_Ѣ�      m   �  x��Y�r�6��)ps2#���lOOm�L<�������H��X ����}�>Iw��(�I3���84��.v�owu���ݻ���_������S�3K��ӎ+�)S9���e����3�i^���|�{O���	�/��Մ\��˹,.���1�[2R�G^51��^qK6"�1�N%Y��C�]9�x����4@�������*=�儬n����#\�.���_����� \�.o�#��X\N��o�X)�|0>�u�5�)%��)J��_j��j�2^&JcUM/dJ�׀�fz5��42g�p���8YBw�Dm	�*�@йn
��M��W��oT�g"�h�9�����J�����f��Vs�Է�}6�cك���{2v*�p��ҹ�Z�dNe��!1�^]�&dy=��D��ܖ���M��Is��
�����Ov�D	�}UkU����d%:���O�ߛ/�uQ�5ֺ����<��E��B�}�*�	e�8\-��ݱ�g��'�vF���@ ��E�R�[�<�F�稊b8t�5H�LUn'ŧZ0���D��/+� /m�ҟ�'h�����@r�pC �J����O�2ַ#�Ȩ�p,��	{ċ�]�Bz�?p����ޚ��p�T��-��1̱NJ��=%�T�1ЀX������hأ�N=������~�0������#�xΤ���w���y
ET�
rV������0�;%v`^n�y)��9��<�9)��4�[�Qi����B#yU���w�s��[8����|>�]sd��x�t+_J��v�Q�R��jvZ��`���[�
����)��� ���
6E[r�5D��-���_�?��6�EҾ�`T��*�K%�÷J�4�K%,��YJ"[-���Qy`���F�B���VL����Z�4��.ۻK�{����6Su� ���
x�n9m��R�_�ujW��r���<)�<�6��-C�� �UwJ�����t����4����8�q[ke�
(�;Z$�u�f[͘%�w�����]��#�c�
`��,wT��f�L��yҜ���d�a_�`�2H,�̋���f�H�y�G1�U>�4��eؐ������0��;F���x�h�������[ �U���z5��G�2_�K�`�e�������.1�tSSc�c�#��g�@9�8�3�hs"	c���9$���x�z�I�d-�@$�|��g�y�ܾ'���O�jh׿k��oؽ���h��r�iC��ˠ�Aɉk���@S	5�n�/��5)�`�p�0�T�7)m�F����?[v�]n@Ĵ�3h�SB�)�����MV��p�5�!|d|�EV�'`�z���Q����d��@h�&W�D0i����+��+q�i�X�T��rkHp�ƞ���sE���[��ۺN<�e�GiE����쨤���8*�^�M����F�q���2������~я��¹���B�T�y(^(��1N;�t�V���w4$l ��y�F�p�8���ۄ�&+q��V�)��&pB�ֳ�23�m�Ϗ��%�;�M��tGݭ���r��������6��u�-G�[d�0��G�x��貓��\ʤ[/Nj��_3r<{_�7:��Hu=��
<�Y��vgK�u��Ol.�/����ؗ�t�y�n	Ye�xӍXB}�$Ҷ^��U#�~D�U_Gs��לn�R1]0��j����t���X�sxA�ʞb)������K�j�A8ß=��ӰT     