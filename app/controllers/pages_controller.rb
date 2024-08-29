class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @current_page = 'home'
    @product = Product.new
    if Order.any?
      @order = Order.last
    else
      @order = Order.create(total_price: 0)
    end
  end

  def creators
    @ali = {
      github_url: "https://github.com/alinumbercrunch",
      github_username: "alinumbercrunch",
      name: "Ali",
      cute_name: "Ali <br> ૮ ᴖﻌᴖა",
      image_url: "https://res.cloudinary.com/dxarsyyur/image/upload/v1724901852/74129604_krtcuw.jpg",
      title: "Backend Lead",
      linkedin: "https://www.linkedin.com/in/ali-h-a22178109/"
    }
    @mint = {
      github_url: "https://github.com/Sadanan-V",
      github_username: "Sadanan-V",
      name: "Mint",
      cute_name: "Sadanan <br> ʕ•ᴥ•ʔ",
      image_url: "https://res.cloudinary.com/dxarsyyur/image/upload/v1724902591/DSC01569_fcdopq.jpg",
      title: "Frontend Lead",
      linkedin: "https://www.linkedin.com/in/%F0%9F%AA%90sadanan-vorlaruxtara%F0%9F%AA%90-071a39110/"
    }
    @eri = {
      github_url: "https://github.com/eyawata",
      github_username: "eyawata",
      name: "Eri",
      cute_name: "Eri <br> ≽^•⩊•^≼",
      image_url: "https://res.cloudinary.com/djqladxhq/image/upload/v1724902487/photo_2024-08-29_12-34-23_qfwpm6.jpg",
      title: "Development Lead",
      linkedin: "https://www.linkedin.com/in/eriyawata/"
    }
    @jonas = {
      github_url: "https://github.com/Jonas-09",
      github_username: "Jonas-09",
      name: "Jonas",
      cute_name: "Jonas <br> ૮ ˙Ⱉ˙ ა",
      image_url: "https://res.cloudinary.com/dxarsyyur/image/upload/v1724911441/798CE1B1-B165-41E1-8FF2-95623CFDBFAB_1_105_c_udfhuv_fhmacj.jpg",
      title: "Project Manager",
      linkedin: "https://www.linkedin.com/in/jonas-al-taher/"
    }
    @members = [@ali, @mint, @eri, @jonas]
  end
end
