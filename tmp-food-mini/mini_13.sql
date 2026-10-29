DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: ساندویچ تن ماهی (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ تن ماهی', 'compound', 'dinner', NULL, 'dinner:3:ساندویچ-تن-ماهی', 'تن ماهی روغنی پس از تخلیهٔ روغن قابل‌جداشدن؛ هر ۱۰۰ گرم آبکش‌شده حدود ۱۹۰ کالری / ۲۶ گرم پروتئین. بدون مایونز و روغن اضافه. وزن خالص قوطی با وزن تنِ آبکش‌شده یکی نیست. برچسب محصول مبنای دقیق‌تر کالری است؛ آماده‌سازی کنسرو را مطابق دستور روی بسته انجام بده.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تن ماهی — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 35,
    'dinner:3:ساندویچ-تن-ماهی:400', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۰۰ گرم","household":"حدود ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 37g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تن ماهی — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 37,
    'dinner:3:ساندویچ-تن-ماهی:450', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۰۰ گرم","household":"حدود ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 39g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تن ماهی — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 39,
    'dinner:3:ساندویچ-تن-ماهی:500', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۰۰ گرم","household":"حدود ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"نان","amount":"۹۰ گرم","household":"۳ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ کتلت (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ کتلت', 'compound', 'dinner', NULL, 'dinner:4:ساندویچ-کتلت', 'کتلت فرپز یا تابه‌ای با گوشت نسبتاً کم‌چرب، سیب‌زمینی، تخم‌مرغ و روغن محدود؛ هر ۱۰۰ گرم آماده حدود ۱۸۰ کالری / ۱۰ گرم پروتئین. روغن پخت داخل وزن و کالری کتلت حساب شده است. مایونز، سیب‌زمینی سرخ‌شده و روغن اضافه در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ کتلت — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 20,
    'dinner:4:ساندویچ-کتلت:400', '[{"name":"کتلت آماده","amount":"۱۲۰ گرم","household":"۲ عدد متوسطِ ۶۰ گرمی"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ کتلت — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 22,
    'dinner:4:ساندویچ-کتلت:450', '[{"name":"کتلت آماده","amount":"۱۲۰ گرم","household":"۲ عدد متوسطِ ۶۰ گرمی"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ کتلت — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 24,
    'dinner:4:ساندویچ-کتلت:500', '[{"name":"کتلت آماده","amount":"۱۲۰ گرم","household":"۲ عدد متوسطِ ۶۰ گرمی"},{"name":"نان","amount":"۸۰ گرم","household":"۲⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خوراک مرغ و قارچ با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خوراک مرغ و قارچ با نان', 'compound', 'dinner', NULL, 'dinner:5:خوراک-مرغ-و-قارچ-با-نان', 'بدون خامه، پنیر و کره؛ مرغ و قارچ جدا وزن می‌شوند. روغن نوشته‌شده، کل سهم روغن پخت همین وعده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 42g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 42,
    'dinner:5:خوراک-مرغ-و-قارچ-با-نان:400', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"پیاز پخته","amount":"۲۰ گرم","household":"۱ قاشق غذاخوری پُر"},{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"},{"name":"روغن","amount":"۴ گرم","household":"حدود ¾ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 43g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 43,
    'dinner:5:خوراک-مرغ-و-قارچ-با-نان:450', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"پیاز پخته","amount":"۲۰ گرم","household":"۱ قاشق غذاخوری پُر"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"روغن","amount":"۴ گرم","household":"حدود ¾ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 45g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 45,
    'dinner:5:خوراک-مرغ-و-قارچ-با-نان:500', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"پیاز پخته","amount":"۲۰ گرم","household":"۱ قاشق غذاخوری پُر"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"روغن","amount":"۴ گرم","household":"حدود ¾ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
