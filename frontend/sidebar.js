function initSidebar() {
  // Insert sidebar HTML at the top of body
  document.body.insertAdjacentHTML('afterbegin', `
    <aside id="sidebar">
      <h2>Categories</h2>
      <ul id="sidebarCategories"></ul>
    </aside>
  `);

  // ---------- Sidebar toggle ----------
  const sidebarToggle = document.getElementById('sidebarToggle');
  const sidebar = document.getElementById('sidebar');
  sidebarToggle.addEventListener('click', () => sidebar.classList.toggle('open'));
  document.addEventListener('click', e => {
    if (!sidebar.contains(e.target) && !sidebarToggle.contains(e.target)) sidebar.classList.remove('open');
  });

  // ---------- User auth links ----------
  const authLinks = document.getElementById("authLinks");
  const user = JSON.parse(localStorage.getItem("user"));
  const defaultProfile = "pp.jpg";
  if(user && user.name){
    const profileImage = user.image ? user.image : defaultProfile;
    authLinks.innerHTML = `<a href="userprofile.html" style="text-decoration:none;color:#222;font-weight:600;">
      <img src="${profileImage}" alt="Profile" style="width:32px;height:32px;border-radius:50%;vertical-align:middle;">${user.name.split(" ")[0]}</a>`;
  } else {
    authLinks.innerHTML = `<a href="login.html" style="text-decoration:none;color:#222;font-weight:600;">Login</a>`;
  }

  // ---------- Selected categories ----------
  let selectedCategories = new Set();

  // ---------- Load sidebar categories ----------
  async function loadSidebarCategories() {
    try {
      const res = await fetch("http://localhost:3000/api/categories");
      const categories = await res.json();
      const container = document.getElementById("sidebarCategories");

      const map = {};
      categories.forEach(cat => {
        const parentId = cat.parent_id ?? 0;
        if (!map[parentId]) map[parentId] = [];
        map[parentId].push(cat);
      });

      function createList(parentId) {
        if (!map[parentId]) return null;
        const ul = document.createElement('ul');
        map[parentId].forEach(cat => {
          const li = document.createElement('li');

          const box = document.createElement('div');
          box.classList.add('category-box');
          box.dataset.id = cat.category_id;

          const a = document.createElement('a');
          a.textContent = cat.category_name;

          const toggleSelection = () => {
            if(selectedCategories.has(cat.category_id)){
              selectedCategories.delete(cat.category_id);
              box.classList.remove('active');
            } else {
              selectedCategories.add(cat.category_id);
              box.classList.add('active');
            }
            loadProducts();
          };

          box.addEventListener('click', e => { e.stopPropagation(); toggleSelection(); });
          a.addEventListener('click', e => { e.preventDefault(); toggleSelection(); });

          li.appendChild(box);
          li.appendChild(a);

          const childrenUl = createList(cat.category_id);
          if(childrenUl) li.appendChild(childrenUl);

          ul.appendChild(li);
        });
        return ul;
      }

      const topUl = createList(0);
      if(topUl) container.appendChild(topUl);

    } catch(err) {
      console.error("Error loading sidebar categories:", err);
    }
  }

  // ---------- Load products ----------
  async function loadProducts() {
    try {
      const productGrid = document.getElementById("product-grid");
      if(!productGrid) return;

      productGrid.innerHTML = "";

      if(selectedCategories.size === 0) {
        productGrid.innerHTML = "<p>Please select a category.</p>";
        return;
      }

      const addedProducts = new Set();
      let displayIndex = 0;

      for(const categoryId of selectedCategories) {
        const res = await fetch(`http://localhost:3000/api/products?category_id=${categoryId}`);
        const data = await res.json();
        if(!data.success) continue;

        data.products.forEach(product => {
          if (addedProducts.has(product.product_id)) return;
          addedProducts.add(product.product_id);

          const card = document.createElement("div");
          card.classList.add("product-card");
          if(displayIndex % 3 === 0) card.classList.add("from-left");
          else if(displayIndex % 3 === 1) card.classList.add("from-bottom");
          else card.classList.add("from-right");

          const imageUrl = product.images?.length > 0 
            ? product.images[0] 
            : 'http://localhost:3000/Products/default.jpg';

          card.innerHTML = `
            <a href="viewProduct.html?id=${product.product_id}" style="display:block;">
              <img src="${imageUrl}" alt="${product.name}" />
            </a>
            <h3>${product.name}</h3>
            <span>৳ ${product.price}</span>
          `;
          productGrid.appendChild(card);
          displayIndex++;
        });
      }

      // Scroll animation
      const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
          if(entry.isIntersecting) entry.target.classList.add("show");
        });
      }, { threshold: 0.15 });
      document.querySelectorAll(".product-card").forEach(card => observer.observe(card));

    } catch(err) {
      console.error("Error loading products:", err);
    }
  }

  // Initial load
  loadSidebarCategories();
}
document.addEventListener('DOMContentLoaded', initSidebar);
