class Navigation extends React.Component {
  constructor(props) {
    super(props);
  }

  render () {
    return (
      <nav className="navbar navbar-default menu-navbar">
        <div className="container">

          <div className="navbar-header">
            <div className="navbar-toggle cart-box pull-right">
              <a className="cart-btn" href={this.props.accountPath}>
                <i className="fa fa-shopping-cart"></i>
                <span>{this.props.cartQuantity}</span>
              </a>
            </div>

            <div className="navbar-toggle account-box pull-right">
              <a className="account-btn" href={this.props.accountPath}>
                <i className="fa fa-user"></i>
                <span>Account</span>
              </a>
            </div>

            <button className="m-pikabu-nav-toggle navbar-toggle pull-left nav-bars" data-role="left" type="button">
              <i className="fa fa-bars"></i>
              <span>MENU</span>
            </button>
          </div>

          <div className="collapse navbar-collapse navbar-responsive-collapse">
            <ul className="nav navbar-nav">
              {this.props.navLinks.map((n) => (
                <li><a href={n.url}>{n.name}</a></li>
              ))}
            </ul>
            <ul className="nav navbar-nav navbar-right hidden-xs">
              <li>
                <a className="account-btn" href={this.props.accountPath}>
                  <i className="fa fa-user"></i>
                  <span>Account</span>
                </a>
              </li>
            </ul>
          </div>

        </div>
      </nav>
    )
  }
}

Navigation.propTypes = {
  navLinks: React.PropTypes.array,
  cartQuantity: React.PropTypes.number,
  cartPath: React.PropTypes.string,
  accountPath: React.PropTypes.string,
};
