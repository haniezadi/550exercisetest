DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: یک واحد میوه فصل (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('یک واحد میوه فصل', 'compound', 'snack', 'simple', 'snack:1:یک-واحد-میوه-فصل', 'هر واحد میوه حدود ۶۰ کالری دارد. گزینه‌های پاییزی ابتدا آمده‌اند: سیب، گلابی، نارنگی، پرتقال، انار، خرمالو و کیوی. وزن‌ها مربوط به قسمت خوراکی میوه، بدون پوست غیرخوراکی، هسته و ضایعات هستند. هر فهرست شامل انتخاب‌های جایگزین است؛ همهٔ میوه‌ها با هم مصرف نمی‌شوند. پروتئین با نوع میوه متفاوت است و وزن خوراکی، ملاک دقیق‌تر از اندازهٔ ظاهری است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 60 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'یک واحد میوه فصل — 60 کالری', 'compound', 'snack', 'simple',
    v_base_id, '60 کالری', 60, 1,
    'snack:1:یک-واحد-میوه-فصل:60', '[{"name":"سیب","amount":"۱۱۵ گرم","household":"۱ عدد کوچک"},{"name":"گلابی","amount":"۱۰۵ گرم","household":"۱ عدد کوچک"},{"name":"نارنگی","amount":"۱۱۵ گرم","household":"۲ عدد کوچک"},{"name":"پرتقال","amount":"۱۳۰ گرم","household":"۱ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۷۰ گرم","household":"حدود ½ لیوان"},{"name":"خرمالو","amount":"۸۵ گرم","household":"۱ عدد کوچک یا نصف عدد بزرگ"},{"name":"کیوی","amount":"۱۰۰ گرم","household":"۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 120 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'یک واحد میوه فصل — 120 کالری', 'compound', 'snack', 'simple',
    v_base_id, '120 کالری', 120, 2,
    'snack:1:یک-واحد-میوه-فصل:120', '[{"name":"سیب","amount":"۲۳۰ گرم","household":"۲ عدد کوچک"},{"name":"گلابی","amount":"۲۱۰ گرم","household":"۲ عدد کوچک"},{"name":"نارنگی","amount":"۲۳۰ گرم","household":"۴ عدد کوچک"},{"name":"پرتقال","amount":"۲۶۰ گرم","household":"۲ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۱۴۰ گرم","household":"حدود ۱ لیوان"},{"name":"خرمالو","amount":"۱۷۰ گرم","household":"۲ عدد کوچک یا ۱ عدد بزرگ"},{"name":"کیوی","amount":"۲۰۰ گرم","household":"۴ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 180 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'یک واحد میوه فصل — 180 کالری', 'compound', 'snack', 'simple',
    v_base_id, '180 کالری', 180, 3,
    'snack:1:یک-واحد-میوه-فصل:180', '[{"name":"سیب","amount":"۳۴۵ گرم","household":"۳ عدد کوچک"},{"name":"گلابی","amount":"۳۱۵ گرم","household":"۳ عدد کوچک"},{"name":"نارنگی","amount":"۳۴۵ گرم","household":"۶ عدد کوچک"},{"name":"پرتقال","amount":"۳۹۰ گرم","household":"۳ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۲۱۰ گرم","household":"حدود ۱½ لیوان"},{"name":"خرمالو","amount":"۲۵۵ گرم","household":"۳ عدد کوچک"},{"name":"کیوی","amount":"۳۰۰ گرم","household":"۶ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: شیر کم‌چرب (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیر کم‌چرب', 'compound', 'snack', 'simple', 'snack:2:شیر-کمچرب', 'شیر کم‌چرب با حدود ۴۶ کالری / ۳٫۴ گرم پروتئین در ۱۰۰ میلی‌لیتر؛ بدون شکر، عسل و پودرهای شیرین. درصد چربی و اطلاعات روی بستهٔ شیر، مبنای دقیق‌تر محاسبه هستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر کم‌چرب — 110 کالری', 'compound', 'snack', 'simple',
    v_base_id, '110 کالری', 110, 8,
    'snack:2:شیر-کمچرب:110', '[{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر کم‌چرب — 160 کالری', 'compound', 'snack', 'simple',
    v_base_id, '160 کالری', 160, 12,
    'snack:2:شیر-کمچرب:160', '[{"name":"شیر کم‌چرب","amount":"۳۴۵ میلی‌لیتر","household":"۱½ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 210 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر کم‌چرب — 210 کالری', 'compound', 'snack', 'simple',
    v_base_id, '210 کالری', 210, 16,
    'snack:2:شیر-کمچرب:210', '[{"name":"شیر کم‌چرب","amount":"۴۶۰ میلی‌لیتر","household":"۲ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست ساده کم‌چرب (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست ساده کم‌چرب', 'compound', 'snack', 'simple', 'snack:3:ماست-ساده-کمچرب', 'ماست معمولیِ بدون شکر افزوده با حدود ۶۰ کالری / ۴ گرم پروتئین در ۱۰۰ گرم. ماست چکیده، پرچرب یا میوه‌ای، جایگزین مستقیم این محاسبه نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست ساده کم‌چرب — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 7,
    'snack:3:ماست-ساده-کمچرب:100', '[{"name":"ماست کم‌چرب","amount":"۱۶۵ گرم","household":"۱۱ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست ساده کم‌چرب — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 10,
    'snack:3:ماست-ساده-کمچرب:150', '[{"name":"ماست کم‌چرب","amount":"۲۵۰ گرم","household":"حدود ۱ کاسهٔ کوچک پُر"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست ساده کم‌چرب — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 13,
    'snack:3:ماست-ساده-کمچرب:200', '[{"name":"ماست کم‌چرب","amount":"۳۳۰ گرم","household":"۲۲ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
