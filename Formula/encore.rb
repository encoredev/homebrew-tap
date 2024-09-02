class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.40.0"
    checksums = {
        "darwin_arm64" => "2befeed4f4763a271241d8df33b2ca970b5de92b39653c14a7c19e4da4258c98",
        "darwin_amd64" => "5061967166bebc8fff0cb8a15852d3c3f75b1af18fe3814dd3e1b02a6dfbbc11",
        "linux_arm64"  => "39e33e495773b98945947faa89a82da59cd433f2787c033e1fd141bac142807e",
        "linux_amd64"  => "251d2ffbcbec08872726bb095cced253a8623407d5be716b7021e33d62f0edb3",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
