class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.36.4"
    checksums = {
        "darwin_arm64" => "52d13be3ed8ba0a3d682c3609ec3e87d420e07684f2af13ef578137762725abb",
        "darwin_amd64" => "051e25e6c912d72a5ea0b18b3559fe5430d5a9f6ae35d76e710f0222e64c56a6",
        "linux_arm64"  => "b648267e2a0c08b81581ec8621cc66106b3819ab76e6d2f652f45f68c3bdb47d",
        "linux_amd64"  => "d9a1b1f01af6038bfeb419f7b9bff8dec8ba986144b8954a35acf02f21bbad3c",
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
