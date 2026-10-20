class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.8"
    checksums = {
        "darwin_arm64" => "a4f2c4b9f4090a15dfe44a6b06867814a3249bb7089a4b722cfa45cf62fdd730",
        "darwin_amd64" => "281db3ff7b89afa27c54368b741bb6f1f1e2f8512c5c559b286953bd500807bf",
        "linux_arm64"  => "d012e43079fbfc0ebf7a1928c6831066dff7a043f1d1f6c873bc008695193d0c",
        "linux_amd64"  => "449eb4556fc87c0bfada68d5b3034dc368882ccbbd19910c574ef42096807b2a",
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
