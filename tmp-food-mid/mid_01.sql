DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  
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

  -- Base food: کوکوی سبزی، خیار و گوجه (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کوکوی سبزی، خیار و گوجه', 'compound', 'breakfast', NULL, 'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه', 'روش پخت: فرپز یا تابهٔ نچسب با روغن کم. تعداد تکه‌ها تقریبی است؛ ضخامت کوکو بسیار اثر دارد. این اعداد برای کوکوی سرخ‌شده با روغن زیاد معتبر نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی، خیار و گوجه — 150 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '150 کالری', 150, 9,
    'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه:150', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 350 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی، خیار و گوجه — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 21,
    'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه:350', '[{"name":"کوکوی سبزی آماده","amount":"۲۲۰ گرم","household":"حدود ۴ تکهٔ ۵۵ گرمی"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی، خیار و گوجه — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 24,
    'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه:400', '[{"name":"کوکوی سبزی آماده","amount":"۲۵۵ گرم","household":"حدود ۵ تکهٔ ۵۰ گرمی"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی، خیار و گوجه — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 27,
    'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه:450', '[{"name":"کوکوی سبزی آماده","amount":"۲۸۵ گرم","household":"حدود ۵ تکهٔ ۵۵–۶۰ گرمی"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: حلیم (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('حلیم', 'compound', 'breakfast', NULL, 'breakfast:13:حلیم', 'نکته: حلیم بیرون ممکن است گوشت کمتر یا چربی بیشتری داشته باشد؛ این اعداد برای همهٔ حلیم‌های آماده یکسان نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 120 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'حلیم — 120 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '120 کالری', 120, 7,
    'breakfast:13:حلیم:120', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 350 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'حلیم — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 20,
    'breakfast:13:حلیم:350', '[{"name":"حلیم آماده","amount":"۲۹۰ گرم","household":"کمی بیشتر از ۱ کاسهٔ متوسط ۲۵۰ گرمی"},{"name":"دارچین","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'حلیم — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 23,
    'breakfast:13:حلیم:400', '[{"name":"حلیم آماده","amount":"۳۳۵ گرم","household":"حدود ۱⅓ کاسهٔ متوسط"},{"name":"دارچین","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'حلیم — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 26,
    'breakfast:13:حلیم:450', '[{"name":"حلیم آماده","amount":"۳۷۵ گرم","household":"حدود ۱٫۵ کاسهٔ متوسط"},{"name":"دارچین","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: شیربرنج با پودر پروتئین (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیربرنج با پودر پروتئین', 'compound', 'breakfast', NULL, 'breakfast:14:شیربرنج-با-پودر-پروتئین', 'روش تهیه: پودر را ابتدا با کمی آب یا مقداری از خود شیربرنج مخلوط کن و پس از کمی خنک‌شدن، به ظرف اضافه کن تا گلوله نشود. شیرِ اضافه برای حل‌کردن پودر، باید جداگانه محاسبه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 110 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '110 کالری', 110, 5,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:110', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 80 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 80 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '80 کالری', 80, 16,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:80', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 350 cal, 25g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 25,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:350', '[{"name":"شیربرنج آماده","amount":"۲۴۵ گرم","household":"۱ کاسهٔ متوسط"},{"name":"پودر پروتئین","amount":"۲۰ گرم","household":"دوسوم پیمانه، فقط اگر پیمانهٔ محصول ۳۰ گرمی باشد"},{"name":"دارچین، هل یا گلاب بدون شکر","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 26,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:400', '[{"name":"شیربرنج آماده","amount":"۲۹۰ گرم","household":"کمی بیشتر از ۱ کاسهٔ متوسط"},{"name":"پودر پروتئین","amount":"۲۰ گرم","household":"دوسوم پیمانهٔ ۳۰ گرمی"},{"name":"دارچین، هل یا گلاب بدون شکر","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 28,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:450', '[{"name":"شیربرنج آماده","amount":"۳۳۵ گرم","household":"حدود ۱⅓ کاسهٔ متوسط"},{"name":"پودر پروتئین","amount":"۲۰ گرم","household":"دوسوم پیمانهٔ ۳۰ گرمی"},{"name":"دارچین، هل یا گلاب بدون شکر","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: لوبیا گرم و نان (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('لوبیا گرم و نان', 'compound', 'breakfast', NULL, 'breakfast:15:لوبیا-گرم-و-نان', 'خوراک لوبیا چیتی نسبتاً غلیظ با رب، پیاز و روغن کم؛ بدون سیب‌زمینی. حدود ۱۱۵ کالری و ۷ گرم پروتئین در ۱۰۰ گرم. روغن داخل همین برآورد لحاظ شده است. لیست نهار: مبنای اندازه‌گیری و محاسبه در تمام نسخه‌های زیر، این همراه در کالری و پروتئین کل حساب شده است:')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا گرم و نان — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 18,
    'breakfast:15:لوبیا-گرم-و-نان:350', '[{"name":"خوراک لوبیا آماده","amount":"۲۰۰ گرم","household":"۱ پیمانه یا ۱ کاسهٔ متوسط کم‌پُر"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"آب‌لیمو و ادویه","amount":"به مقدار دلخواه، بدون شکر","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا گرم و نان — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 20,
    'breakfast:15:لوبیا-گرم-و-نان:400', '[{"name":"خوراک لوبیا آماده","amount":"۲۰۰ گرم","household":"۱ پیمانه یا ۱ کاسهٔ متوسط کم‌پُر"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"آب‌لیمو و ادویه","amount":"به مقدار دلخواه، بدون شکر","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا گرم و نان — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 22,
    'breakfast:15:لوبیا-گرم-و-نان:450', '[{"name":"خوراک لوبیا آماده","amount":"۲۰۰ گرم","household":"۱ پیمانه یا ۱ کاسهٔ متوسط کم‌پُر"},{"name":"نان","amount":"۸۵ گرم","household":"حدود ۳ کف دست"},{"name":"آب‌لیمو و ادویه","amount":"به مقدار دلخواه، بدون شکر","household":null},{"name":"سالاد","amount":"۱۰۰ گرم","household":"۱ لیوان خردشده"},{"name":"ماست کم‌چرب","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف یا ۱ کاسهٔ کوچک کم‌پُر"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 80 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا گرم و نان — 80 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '80 کالری', 80, 5,
    'breakfast:15:لوبیا-گرم-و-نان:80', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کباب تابه‌ای با برنج یا نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کباب تابه‌ای با برنج یا نان', 'compound', 'lunch', NULL, 'lunch:1:کباب-تابهای-با-برنج-یا-نان', 'با انتخاب نان، پروتئین نسخه‌ها حدود ۳۳، ۳۵ و ۳۷ گرم است. نان و برنج، جایگزین یکدیگرند؛ نه اینکه هر دو مصرف شوند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 240 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با برنج یا نان — 240 کالری', 'compound', 'lunch', NULL,
    v_base_id, '240 کالری', 240, 24,
    'lunch:1:کباب-تابهای-با-برنج-یا-نان:240', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 32g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با برنج یا نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 32,
    'lunch:1:کباب-تابهای-با-برنج-یا-نان:450', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست یا ۲ قطعهٔ ۵۰ گرمی"},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق غذاخوری سرصاف"},{"name":"جایگزین برنج","amount":"نان ۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با برنج یا نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 33,
    'lunch:1:کباب-تابهای-با-برنج-یا-نان:500', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"برنج","amount":"۱۴۰ گرم","household":"۱۴ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان ۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 34g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با برنج یا نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 34,
    'lunch:1:کباب-تابهای-با-برنج-یا-نان:550', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"برنج","amount":"۱۸۰ گرم","household":"۱۸ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان ۹۰ گرم","household":"۳ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: جوجه‌کباب با نان یا برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('جوجه‌کباب با نان یا برنج', 'compound', 'lunch', NULL, 'lunch:2:جوجهکباب-با-نان-یا-برنج', 'جوجه از سینهٔ مرغ بدون پوست؛ بدون کرهٔ روی کباب. روغن نوشته‌شده، سهم کل پخت و مزه‌دارکردن همان وعده است. با نان، پروتئین نسخه‌ها حدود ۴۶، ۴۸ و ۵۰ گرم است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 45g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'جوجه‌کباب با نان یا برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 45,
    'lunch:2:جوجهکباب-با-نان-یا-برنج:450', '[{"name":"جوجه‌کباب پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان ۵۰ گرم","household":"۱⅔ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 46g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'جوجه‌کباب با نان یا برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 46,
    'lunch:2:جوجهکباب-با-نان-یا-برنج:500', '[{"name":"جوجه‌کباب پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۱۳۵ گرم","household":"۱۳½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۷۰ گرم","household":"۲⅓ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 47g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'جوجه‌کباب با نان یا برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 47,
    'lunch:2:جوجهکباب-با-نان-یا-برنج:550', '[{"name":"جوجه‌کباب پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۱۷۵ گرم","household":"۱۷½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۹۰ گرم","household":"۳ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خوراک مرغ و قارچ با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خوراک مرغ و قارچ با برنج', 'compound', 'lunch', NULL, 'lunch:3:خوراک-مرغ-و-قارچ-با-برنج', 'بدون خامه، پنیر و کره؛ مرغ و قارچ جدا وزن می‌شوند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 42g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 42,
    'lunch:3:خوراک-مرغ-و-قارچ-با-برنج:450', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"پیاز پخته در خوراک","amount":"۲۰ گرم","household":"۱ قاشق غذاخوری پُر"},{"name":"برنج","amount":"۹۵ گرم","household":"۹½ قاشق سرصاف"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 43g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 43,
    'lunch:3:خوراک-مرغ-و-قارچ-با-برنج:500', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":null},{"name":"پیاز پخته","amount":"۲۰ گرم","household":null},{"name":"برنج","amount":"۱۳۵ گرم","household":"۱۳½ قاشق سرصاف"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 44g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 44,
    'lunch:3:خوراک-مرغ-و-قارچ-با-برنج:550', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":null},{"name":"پیاز پخته","amount":"۲۰ گرم","household":null},{"name":"برنج","amount":"۱۷۵ گرم","household":"۱۷½ قاشق سرصاف"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خوراک مرغ و قارچ با نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خوراک مرغ و قارچ با نان', 'compound', 'lunch', NULL, 'lunch:4:خوراک-مرغ-و-قارچ-با-نان', NULL)
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 43g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 43,
    'lunch:4:خوراک-مرغ-و-قارچ-با-نان:450', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"پیاز پخته","amount":"۲۰ گرم","household":"۱ قاشق غذاخوری پُر"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 45g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 45,
    'lunch:4:خوراک-مرغ-و-قارچ-با-نان:500', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":null},{"name":"پیاز پخته","amount":"۲۰ گرم","household":null},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 47g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 47,
    'lunch:4:خوراک-مرغ-و-قارچ-با-نان:550', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":null},{"name":"پیاز پخته","amount":"۲۰ گرم","household":null},{"name":"نان","amount":"۹۰ گرم","household":"۳ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: مرغ و برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('مرغ و برنج', 'compound', 'lunch', NULL, 'lunch:5:مرغ-و-برنج', 'سینهٔ مرغ بدون پوست، آب‌پز، فرپز یا تابه‌ای؛ بدون سس چرب. نکته: ران مرغ و مرغ با پوست، از نظر کالری جایگزین مستقیم همین مقدار سینه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 45g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مرغ و برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 45,
    'lunch:5:مرغ-و-برنج:450', '[{"name":"مرغ پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"روغن سهم پخت","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 46g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مرغ و برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 46,
    'lunch:5:مرغ-و-برنج:500', '[{"name":"مرغ پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۱۳۵ گرم","household":"۱۳½ قاشق سرصاف"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 47g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مرغ و برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 47,
    'lunch:5:مرغ-و-برنج:550', '[{"name":"مرغ پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۱۷۵ گرم","household":"۱۷½ قاشق سرصاف"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
