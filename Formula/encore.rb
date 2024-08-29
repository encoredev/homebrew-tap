class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.39.8"
    checksums = {
        "darwin_arm64" => "c27aa184aad5fcb25bf8607318db3eef2bc5e5710b597912ec1109c0b750c023",
        "darwin_amd64" => "01b21c69af6dfdab0df652baed211803003f2ed10e412886d8560f44eeafaf52",
        "linux_arm64"  => "edd9b5712af9efc83405ae07695614ac9dd92173bfe48f0611992663653092e4",
        "linux_amd64"  => "24316016ca3633acc64844e597b47bbbf763ed3bd46e25eb6406700e238f0820",
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
