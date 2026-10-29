DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: نان، کره بادام‌زمینی، موز و شیر (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نان، کره بادام‌زمینی، موز و شیر', 'compound', 'breakfast', NULL, 'breakfast:9:نان،-کره-بادامزمینی،-موز-و-شیر', NULL)
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 14g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره بادام‌زمینی، موز و شیر — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 14,
    'breakfast:9:نان،-کره-بادامزمینی،-موز-و-شیر:350', '[{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"},{"name":"کره بادام‌زمینی","amount":"۱۵ گرم","household":"۱ قاشق غذاخوری سرصاف"},{"name":"موز بدون پوست","amount":"۱۰۰ گرم","household":"۱ عدد کوچک"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"چهارپنجم لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره بادام‌زمینی، موز و شیر — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 16,
    'breakfast:9:نان،-کره-بادامزمینی،-موز-و-شیر:400', '[{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"کره بادام‌زمینی","amount":"۱۵ گرم","household":"۱ قاشق غذاخوری سرصاف"},{"name":"موز بدون پوست","amount":"۱۰۰ گرم","household":"۱ عدد کوچک"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"چهارپنجم لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره بادام‌زمینی، موز و شیر — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 18,
    'breakfast:9:نان،-کره-بادامزمینی،-موز-و-شیر:450', '[{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"کره بادام‌زمینی","amount":"۱۵ گرم","household":"۱ قاشق غذاخوری سرصاف"},{"name":"موز بدون پوست","amount":"۱۰۰ گرم","household":"۱ عدد کوچک"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"چهارپنجم لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: نان، کره و عسل با شیر (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نان، کره و عسل با شیر', 'compound', 'breakfast', NULL, 'breakfast:10:نان،-کره-و-عسل-با-شیر', 'نکته: این گزینه نسبت به صبحانه‌های تخم‌مرغی پروتئین کمتری دارد؛ هم‌کالری‌بودن به معنی هم‌پروتئین‌بودن نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره و عسل با شیر — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 13,
    'breakfast:10:نان،-کره-و-عسل-با-شیر:350', '[{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"کره","amount":"۱۰ گرم","household":"۲ قاشق چای‌خوری سرصاف"},{"name":"عسل","amount":"۱۵ گرم","household":"۲ قاشق چای‌خوری"},{"name":"شیر کم‌چرب","amount":"۲۵۰ میلی‌لیتر","household":"۱ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 14g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره و عسل با شیر — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 14,
    'breakfast:10:نان،-کره-و-عسل-با-شیر:400', '[{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"کره","amount":"۱۰ گرم","household":"۲ قاشق چای‌خوری سرصاف"},{"name":"عسل","amount":"۱۵ گرم","household":"۲ قاشق چای‌خوری"},{"name":"شیر کم‌چرب","amount":"۲۵۰ میلی‌لیتر","household":"۱ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره و عسل با شیر — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 16,
    'breakfast:10:نان،-کره-و-عسل-با-شیر:450', '[{"name":"نان","amount":"۸۵ گرم","household":"حدود ۳ کف دست"},{"name":"کره","amount":"۱۰ گرم","household":"۲ قاشق چای‌خوری سرصاف"},{"name":"عسل","amount":"۱۵ گرم","household":"۲ قاشق چای‌خوری"},{"name":"شیر کم‌چرب","amount":"۲۵۰ میلی‌لیتر","household":"۱ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: اوتمیل با شیر و میوه (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('اوتمیل با شیر و میوه', 'compound', 'breakfast', NULL, 'breakfast:11:اوتمیل-با-شیر-و-میوه', 'روش تهیه: جو دوسر با شیر پخته یا از شب قبل خیسانده شود. برای رقیق‌ترشدن می‌توان آب اضافه کرد؛ کالری تغییر نمی‌کند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 15g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'اوتمیل با شیر و میوه — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 15,
    'breakfast:11:اوتمیل-با-شیر-و-میوه:350', '[{"name":"جو دوسر پرک خشک","amount":"۴۰ گرم","household":"نصف پیمانه"},{"name":"شیر کم‌چرب","amount":"۲۵۰ میلی‌لیتر","household":"۱ لیوان"},{"name":"موز بدون پوست","amount":"۹۰ گرم","household":"۱ موز کوچک، کمی کمتر از کامل"},{"name":"دارچین یا وانیل بدون شکر","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'اوتمیل با شیر و میوه — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 16,
    'breakfast:11:اوتمیل-با-شیر-و-میوه:400', '[{"name":"جو دوسر پرک خشک","amount":"۵۵ گرم","household":"حدود دوسوم پیمانه"},{"name":"شیر کم‌چرب","amount":"۲۵۰ میلی‌لیتر","household":"۱ لیوان"},{"name":"موز بدون پوست","amount":"۸۵ گرم","household":"حدود چهارپنجم موز کوچک"},{"name":"دارچین یا وانیل بدون شکر","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'اوتمیل با شیر و میوه — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 18,
    'breakfast:11:اوتمیل-با-شیر-و-میوه:450', '[{"name":"جو دوسر پرک خشک","amount":"۶۵ گرم","household":"حدود چهارپنجم پیمانه"},{"name":"شیر کم‌چرب","amount":"۲۵۰ میلی‌لیتر","household":"۱ لیوان"},{"name":"موز بدون پوست","amount":"۱۰۰ گرم","household":"۱ موز کوچک"},{"name":"دارچین یا وانیل بدون شکر","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
