class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.3"
    checksums = {
        "darwin_arm64" => "75daf62fb0eb4ac10935b80d621ea9698206cf7b3939a06bccaef007fb4efefb",
        "darwin_amd64" => "2dc1b050acb92c6bf8cf84de3bd90f8898df223d1921406d341312b1ad8584a0",
        "linux_arm64"  => "764281ffb998ea802a2969f41d4ea255c44eadc01d16b8bd0bfd2e416cf4cd77",
        "linux_amd64"  => "b0770af914d7782c0567408d1b9344a3d5cd2d87fe96c45ac5e7c821bebd36f6",
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
