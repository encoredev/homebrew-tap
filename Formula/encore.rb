class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.6"
    checksums = {
        "darwin_arm64" => "7de71bac28890691932874999efa1693cc9932d38bd3976a7fc5013d9dd86198",
        "darwin_amd64" => "9e0d1098f9fe448d3231c588b03f9db56913e8166f3d35988683d99108931085",
        "linux_arm64"  => "c914bc3a39f174af5c62813b02806b3918f365131e44358cb83809a271e33830",
        "linux_amd64"  => "95b8f22dc6eda4ef9a3f1f0b3049fb27c2d466a5d40fc21c46b5e02a20ddac96",
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
