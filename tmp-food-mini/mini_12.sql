DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: کباب کوبیده با برنج یا نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کباب کوبیده با برنج یا نان', 'compound', 'lunch', NULL, 'lunch:25:کباب-کوبیده-با-برنج-یا-نان', 'کوبیده با چربی متوسط؛ هر ۱۰۰ گرم پخته حدود ۲۷۰ کالری / ۲۳ گرم پروتئین. بدون کرهٔ اضافه. با نان، پروتئین نسخه‌ها حدود ۳۰، ۳۲ و ۳۳ گرم است. هر سیخ رستورانی الزاماً ۹۰ گرم نیست؛ وزن و میزان چربی باید در نظر گرفته شوند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب کوبیده با برنج یا نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 28,
    'lunch:25:کباب-کوبیده-با-برنج-یا-نان:450', '[{"name":"کوبیده پخته","amount":"۹۰ گرم","household":"۱ سیخ کوچک با همین وزن پخته"},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان ۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب کوبیده با برنج یا نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 29,
    'lunch:25:کباب-کوبیده-با-برنج-یا-نان:500', '[{"name":"کوبیده پخته","amount":"۹۰ گرم","household":"۱ سیخ کوچک"},{"name":"برنج","amount":"۱۳۵ گرم","household":"۱۳½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب کوبیده با برنج یا نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 30,
    'lunch:25:کباب-کوبیده-با-برنج-یا-نان:550', '[{"name":"کوبیده پخته","amount":"۹۰ گرم","household":"۱ سیخ کوچک"},{"name":"برنج","amount":"۱۷۵ گرم","household":"۱۷½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۹۰ گرم","household":"۳ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ مرغ (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ مرغ', 'compound', 'dinner', NULL, 'dinner:1:ساندویچ-مرغ', 'مرغ بدون پوست، بدون مایونز، پنیر و سیب‌زمینی سرخ‌شده. روغن نوشته‌شده، سهم پخت مرغ همان وعده است. سبزیجات همراه می‌توانند داخل ساندویچ قرار بگیرند. برای جایگزینی نان سنگک با نان ساندویچی، وزن و کالری روی بسته ملاک است؛ یک عدد نان ساندویچی اندازهٔ ثابتی ندارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 38g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ مرغ — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 38,
    'dinner:1:ساندویچ-مرغ:400', '[{"name":"مرغ پخته و ریش‌ریش","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"نان سنگک","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 39g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ مرغ — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 39,
    'dinner:1:ساندویچ-مرغ:450', '[{"name":"مرغ پخته و ریش‌ریش","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"نان سنگک","amount":"۷۵ گرم","household":"۲٫۵ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 41g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ مرغ — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 41,
    'dinner:1:ساندویچ-مرغ:500', '[{"name":"مرغ پخته و ریش‌ریش","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"نان سنگک","amount":"۹۵ گرم","household":"کمی بیشتر از ۳ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ تخم‌مرغ (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ تخم‌مرغ', 'compound', 'dinner', NULL, 'dinner:2:ساندویچ-تخممرغ', 'تخم‌مرغ آب‌پز یا پخته در تابهٔ نچسب؛ بدون مایونز و پنیر.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 23,
    'dinner:2:ساندویچ-تخممرغ:400', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"روغن","amount":"۲ گرم","household":"کمی کمتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 24,
    'dinner:2:ساندویچ-تخممرغ:450', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۸۰ گرم","household":"۲⅔ کف دست"},{"name":"روغن","amount":"۲ گرم","household":"کمی کمتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 26,
    'dinner:2:ساندویچ-تخممرغ:500', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۱۰۰ گرم","household":"۳⅓ کف دست"},{"name":"روغن","amount":"۲ گرم","household":"کمی کمتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 20 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 20 کالری', 'compound', 'dinner', NULL,
    v_base_id, '20 کالری', 20, NULL,
    'dinner:2:ساندویچ-تخممرغ:20', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
