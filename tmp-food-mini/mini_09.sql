DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: سبزی‌پلو با ماهی (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سبزی‌پلو با ماهی', 'compound', 'lunch', NULL, 'lunch:13:سبزیپلو-با-ماهی', 'سبزی‌پلو بدون روغن اضافه و ماهی نسبتاً کم‌چربِ فرپز یا تابه‌ای. هر ۱۰۰ گرم ماهی پخته حدود ۱۵۰ کالری / ۲۶ گرم پروتئین. ماهی سوخاری یا ماهی چرب مثل سالمون، کالری متفاوتی دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 39g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سبزی‌پلو با ماهی — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 39,
    'lunch:13:سبزیپلو-با-ماهی:450', '[{"name":"ماهی پخته بدون استخوان","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"سبزی‌پلو","amount":"۱۱۰ گرم","household":"۱۱ قاشق سرصاف"},{"name":"روغن سهم پخت","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 40g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سبزی‌پلو با ماهی — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 40,
    'lunch:13:سبزیپلو-با-ماهی:500', '[{"name":"ماهی پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"سبزی‌پلو","amount":"۱۵۰ گرم","household":"۱۵ قاشق سرصاف"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 41g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سبزی‌پلو با ماهی — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 41,
    'lunch:13:سبزیپلو-با-ماهی:550', '[{"name":"ماهی پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"سبزی‌پلو","amount":"۱۹۰ گرم","household":"۱۹ قاشق سرصاف"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماهی با نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماهی با نان', 'compound', 'lunch', NULL, 'lunch:14:ماهی-با-نان', NULL)
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 41g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماهی با نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 41,
    'lunch:14:ماهی-با-نان:450', '[{"name":"ماهی پخته بدون استخوان","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"نان","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"روغن سهم پخت","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 43g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماهی با نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 43,
    'lunch:14:ماهی-با-نان:500', '[{"name":"ماهی پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"نان","amount":"۷۵ گرم","household":"۲٫۵ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 44g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماهی با نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 44,
    'lunch:14:ماهی-با-نان:550', '[{"name":"ماهی پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"نان","amount":"۹۵ گرم","household":"کمی بیشتر از ۳ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: قورمه‌سبزی با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('قورمه‌سبزی با برنج', 'compound', 'lunch', NULL, 'lunch:15:قورمهسبزی-با-برنج', '۱۵۰ گرم خورشت در اینجا شامل گوشت نیست؛ گوشت جدا به آن اضافه می‌شود. روغن خورشت در برآورد لحاظ شده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 120 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قورمه‌سبزی با برنج — 120 کالری', 'compound', 'lunch', NULL,
    v_base_id, '120 کالری', 120, 4,
    'lunch:15:قورمهسبزی-با-برنج:120', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قورمه‌سبزی با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 28,
    'lunch:15:قورمهسبزی-با-برنج:450', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"برنج","amount":"۹۰ گرم","household":"۹ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قورمه‌سبزی با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 29,
    'lunch:15:قورمهسبزی-با-برنج:500', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۳۰ گرم","household":"۱۳ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قورمه‌سبزی با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 30,
    'lunch:15:قورمهسبزی-با-برنج:550', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۷۰ گرم","household":"۱۷ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
