class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.2"
    checksums = {
        "darwin_arm64" => "8da6593a4bbaf05472821a6d9295356ee7fcec82e578ded718ee1931522fc90d",
        "darwin_amd64" => "25c5632a1fd24aa587137ddd879e3e9a727e2fce041c390c84f42e7f16d85118",
        "linux_arm64"  => "d2068b43d98bfb507031cda4626e7ef820d1d631bc4860a78bdca6eb4a2b2770",
        "linux_amd64"  => "1f84f35c1e71af5593e4053f43783d521c59672d90a498a7f925e5de3441f12d",
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
